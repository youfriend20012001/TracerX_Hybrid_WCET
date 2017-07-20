//===-- TxValues.cpp --------------------------------------------*- C++ -*-===//
//
//               The Tracer-X KLEE Symbolic Virtual Machine
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file contains the implementations of the classes related to values in
/// the symbolic execution state and interpolant table. Values that belong to
/// the interpolant are versioned such as TxStateAddress, which is distinguished
/// by its base address, and TxStateValue, which is distinguished by its
/// version, and TxStateValue, which is distinguished by its own object id.
///
//===----------------------------------------------------------------------===//

#include "ShadowArray.h"
#include "TxPrintUtil.h"

#include "klee/Internal/Module/TxValues.h"
#include "klee/Internal/Support/ErrorHandling.h"

#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
#include <llvm/IR/Type.h>
#else
#include <llvm/Type.h>
#endif

using namespace klee;

namespace klee {

ref<AllocationContext> AllocationContext::create(
    llvm::Value *_value, const std::vector<llvm::Instruction *> &_callHistory) {
  Type ty = GLOBAL;

  if (llvm::Instruction *inst = llvm::dyn_cast<llvm::Instruction>(_value)) {
    if (inst->getParent() && inst->getParent()->getParent()) {
      // Heap-allocated memory is considered global, and to be recorded in
      // global frame. Here we test if the allocation was a call to *alloc and
      // getenv functions.
      if (llvm::CallInst *ci = llvm::dyn_cast<llvm::CallInst>(inst)) {
        // Here we determine if this was a call to *alloc or getenv functions
        // from the LLVM source of the call instruction instead of
        // llvm::Function::getName(). This is to circumvent segmentation fault
        // issue when libc is not linked.
        std::string buf;
        llvm::raw_string_ostream stream(buf);
        ci->print(stream);
        stream.flush();
        if (buf.find("@malloc(") != std::string::npos ||
            buf.find("@realloc(") != std::string::npos ||
            buf.find("@calloc(") != std::string::npos) {
          ty = HEAP;
        } else if (buf.find("@getenv(") != std::string::npos) {
          ty = GLOBAL;
        }
      } else {
        ty = LOCAL;
      }
    }
  }

  ref<AllocationContext> ret(new AllocationContext(ty, _value, _callHistory));
  return ret;
}

void AllocationContext::print(llvm::raw_ostream &stream,
                              const std::string &prefix) const {
  std::string tabs = makeTabs(1);
  if (value) {
    stream << prefix << "Location: ";
    value->print(stream);
    switch (ty) {
    case LOCAL:
      stream << " (local)";
      break;
    case GLOBAL:
      stream << " (global)";
      break;
    case HEAP:
      stream << " (heap)";
      break;
    default:
      break;
    }
  }
  if (callHistory.size() > 0) {
    stream << "\n" << prefix << "Call history:";
    for (std::vector<llvm::Instruction *>::const_iterator
             it = callHistory.begin(),
             ie = callHistory.end();
         it != ie; ++it) {
      stream << "\n" << tabs << prefix;
      (*it)->print(stream);
    }
  }
}

/**/

void TxInterpolantAddress::print(llvm::raw_ostream &stream,
                                 const std::string &prefix) const {
  std::string tabsNext = appendTab(prefix);

  stream << prefix << "indirection: ";
  if (indirectionCount == 0)
    stream << "(none)";
  else {
    for (uint64_t i = 0; i < indirectionCount; ++i) {
      stream << "*";
    }
  }
  stream << "\n" << prefix << "function/value: ";
  if (outputFunctionName(context->getValue(), stream))
    stream << "/";
  context->getValue()->print(stream);
  stream << "\n";

  stream << prefix << "stack:\n";
  for (std::vector<llvm::Instruction *>::const_reverse_iterator
           it = context->getCallHistory().rbegin(),
           ib = it, ie = context->getCallHistory().rend();
       it != ie; ++it) {
    stream << tabsNext;
    (*it)->print(stream);
    stream << "\n";
  }
  stream << prefix << "offset";
  if (!llvm::isa<ConstantExpr>(this->offset))
    stream << " (symbolic)";
  stream << ": ";
  offset->print(stream);
}

/**/

void TxInterpolantValue::init(llvm::Value *_value, ref<Expr> _expr,
                              bool canInterpolateBound,
                              const std::set<std::string> &_coreReasons,
                              const std::set<ref<TxStateAddress> > _locations,
                              std::set<const Array *> &replacements,
                              bool shadowing) {
  refCount = 0;
  id = reinterpret_cast<uintptr_t>(this);
  expr =
      shadowing ? ShadowArray::getShadowExpression(_expr, replacements) : _expr;
  value = _value;

  doNotUseBound = !canInterpolateBound;

  coreReasons = _coreReasons;

  for (std::set<ref<TxStateAddress> >::const_iterator it = _locations.begin(),
                                                      ie = _locations.end();
       it != ie; ++it) {
    ref<AllocationContext> context =
        (*it)->getContext(); // The allocation context

    ref<Expr> offset =
        shadowing
            ? ShadowArray::getShadowExpression((*it)->getOffset(), replacements)
            : (*it)->getOffset();

    // We next build the offsets to be compared against stored allocation
    // offset bounds
    ConstantExpr *oe = llvm::dyn_cast<ConstantExpr>(offset);
    if (oe && !allocationOffsets[context].empty()) {
      // Here we check if smaller offset exists, in which case we replace it
      // with the new offset; as we want the greater offset to possibly
      // violate an offset bound.
      std::set<ref<Expr> > res;
      uint64_t offsetInt = oe->getZExtValue();
      for (std::set<ref<Expr> >::iterator
               it1 = allocationOffsets[context].begin(),
               ie1 = allocationOffsets[context].end();
           it1 != ie1; ++it1) {
        if (ConstantExpr *ce = llvm::dyn_cast<ConstantExpr>(*it1)) {
          uint64_t c = ce->getZExtValue();
          if (offsetInt > c) {
            res.insert(offset);
            continue;
          }
        }
        res.insert(*it1);
      }
      allocationOffsets[context] = res;
    } else {
      allocationOffsets[context].insert(offset);
    }
  }

  if (doNotUseBound)
    return;

  if (!_locations.empty()) {
    // Here we compute memory bounds for checking pointer values. The memory
    // bound is the size of the allocation minus the offset; this is the weakest
    // precondition (interpolant) of memory bound checks done by KLEE.
    for (std::set<ref<TxStateAddress> >::const_iterator it = _locations.begin(),
                                                        ie = _locations.end();
         it != ie; ++it) {
      ref<AllocationContext> context =
          (*it)->getContext(); // The allocation site

      // Concrete bound
      uint64_t concreteBound = (*it)->getConcreteOffsetBound();
      std::set<ref<Expr> > newBounds;

      if (concreteBound > 0)
        allocationBounds[context].insert(Expr::createPointer(concreteBound));

      // Symbolic bounds
      const std::set<ref<Expr> > &bounds = (*it)->getSymbolicOffsetBounds();

      if (shadowing) {
        std::set<ref<Expr> > shadowBounds;
        for (std::set<ref<Expr> >::const_iterator it1 = bounds.begin(),
                                                  ie1 = bounds.end();
             it1 != ie1; ++it1) {
          shadowBounds.insert(
              ShadowArray::getShadowExpression(*it1, replacements));
        }
        if (!shadowBounds.empty()) {
          allocationBounds[context]
              .insert(shadowBounds.begin(), shadowBounds.end());
        }
      } else if (!bounds.empty()) {
        allocationBounds[context].insert(bounds.begin(), bounds.end());
      }
    }
  }
}

ref<Expr> TxInterpolantValue::getBoundsCheck(ref<TxInterpolantValue> stateValue,
                                             std::set<ref<Expr> > &bounds,
                                             int debugSubsumptionLevel) const {
  ref<Expr> res;
#ifdef ENABLE_Z3

  // In principle, for a state to be subsumed, the subsuming state must be
  // weaker, which in this case means that it should specify less allocations,
  // so all allocations in the subsuming (this), should be specified by the
  // subsumed (the stateValue argument), and we iterate over allocation of
  // the current object and for each such allocation, retrieve the
  // information from the argument object; in this way resulting in
  // less iterations compared to doing it the other way around.
  bool matchFound = false;
  for (std::map<ref<AllocationContext>, std::set<ref<Expr> > >::const_iterator
           it = allocationBounds.begin(),
           ie = allocationBounds.end();
       it != ie; ++it) {
    std::set<ref<Expr> > tabledBounds = it->second;
    std::map<ref<AllocationContext>, std::set<ref<Expr> > >::iterator iter =
        stateValue->allocationOffsets.find(it->first);
    if (iter == stateValue->allocationOffsets.end()) {
      continue;
    }
    matchFound = true;

    std::set<ref<Expr> > stateOffsets = iter->second;

    assert(!tabledBounds.empty() && "tabled bounds empty");

    if (stateOffsets.empty()) {
      if (debugSubsumptionLevel >= 3) {
        std::string msg;
        llvm::raw_string_ostream stream(msg);
        it->first->print(stream);
        stream.flush();
        klee_message("No offset defined in state for %s", msg.c_str());
      }
      return ConstantExpr::create(0, Expr::Bool);
    }

    for (std::set<ref<Expr> >::const_iterator it1 = stateOffsets.begin(),
                                              ie1 = stateOffsets.end();
         it1 != ie1; ++it1) {
      for (std::set<ref<Expr> >::const_iterator it2 = tabledBounds.begin(),
                                                ie2 = tabledBounds.end();
           it2 != ie2; ++it2) {
        if (ConstantExpr *tabledBound = llvm::dyn_cast<ConstantExpr>(*it2)) {
          uint64_t tabledBoundInt = tabledBound->getZExtValue();
          if (ConstantExpr *stateOffset = llvm::dyn_cast<ConstantExpr>(*it1)) {
            if (tabledBoundInt > 0) {
              uint64_t stateOffsetInt = stateOffset->getZExtValue();
              if (stateOffsetInt >= tabledBoundInt) {
                if (debugSubsumptionLevel >= 3) {
                  std::string msg;
                  llvm::raw_string_ostream stream(msg);
                  it->first->print(stream);
                  stream.flush();
                  klee_message("Offset %lu out of bound %lu for %s",
                               stateOffsetInt, tabledBoundInt, msg.c_str());
                }
                return ConstantExpr::create(0, Expr::Bool);
              } else {
                bounds.insert(*it2);
                continue;
              }
            }
          } else if (tabledBoundInt > 0) {
            // Symbolic state offset, but concrete tabled bound. Here the bound
            // is known (non-zero), so we create constraints
            if (res.isNull()) {
              res = UltExpr::create(*it1, *it2);
            } else {
              res = AndExpr::create(UltExpr::create(*it1, *it2), res);
            }
            bounds.insert(*it2);
          }
          continue;
        }
        // Create constraints for symbolic bounds
        if (res.isNull()) {
          res = UltExpr::create(*it1, *it2);
        } else {
          res = AndExpr::create(UltExpr::create(*it1, *it2), res);
        }
        bounds.insert(*it2);
      }
    }
  }

  // Bounds check successful if no constraints added
  if (res.isNull()) {
    if (matchFound)
      return ConstantExpr::create(1, Expr::Bool);
    else
      return ConstantExpr::create(0, Expr::Bool);
  }
#endif // ENABLE_Z3
  return res;
}

ref<Expr>
TxInterpolantValue::getOffsetsCheck(ref<TxInterpolantValue> stateValue,
                                    int debugSubsumptionLevel) const {
  ref<Expr> res;
#ifdef ENABLE_Z3

  // In principle, for a state to be subsumed, the subsuming state must be
  // weaker, which in this case means that it should specify less allocations,
  // so all allocations in the subsuming (this), should be specified by the
  // subsumed (the stateValue argument), and we iterate over allocation of
  // the current object and for each such allocation, retrieve the
  // information from the argument object; in this way resulting in
  // less iterations compared to doing it the other way around.
  bool matchFound = false;
  for (std::map<ref<AllocationContext>, std::set<ref<Expr> > >::const_iterator
           it = allocationOffsets.begin(),
           ie = allocationOffsets.end();
       it != ie; ++it) {
    std::set<ref<Expr> > tabledOffsets = it->second;
    std::map<ref<AllocationContext>, std::set<ref<Expr> > >::iterator iter =
        stateValue->allocationOffsets.find(it->first);
    if (iter == stateValue->allocationOffsets.end()) {
      continue;
    }
    matchFound = true;

    std::set<ref<Expr> > stateOffsets = iter->second;

    assert(!tabledOffsets.empty() && "tabled offsets empty");

    if (stateOffsets.empty()) {
      if (debugSubsumptionLevel >= 3) {
        std::string msg;
        llvm::raw_string_ostream stream(msg);
        it->first->print(stream);
        stream.flush();
        klee_message("No offset defined in state for %s", msg.c_str());
      }
      return ConstantExpr::create(0, Expr::Bool);
    }

    for (std::set<ref<Expr> >::const_iterator it1 = stateOffsets.begin(),
                                              ie1 = stateOffsets.end();
         it1 != ie1; ++it1) {
      for (std::set<ref<Expr> >::const_iterator it2 = tabledOffsets.begin(),
                                                ie2 = tabledOffsets.end();
           it2 != ie2; ++it2) {
        if (ConstantExpr *tabledOffset = llvm::dyn_cast<ConstantExpr>(*it2)) {
          uint64_t tabledOffsetInt = tabledOffset->getZExtValue();
          if (ConstantExpr *stateOffset = llvm::dyn_cast<ConstantExpr>(*it1)) {
            uint64_t stateOffsetInt = stateOffset->getZExtValue();
            if (stateOffsetInt != tabledOffsetInt) {
              if (debugSubsumptionLevel >= 3) {
                std::string msg;
                llvm::raw_string_ostream stream(msg);
                it->first->print(stream);
                stream.flush();
                klee_message("Offset %lu does not equal %lu for %s",
                             stateOffsetInt, tabledOffsetInt, msg.c_str());
              }
              return ConstantExpr::create(0, Expr::Bool);
            }
          }
        }

        // Create constraints for offset equalities
        if (res.isNull()) {
          res = EqExpr::create(*it1, *it2);
        } else {
          res = AndExpr::create(EqExpr::create(*it1, *it2), res);
        }
      }
    }
  }

  // Bounds check successful if no constraints added
  if (res.isNull()) {
    if (matchFound)
      return ConstantExpr::create(1, Expr::Bool);
    else
      return ConstantExpr::create(0, Expr::Bool);
  }
#endif // ENABLE_Z3
  return res;
}

void TxInterpolantValue::print(llvm::raw_ostream &stream) const {
  print(stream, "");
}

void TxInterpolantValue::print(llvm::raw_ostream &stream,
                               const std::string &prefix) const {
  std::string nextTabs = appendTab(prefix);

  if (!doNotUseBound && !allocationBounds.empty()) {
    stream << prefix << "BOUNDS:";
    for (std::map<ref<AllocationContext>, std::set<ref<Expr> > >::const_iterator
             it = allocationBounds.begin(),
             ie = allocationBounds.end();
         it != ie; ++it) {
      std::set<ref<Expr> > boundsSet = it->second;
      stream << "\n";
      stream << prefix << "[";
      it->first->print(stream);
      stream << "<={";
      for (std::set<ref<Expr> >::const_iterator it1 = it->second.begin(),
                                                is1 = it1,
                                                ie1 = it->second.end();
           it1 != ie1; ++it1) {
        if (it1 != is1)
          stream << ",";
        (*it1)->print(stream);
      }
      stream << "}]";
    }

    if (!allocationOffsets.empty()) {
      stream << "\n";
      stream << prefix << "OFFSETS:";
      for (std::map<ref<AllocationContext>,
                    std::set<ref<Expr> > >::const_iterator
               it = allocationOffsets.begin(),
               ie = allocationOffsets.end();
           it != ie; ++it) {
        std::set<ref<Expr> > boundsSet = it->second;
        stream << "\n";
        stream << prefix << "[";
        it->first->print(stream);
        stream << "=={";
        for (std::set<ref<Expr> >::const_iterator it1 = it->second.begin(),
                                                  is1 = it1,
                                                  ie1 = it->second.end();
             it1 != ie1; ++it1) {
          if (it1 != is1)
            stream << ",";
          (*it1)->print(stream);
        }
        stream << "}]";
      }
    }
  } else {
    stream << prefix;
    expr->print(stream);
  }

  if (!coreReasons.empty()) {
    stream << "\n";
    stream << prefix << "reason(s) for storage:\n";
    for (std::set<std::string>::const_iterator is = coreReasons.begin(),
                                               ie = coreReasons.end(), it = is;
         it != ie; ++it) {
      if (it != is)
        stream << "\n";
      stream << nextTabs << *it;
    }
  }
}

/**/

void TxStateAddress::adjustOffsetBound(ref<TxStateValue> checkedAddress,
                                       std::set<ref<Expr> > &_bounds) {
  std::set<ref<TxStateAddress> > locations = checkedAddress->getLocations();
  std::set<ref<Expr> > bounds(_bounds);

  if (bounds.empty()) {
    bounds.insert(Expr::createPointer(size));
  }

  for (std::set<ref<Expr> >::iterator it1 = bounds.begin(), ie1 = bounds.end();
       it1 != ie1; ++it1) {

    for (std::set<ref<TxStateAddress> >::iterator it2 = locations.begin(),
                                                  ie2 = locations.end();
         it2 != ie2; ++it2) {
      ref<Expr> checkedOffset = (*it2)->getOffset();
      if (ConstantExpr *c = llvm::dyn_cast<ConstantExpr>(checkedOffset)) {
        if (ConstantExpr *o = llvm::dyn_cast<ConstantExpr>(getOffset())) {
          if (ConstantExpr *b = llvm::dyn_cast<ConstantExpr>(*it1)) {
            uint64_t offsetInt = o->getZExtValue();
            uint64_t newBound =
                b->getZExtValue() - (c->getZExtValue() - offsetInt);

            if (concreteOffsetBound > newBound) {

              // FIXME: A quick hack to avoid assertion check to make DirSeek.c
              // regression test pass.
              llvm::Value *v = (*it2)->getContext()->getValue();
              if (v->getType()->isPointerTy()) {
                llvm::Type *elementType = v->getType()->getPointerElementType();
                if (elementType->isStructTy() &&
                    elementType->getStructName() == "struct.dirent") {
                  concreteOffsetBound = newBound;
                  continue;
                }
              }

              assert(newBound > offsetInt && "incorrect bound");
              concreteOffsetBound = newBound;
            }
            continue;
          }
        }
      }

      symbolicOffsetBounds.insert(
          SubExpr::create(*it1, SubExpr::create(checkedOffset, getOffset())));
    }
  }
}

ref<TxStateAddress>
TxStateAddress::create(ref<TxStateAddress> loc,
                       std::set<const Array *> &replacements) {
  ref<Expr> _address(
      ShadowArray::getShadowExpression(loc->address, replacements)),
      _base(ShadowArray::getShadowExpression(loc->base, replacements)),
      _offset(ShadowArray::getShadowExpression(loc->getOffset(), replacements));
  ref<TxStateAddress> ret(new TxStateAddress(loc->getContext(), _address, _base,
                                             _offset, loc->size));
  return ret;
}

void TxStateAddress::print(llvm::raw_ostream &stream,
                           const std::string &prefix) const {
  std::string tabsNext = appendTab(prefix);

  interpolantStyleAddress->print(stream, prefix);
  stream << "\n";
  stream << prefix << "address";
  if (!llvm::isa<ConstantExpr>(this->address))
    stream << " (symbolic)";
  stream << ": ";
  address->print(stream);
  stream << "\n";
  stream << prefix << "base: ";
  if (!llvm::isa<ConstantExpr>(this->base))
    stream << " (symbolic)";
  stream << ": ";
  base->print(stream);
  stream << "\n";
  stream << prefix
         << "pointer to location object: " << reinterpret_cast<uintptr_t>(this);
}

/**/

void TxStateValue::print(llvm::raw_ostream &stream,
                         const std::string &prefix) const {
  std::string tabsNext = appendTab(prefix);

  printNoDependency(stream, prefix);

  stream << "\n";
  if (sources.empty()) {
    stream << prefix << "no dependencies\n";
  } else {
    stream << prefix << "direct dependencies:";
    for (std::map<ref<TxStateValue>, ref<TxStateAddress> >::const_iterator
             is = sources.begin(),
             it = is, ie = sources.end();
         it != ie; ++it) {
      stream << "\n";
      if (it != is)
        stream << tabsNext << "------------------------------------------\n";
      (*it->first).printNoDependency(stream, tabsNext);
      if (!it->second.isNull()) {
        stream << " via\n";
        (*it->second).print(stream, tabsNext);
      }
    }
  }
}

void TxStateValue::printNoDependency(llvm::raw_ostream &stream,
                                     const std::string &prefix) const {
  std::string tabsNext = appendTab(prefix);

  if (core) {
    if (!doNotInterpolateBound) {
      stream << prefix << "a bounded interpolant value\n";
    } else {
      stream << prefix << "an interpolant value\n";
    }
    if (!coreReasons.empty()) {
      for (std::set<std::string>::const_iterator it = coreReasons.begin(),
                                                 ie = coreReasons.end();
           it != ie; ++it) {
        stream << tabsNext << *it << "\n";
      }
    }
  } else {
    stream << prefix << "a non-interpolant value\n";
  }
  stream << prefix << "function/value: ";
  if (outputFunctionName(value, stream))
    stream << "/";
  value->print(stream);
  stream << "\n";
  stream << prefix << "expression: ";
  valueExpr->print(stream);
  stream << "\n";
  stream << prefix
         << "pointer to location object: " << reinterpret_cast<uintptr_t>(this);
}
}
