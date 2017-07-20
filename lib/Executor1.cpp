//===-- Executor.cpp ------------------------------------------------------===//
//
//                     The KLEE Symbolic Virtual Machine
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "Executor.h"
#include "Context.h"
#include "CoreStats.h"
#include "ExternalDispatcher.h"
#include "ImpliedValue.h"
#include "Memory.h"
#include "MemoryManager.h"
#include "PTree.h"
#include "ITree.h"
#include "Searcher.h"
#include "SeedInfo.h"
#include "SpecialFunctionHandler.h"
#include "StatsTracker.h"
#include "TimingSolver.h"
#include "UserSearcher.h"
#include "ExecutorTimerInfo.h"

#include "klee/ExecutionState.h"
#include "klee/Expr.h"
#include "klee/Interpreter.h"
#include "klee/TimerStatIncrementer.h"
#include "klee/CommandLine.h"
#include "klee/Common.h"
#include "klee/util/Assignment.h"
#include "klee/util/ExprPPrinter.h"
#include "klee/util/ExprSMTLIBPrinter.h"
#include "klee/util/ExprUtil.h"
#include "klee/util/GetElementPtrTypeIterator.h"
#include "klee/Config/Version.h"
#include "klee/Internal/ADT/KTest.h"
#include "klee/Internal/ADT/RNG.h"
#include "klee/Internal/Module/Cell.h"
#include "klee/Internal/Module/InstructionInfoTable.h"
#include "klee/Internal/Module/KInstruction.h"
#include "klee/Internal/Module/KModule.h"
#include "klee/Internal/Support/ErrorHandling.h"
#include "klee/Internal/Support/FloatEvaluation.h"
#include "klee/Internal/System/Time.h"
#include "klee/Internal/System/MemoryUsage.h"
#include "klee/SolverStats.h"

#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
#include "llvm/IR/Function.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/TypeBuilder.h"
#else
#include "llvm/Attributes.h"
#include "llvm/BasicBlock.h"
#include "llvm/Constants.h"
#include "llvm/Function.h"
#include "llvm/Instructions.h"
#include "llvm/IntrinsicInst.h"
#include "llvm/LLVMContext.h"
#include "llvm/Module.h"

#if LLVM_VERSION_CODE <= LLVM_VERSION(3, 1)
#include "llvm/Target/TargetData.h"
#else
#include "llvm/DataLayout.h"
#include "llvm/TypeBuilder.h"
#endif
#endif
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/StringExtras.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/Process.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Analysis/MemoryDependenceAnalysis.h"

#if LLVM_VERSION_CODE < LLVM_VERSION(3, 5)
#include "llvm/Support/CallSite.h"
#else
#include "llvm/IR/CallSite.h"
#endif

#include <cassert>
#include <algorithm>
#include <iomanip>
#include <iosfwd>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <stack>

#include <sys/mman.h>

#include <errno.h>
#include <cxxabi.h>
#include <klee/Taint.h>

using namespace llvm;
using namespace klee;

#ifdef SUPPORT_METASMT

#include <metaSMT/frontend/Array.hpp>
#include <metaSMT/backend/Z3_Backend.hpp>
#include <metaSMT/backend/Boolector.hpp>
#include <metaSMT/backend/MiniSAT.hpp>
#include <metaSMT/DirectSolver_Context.hpp>
#include <metaSMT/support/run_algorithm.hpp>
#include <metaSMT/API/Stack.hpp>
#include <metaSMT/API/Group.hpp>

#define Expr VCExpr
#define Type VCType
#define STP STP_Backend
#include <metaSMT/backend/STP.hpp>
#undef Expr
#undef Type
#undef STP

using namespace metaSMT;
using namespace metaSMT::solver;

#endif /* SUPPORT_METASMT */

namespace {
cl::opt<bool> DumpStatesOnHalt("dump-states-on-halt", cl::init(true),
		cl::desc("Dump test cases for all active states on exit (default=on)"));

cl::opt<bool> RandomizeFork("randomize-fork", cl::init(false),
		cl::desc(
				"Randomly swap the true and false states on a fork (default=off)"));

cl::opt<bool> AllowExternalSymCalls("allow-external-sym-calls", cl::init(false),
		cl::desc(
				"Allow calls with symbolic arguments to external functions.  This concretizes the symbolic arguments.  (default=off)"));

cl::opt<bool> DebugPrintInstructions("debug-print-instructions",
		cl::desc("Print instructions during execution."));

cl::opt<bool> DebugCheckForImpliedValues("debug-check-for-implied-values");

cl::opt<bool> SimplifySymIndices("simplify-sym-indices", cl::init(false));

cl::opt<bool> EqualitySubstitution("equality-substitution", cl::init(true),
		cl::desc(
				"Simplify equality expressions before querying the solver (default=on)."));

cl::opt<unsigned> MaxSymArraySize("max-sym-array-size", cl::init(0));

cl::opt<bool> SuppressExternalWarnings("suppress-external-warnings");

cl::opt<bool> AllExternalWarnings("all-external-warnings");

cl::opt<bool> OnlyOutputStatesCoveringNew("only-output-states-covering-new",
		cl::init(false), cl::desc("Only output test cases covering new code."));

cl::opt<bool> EmitAllErrors("emit-all-errors", cl::init(false),
		cl::desc("Generate tests cases for all errors "
				"(default=off, i.e. one per (error,instruction) pair)"));

cl::opt<bool> NoExternals("no-externals",
		cl::desc("Do not allow external function calls (default=off)"));

cl::opt<bool> AlwaysOutputSeeds("always-output-seeds", cl::init(true));

cl::opt<bool> OnlyReplaySeeds("only-replay-seeds",
		cl::desc("Discard states that do not have a seed."));

cl::opt<bool> OnlySeed("only-seed",
		cl::desc(
				"Stop execution after seeding is done without doing regular search."));

cl::opt<bool> AllowSeedExtension("allow-seed-extension",
		cl::desc(
				"Allow extra (unbound) values to become symbolic during seeding."));

cl::opt<bool> ZeroSeedExtension("zero-seed-extension");

cl::opt<bool> AllowSeedTruncation("allow-seed-truncation",
		cl::desc("Allow smaller buffers than in seeds."));

cl::opt<bool> NamedSeedMatching("named-seed-matching",
		cl::desc("Use names to match symbolic objects to inputs."));

cl::opt<double> MaxStaticForkPct("max-static-fork-pct", cl::init(1.));
cl::opt<double> MaxStaticSolvePct("max-static-solve-pct", cl::init(1.));
cl::opt<double> MaxStaticCPForkPct("max-static-cpfork-pct", cl::init(1.));
cl::opt<double> MaxStaticCPSolvePct("max-static-cpsolve-pct", cl::init(1.));

cl::opt<double> MaxInstructionTime("max-instruction-time",
		cl::desc(
				"Only allow a single instruction to take this much time (default=0s (off)). Enables --use-forked-solver"),
		cl::init(0));

cl::opt<double> SeedTime("seed-time",
		cl::desc(
				"Amount of time to dedicate to seeds, before normal search (default=0 (off))"),
		cl::init(0));

cl::opt<unsigned int> StopAfterNInstructions("stop-after-n-instructions",
		cl::desc(
				"Stop execution after specified number of instructions (default=0 (off))"),
		cl::init(0));

cl::opt<unsigned> MaxForks("max-forks",
		cl::desc("Only fork this many times (default=-1 (off))"),
		cl::init(~0u));

cl::opt<unsigned> MaxDepth("max-depth",
		cl::desc("Only allow this many symbolic branches (default=0 (off))"),
		cl::init(0));

cl::opt<unsigned> MaxMemory("max-memory",
		cl::desc(
				"Refuse to fork when above this amount of memory (in MB, default=2000)"),
		cl::init(2000));

cl::opt<bool> MaxMemoryInhibit("max-memory-inhibit",
		cl::desc(
				"Inhibit forking at memory cap (vs. random terminate) (default=on)"),
		cl::init(true));
}

namespace klee {
RNG theRNG;
}

Executor::Executor(const InterpreterOptions &opts, InterpreterHandler *ih) :
		Interpreter(opts), kmodule(0), interpreterHandler(ih), searcher(0), externalDispatcher(
				new ExternalDispatcher()), statsTracker(0), pathWriter(0), symPathWriter(
				0), specialFunctionHandler(0), processTree(0), interpTree(0), replayOut(
				0), replayPath(0), usingSeeds(0), atMemoryLimit(false), inhibitForking(
				false), haltExecution(false), ivcEnabled(false), coreSolverTimeout(
				MaxCoreSolverTime != 0 && MaxInstructionTime != 0 ?
						std::min(MaxCoreSolverTime, MaxInstructionTime) :
						std::max(MaxCoreSolverTime, MaxInstructionTime)) {

	if (coreSolverTimeout)
		UseForkedCoreSolver = true;

	Solver *coreSolver = NULL;

#ifdef SUPPORT_METASMT
	if (UseMetaSMT != METASMT_BACKEND_NONE) {

		std::string backend;

		switch (UseMetaSMT) {
			case METASMT_BACKEND_STP:
			backend = "STP";
			coreSolver = new MetaSMTSolver< DirectSolver_Context < STP_Backend > >(UseForkedCoreSolver, CoreSolverOptimizeDivides);
			break;
			case METASMT_BACKEND_Z3:
			backend = "Z3";
			coreSolver = new MetaSMTSolver< DirectSolver_Context < Z3_Backend > >(UseForkedCoreSolver, CoreSolverOptimizeDivides);
			break;
			case METASMT_BACKEND_BOOLECTOR:
			backend = "Boolector";
			coreSolver = new MetaSMTSolver< DirectSolver_Context < Boolector > >(UseForkedCoreSolver, CoreSolverOptimizeDivides);
			break;
			default:
			assert(false);
			break;
		};
		llvm::errs() << "Starting MetaSMTSolver(" << backend << ") ...\n";
	}
	else {
		coreSolver = new STPSolver(UseForkedCoreSolver, CoreSolverOptimizeDivides);
		llvm::errs() << "Starting STPSolver ...\n";
	}
#elif SUPPORT_STP

#ifdef SUPPORT_Z3
	switch (SelectSolver) {
	case SOLVER_STP:
		coreSolver = new STPSolver(UseForkedCoreSolver,
				CoreSolverOptimizeDivides);
		llvm::errs() << "Starting STPSolver ...\n";
		break;
	case SOLVER_Z3:
		coreSolver = new Z3Solver();
		llvm::errs() << "Starting Z3Solver ...\n";
		break;
	default:
		assert(false);
		break;
	};
#else
	coreSolver = new STPSolver(UseForkedCoreSolver, CoreSolverOptimizeDivides);
	llvm::errs() << "Starting STPSolver ...\n";
#endif /* SUPPORT_Z3 */

#elif SUPPORT_Z3
	coreSolver = new Z3Solver();
	llvm::errs() << "Starting Z3Solver ...\n";
#endif /* SUPPORT_METASMT */

	Solver *solver = constructSolverChain(coreSolver,
			interpreterHandler->getOutputFilename(ALL_QUERIES_SMT2_FILE_NAME),
			interpreterHandler->getOutputFilename(
					SOLVER_QUERIES_SMT2_FILE_NAME),
			interpreterHandler->getOutputFilename(ALL_QUERIES_PC_FILE_NAME),
			interpreterHandler->getOutputFilename(SOLVER_QUERIES_PC_FILE_NAME));

#ifdef SUPPORT_Z3
	// In case interpolation is enabled with Z3 solver,
	// we should not simplify the constraints before
	// submitting them to the solver.
#ifdef SUPPORT_STP
	if (SelectSolver == SOLVER_Z3) {
		this->solver = new TimingSolver(solver,
				NoInterpolation ? EqualitySubstitution : false);
	} else {
		this->solver = new TimingSolver(solver, EqualitySubstitution);
	}
#else
	this->solver = new TimingSolver(solver, NoInterpolation? EqualitySubstitution : false);
#endif /* SUPPORT_STP */

#else
	this->solver = new TimingSolver(solver, EqualitySubstitution);
#endif /* SUPPORT_Z3 */

	memory = new MemoryManager(&arrayCache);
	TaintInitializer = 0;

	/*HSET*/
	//HSETInfo = new HSETGeneralInfo();
	AbstractMethods = NONE;
}

const Module *Executor::setModule(llvm::Module *module,
		const ModuleOptions &opts) {
	assert(!kmodule && module && "can only register one module"); // XXX gross

	kmodule = new KModule(module);

	// Initialize the context.
#if LLVM_VERSION_CODE <= LLVM_VERSION(3, 1)
	TargetData *TD = kmodule->targetData;
#else
	DataLayout *TD = kmodule->targetData;
#endif
	Context::initialize(TD->isLittleEndian(),
			(Expr::Width) TD->getPointerSizeInBits());

	specialFunctionHandler = new SpecialFunctionHandler(*this);

	specialFunctionHandler->prepare();
	kmodule->prepare(opts, interpreterHandler);
	specialFunctionHandler->bind();

	if (StatsTracker::useStatistics()) {
		statsTracker = new StatsTracker(*this,
				interpreterHandler->getOutputFilename("assembly.ll"),
				userSearcherRequiresMD2U());
	}

	return module;
}

Executor::~Executor() {
	delete memory;
	delete externalDispatcher;
	if (processTree)
		delete processTree;
	if (specialFunctionHandler)
		delete specialFunctionHandler;
	if (statsTracker)
		delete statsTracker;
	delete solver;
	delete kmodule;
	while (!timers.empty()) {
		delete timers.back();
		timers.pop_back();
	}
}

/***/

void Executor::initializeGlobalObject(ExecutionState &state, ObjectState *os,
		const Constant *c, unsigned offset) {
#if LLVM_VERSION_CODE <= LLVM_VERSION(3, 1)
	TargetData *targetData = kmodule->targetData;
#else
	DataLayout *targetData = kmodule->targetData;
#endif
	if (const ConstantVector *cp = dyn_cast < ConstantVector > (c)) {
		unsigned elementSize = targetData->getTypeStoreSize(
				cp->getType()->getElementType());
		for (unsigned i = 0, e = cp->getNumOperands(); i != e; ++i)
			initializeGlobalObject(state, os, cp->getOperand(i),
					offset + i * elementSize);
	} else if (isa < ConstantAggregateZero > (c)) {
		unsigned i, size = targetData->getTypeStoreSize(c->getType());
		for (i = 0; i < size; i++)
			os->write8(offset + i, (uint8_t) 0);
	} else if (const ConstantArray *ca = dyn_cast < ConstantArray > (c)) {
		unsigned elementSize = targetData->getTypeStoreSize(
				ca->getType()->getElementType());
		for (unsigned i = 0, e = ca->getNumOperands(); i != e; ++i)
			initializeGlobalObject(state, os, ca->getOperand(i),
					offset + i * elementSize);
	} else if (const ConstantStruct *cs = dyn_cast < ConstantStruct > (c)) {
		const StructLayout *sl = targetData->getStructLayout(
				cast < StructType > (cs->getType()));
		for (unsigned i = 0, e = cs->getNumOperands(); i != e; ++i)
			initializeGlobalObject(state, os, cs->getOperand(i),
					offset + sl->getElementOffset(i));
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 1)
	} else if (const ConstantDataSequential *cds = dyn_cast
			< ConstantDataSequential > (c)) {
		unsigned elementSize = targetData->getTypeStoreSize(
				cds->getElementType());
		for (unsigned i = 0, e = cds->getNumElements(); i != e; ++i)
			initializeGlobalObject(state, os, cds->getElementAsConstant(i),
					offset + i * elementSize);
#endif
	} else if (!isa < UndefValue > (c)) {
		unsigned StoreBits = targetData->getTypeStoreSizeInBits(c->getType());
		ref<ConstantExpr> C = evalConstant(c);

		// Extend the constant if necessary;
		assert(StoreBits >= C->getWidth() && "Invalid store size!");
		if (StoreBits > C->getWidth())
			C = C->ZExt(StoreBits);

		os->write(offset, C);
	}
}

MemoryObject * Executor::addExternalObject(ExecutionState &state, void *addr,
		unsigned size, bool isReadOnly) {
	MemoryObject *mo = memory->allocateFixed((uint64_t) (unsigned long) addr,
			size, 0);
	ObjectState *os = bindObjectInState(state, mo, false);
	for (unsigned i = 0; i < size; i++)
		os->write8(i, ((uint8_t*) addr)[i]);
	if (isReadOnly)
		os->setReadOnly(true);
	return mo;
}

extern void *__dso_handle __attribute__ ((__weak__));

void Executor::initializeGlobals(ExecutionState &state) {
	Module *m = kmodule->module;

	if (m->getModuleInlineAsm() != "")
		klee_warning("executable has module level assembly (ignoring)");
#if LLVM_VERSION_CODE < LLVM_VERSION(3, 3)
	assert(m->lib_begin() == m->lib_end() &&
			"XXX do not support dependent libraries");
#endif
	// represent function globals using the address of the actual llvm function
	// object. given that we use malloc to allocate memory in states this also
	// ensures that we won't conflict. we don't need to allocate a memory object
	// since reading/writing via a function pointer is unsupported anyway.
	for (Module::iterator i = m->begin(), ie = m->end(); i != ie; ++i) {
		Function *f = i;
		ref<ConstantExpr> addr(0);

		// If the symbol has external weak linkage then it is implicitly
		// not defined in this module; if it isn't resolvable then it
		// should be null.
		if (f->hasExternalWeakLinkage()
				&& !externalDispatcher->resolveSymbol(f->getName())) {
			addr = Expr::createPointer(0);
		} else {
			addr = Expr::createPointer((unsigned long) (void*) f);
			legalFunctions.insert((uint64_t) (unsigned long) (void*) f);
		}

		globalAddresses.insert(std::make_pair(f, addr));
	}

	// Disabled, we don't want to promote use of live externals.
#ifdef HAVE_CTYPE_EXTERNALS
#ifndef WINDOWS
#ifndef DARWIN
	/* From /usr/include/errno.h: it [errno] is a per-thread variable. */
	int *errno_addr = __errno_location();
	addExternalObject(state, (void *) errno_addr, sizeof *errno_addr, false);

	/* from /usr/include/ctype.h:
	 These point into arrays of 384, so they can be indexed by any `unsigned
	 char' value [0,255]; by EOF (-1); or by any `signed char' value
	 [-128,-1).  ISO C requires that the ctype functions work for `unsigned */
	const uint16_t **addr = __ctype_b_loc();
	addExternalObject(state, const_cast<uint16_t*>(*addr - 128),
			384 * sizeof **addr, true);
	addExternalObject(state, addr, sizeof(*addr), true);

	const int32_t **lower_addr = __ctype_tolower_loc();
	addExternalObject(state, const_cast<int32_t*>(*lower_addr - 128),
			384 * sizeof **lower_addr, true);
	addExternalObject(state, lower_addr, sizeof(*lower_addr), true);

	const int32_t **upper_addr = __ctype_toupper_loc();
	addExternalObject(state, const_cast<int32_t*>(*upper_addr - 128),
			384 * sizeof **upper_addr, true);
	addExternalObject(state, upper_addr, sizeof(*upper_addr), true);
#endif
#endif
#endif

	// allocate and initialize globals, done in two passes since we may
	// need address of a global in order to initialize some other one.

	// allocate memory objects for all globals
	for (Module::const_global_iterator i = m->global_begin(), e =
			m->global_end(); i != e; ++i) {
		if (i->isDeclaration()) {
			// FIXME: We have no general way of handling unknown external
			// symbols. If we really cared about making external stuff work
			// better we could support user definition, or use the EXE style
			// hack where we check the object file information.

			LLVM_TYPE_Q Type *ty = i->getType()->getElementType();
			uint64_t size = kmodule->targetData->getTypeStoreSize(ty);

			// XXX - DWD - hardcode some things until we decide how to fix.
#ifndef WINDOWS
			if (i->getName() == "_ZTVN10__cxxabiv117__class_type_infoE") {
				size = 0x2C;
			} else if (i->getName()
					== "_ZTVN10__cxxabiv120__si_class_type_infoE") {
				size = 0x2C;
			} else if (i->getName()
					== "_ZTVN10__cxxabiv121__vmi_class_type_infoE") {
				size = 0x2C;
			}
#endif

			if (size == 0) {
				llvm::errs() << "Unable to find size for global variable: "
						<< i->getName()
						<< " (use will result in out of bounds access)\n";
			}

			MemoryObject *mo = memory->allocate(size, false, true, i);
			ObjectState *os = bindObjectInState(state, mo, false);
			globalObjects.insert(std::make_pair(i, mo));
			globalAddresses.insert(std::make_pair(i, mo->getBaseExpr()));

			// Program already running = object already initialized.  Read
			// concrete value and write it to our copy.
			if (size) {
				void *addr;
				if (i->getName() == "__dso_handle") {
					addr = &__dso_handle; // wtf ?
				} else {
					addr = externalDispatcher->resolveSymbol(i->getName());
				}
				if (!addr)
					klee_error(
							"unable to load symbol(%s) while initializing globals.",
							i->getName().data());

				for (unsigned offset = 0; offset < mo->size; offset++)
					os->write8(offset, ((unsigned char*) addr)[offset]);
			}
		} else {
			LLVM_TYPE_Q Type *ty = i->getType()->getElementType();
			uint64_t size = kmodule->targetData->getTypeStoreSize(ty);
			MemoryObject *mo = memory->allocate(size, false, true, &*i);
			if (!mo)
				llvm::report_fatal_error("out of memory");
			ObjectState *os = bindObjectInState(state, mo, false);
			globalObjects.insert(std::make_pair(i, mo));
			globalAddresses.insert(std::make_pair(i, mo->getBaseExpr()));

			if (!i->hasInitializer())
				os->initializeToRandom();
		}
	}

	// link aliases to their definitions (if bound)
	for (Module::alias_iterator i = m->alias_begin(), ie = m->alias_end();
			i != ie; ++i) {
		// Map the alias to its aliasee's address. This works because we have
		// addresses for everything, even undefined functions.
		globalAddresses.insert(
				std::make_pair(i, evalConstant(i->getAliasee())));
	}

	// once all objects are allocated, do the actual initialization
	for (Module::const_global_iterator i = m->global_begin(), e =
			m->global_end(); i != e; ++i) {
		if (i->hasInitializer()) {
			MemoryObject *mo = globalObjects.find(i)->second;
			const ObjectState *os = state.addressSpace.findObject(mo);
			assert(os);
			ObjectState *wos = state.addressSpace.getWriteable(mo, os);

			initializeGlobalObject(state, wos, i->getInitializer(), 0);
			// if(i->isConstant()) os->setReadOnly(true);
		}
	}
}

void Executor::branch(ExecutionState &state,
		const std::vector<ref<Expr> > &conditions,
		std::vector<ExecutionState*> &result) {
	TimerStatIncrementer timer(stats::forkTime);
	unsigned N = conditions.size();
	assert(N);

	if (MaxForks != ~0u && stats::forks >= MaxForks) {
		unsigned next = theRNG.getInt32() % N;
		for (unsigned i = 0; i < N; ++i) {
			if (i == next) {
				result.push_back(&state);
			} else {
				result.push_back(NULL);
			}
		}
	} else {
		stats::forks += N - 1;

		// XXX do proper balance or keep random?
		result.push_back(&state);
		//for (unsigned i = 1; i < N; ++i) {
		for (unsigned i = 0; i < N; i++) {
			////TanNguyen remove random, keep branching following condition order
			//ExecutionState *es = result[theRNG.getInt32() % i];
			ExecutionState *es = result[i];
			ExecutionState *ns = es->branch();
			addedStates.insert(ns);
			result.push_back(ns);
			//TanNguyen keep ptreeNode data
			es->ptreeNode->data = 0;
			std::pair<PTree::Node*, PTree::Node*> res = processTree->split(
					es->ptreeNode, ns, es);
			ns->ptreeNode = res.first;
			es->ptreeNode = res.second;

			if (INTERPOLATION_ENABLED) {
				std::pair<ITreeNode *, ITreeNode *> ires = interpTree->split(
						es->itreeNode, ns, es);
				ns->itreeNode = ires.first;
				es->itreeNode = ires.second;
			}
		}
	}

	// If necessary redistribute seeds to match conditions, killing
	// states if necessary due to OnlyReplaySeeds (inefficient but
	// simple).

	std::map<ExecutionState*, std::vector<SeedInfo> >::iterator it =
			seedMap.find(&state);
	if (it != seedMap.end()) {
		std::vector<SeedInfo> seeds = it->second;
		seedMap.erase(it);

		// Assume each seed only satisfies one condition (necessarily true
		// when conditions are mutually exclusive and their conjunction is
		// a tautology).
		for (std::vector<SeedInfo>::iterator siit = seeds.begin(), siie =
				seeds.end(); siit != siie; ++siit) {
			unsigned i;
			for (i = 0; i < N; ++i) {
				ref<ConstantExpr> res;
				bool success = solver->getValue(state,
						siit->assignment.evaluate(conditions[i]), res);
				assert(success && "FIXME: Unhandled solver failure");
				(void) success;
				if (res->isTrue())
					break;
			}

			// If we didn't find a satisfying condition randomly pick one
			// (the seed will be patched).
			if (i == N)
				i = theRNG.getInt32() % N;

			// Extra check in case we're replaying seeds with a max-fork
			if (result[i])
				seedMap[result[i]].push_back(*siit);
		}

		if (OnlyReplaySeeds) {
			for (unsigned i = 0; i < N; ++i) {
				if (result[i] && !seedMap.count(result[i])) {
					terminateState(*result[i]);
					result[i] = NULL;
				}
			}
		}
	}

	for (unsigned i = 0; i < N; ++i)
		if (result[i])
			addConstraint(*result[i], conditions[i]);
}

Executor::StatePair Executor::fork(ExecutionState &current, ref<Expr> condition,
		bool isInternal) {
	Solver::Validity res;
	std::map<ExecutionState*, std::vector<SeedInfo> >::iterator it =
			seedMap.find(&current);
	bool isSeeding = it != seedMap.end();

	if (!isSeeding && !isa < ConstantExpr > (condition)
			&& (MaxStaticForkPct != 1. || MaxStaticSolvePct != 1.
					|| MaxStaticCPForkPct != 1. || MaxStaticCPSolvePct != 1.)
			&& statsTracker->elapsed() > 60.) {
		StatisticManager &sm = *theStatisticManager;
		CallPathNode *cpn = current.stack.back().callPathNode;
		if ((MaxStaticForkPct < 1.
				&& sm.getIndexedValue(stats::forks, sm.getIndex())
						> stats::forks * MaxStaticForkPct)
				|| (MaxStaticCPForkPct < 1. && cpn
						&& (cpn->statistics.getValue(stats::forks)
								> stats::forks * MaxStaticCPForkPct))
				|| (MaxStaticSolvePct < 1
						&& sm.getIndexedValue(stats::solverTime, sm.getIndex())
								> stats::solverTime * MaxStaticSolvePct)
				|| (MaxStaticCPForkPct < 1. && cpn
						&& (cpn->statistics.getValue(stats::solverTime)
								> stats::solverTime * MaxStaticCPSolvePct))) {
			ref<ConstantExpr> value;
			bool success = solver->getValue(current, condition, value);
			assert(success && "FIXME: Unhandled solver failure");
			(void) success;
			addConstraint(current, EqExpr::create(value, condition));
			condition = value;
		}
	}

	double timeout = coreSolverTimeout;
	if (isSeeding)
		timeout *= it->second.size();

	// llvm::errs() << "Calling solver->evaluate on query:\n";
	// ExprPPrinter::printQuery(llvm::errs(), current.constraints, condition);

	solver->setTimeout(timeout);
	bool success = solver->evaluate(current, condition, res);
	solver->setTimeout(0);

	if (!success) {
		current.pc = current.prevPC;
		terminateStateEarly(current, "Query timed out (fork).");
		return StatePair(0, 0);
	}

	if (!isSeeding) {
		if (replayPath && !isInternal) {
			assert(
					replayPosition < replayPath->size()
							&& "ran out of branches in replay path mode");
			bool branch = (*replayPath)[replayPosition++];

			if (res == Solver::True) {
				assert(branch && "hit invalid branch in replay path mode");
			} else if (res == Solver::False) {
				assert(!branch && "hit invalid branch in replay path mode");
			} else {
				// add constraints
				if (branch) {
					res = Solver::True;
					addConstraint(current, condition);
				} else {
					res = Solver::False;
					addConstraint(current, Expr::createIsZero(condition));
				}
			}
		} else if (res == Solver::Unknown) {
			assert(
					!replayOut
							&& "in replay mode, only one branch can be true.");

			if ((MaxMemoryInhibit && atMemoryLimit) || current.forkDisabled
					|| inhibitForking
					|| (MaxForks != ~0u && stats::forks >= MaxForks)) {

				if (MaxMemoryInhibit && atMemoryLimit)
					klee_warning_once(0, "skipping fork (memory cap exceeded)");
				else if (current.forkDisabled)
					klee_warning_once(0,
							"skipping fork (fork disabled on current path)");
				else if (inhibitForking)
					klee_warning_once(0,
							"skipping fork (fork disabled globally)");
				else
					klee_warning_once(0, "skipping fork (max-forks reached)");

				TimerStatIncrementer timer(stats::forkTime);
				if (theRNG.getBool()) {
					addConstraint(current, condition);
					res = Solver::True;
				} else {
					addConstraint(current, Expr::createIsZero(condition));
					res = Solver::False;
				}
			}
		}
	}

	// Fix branch in only-replay-seed mode, if we don't have both true
	// and false seeds.
	if (isSeeding && (current.forkDisabled || OnlyReplaySeeds)
			&& res == Solver::Unknown) {
		bool trueSeed = false, falseSeed = false;
		// Is seed extension still ok here?
		for (std::vector<SeedInfo>::iterator siit = it->second.begin(), siie =
				it->second.end(); siit != siie; ++siit) {
			ref<ConstantExpr> res;
			bool success = solver->getValue(current,
					siit->assignment.evaluate(condition), res);
			assert(success && "FIXME: Unhandled solver failure");
			(void) success;
			if (res->isTrue()) {
				trueSeed = true;
			} else {
				falseSeed = true;
			}
			if (trueSeed && falseSeed)
				break;
		}
		if (!(trueSeed && falseSeed)) {
			assert(trueSeed || falseSeed);

			res = trueSeed ? Solver::True : Solver::False;
			addConstraint(current,
					trueSeed ? condition : Expr::createIsZero(condition));
		}
	}

	// XXX - even if the constraint is provable one way or the other we
	// can probably benefit by adding this constraint and allowing it to
	// reduce the other constraints. For example, if we do a binary
	// search on a particular value, and then see a comparison against
	// the value it has been fixed at, we should take this as a nice
	// hint to just use the single constraint instead of all the binary
	// search ones. If that makes sense.
	if (res == Solver::True) {

		if (!isInternal) {
			if (pathWriter) {
				current.pathOS << "1";
			}
		}

		if (INTERPOLATION_ENABLED) {
			// Validity proof succeeded of a query: antecedent -> consequent.
			// We then extract the unsatisfiability core of antecedent and not
			// consequent as the Craig interpolant.
			interpTree->markPathCondition(current, solver);
		}

		if (!isInternal) {
			if (interpreterOpts.ExeConfig
					== Interpreter::HybridSymbolicExecution || interpreterOpts.ExeConfig
					== Interpreter::HybridAbstractExecution) {
				current.ptreeNode->data = 0;
				std::pair<PTree::Node*, PTree::Node*> res = processTree->split(
						current.ptreeNode, 0, &current);
				current.ptreeNode = res.second;
			}
		}

		return StatePair(&current, 0);
	} else if (res == Solver::False) {
		if (!isInternal) {
			if (pathWriter) {
				current.pathOS << "0";
			}
		}

		if (INTERPOLATION_ENABLED) {
			// Falsity proof succeeded of a query: antecedent -> consequent,
			// which means that antecedent -> not(consequent) is valid. In this
			// case also we extract the unsat core of the proof
			interpTree->markPathCondition(current, solver);
		}
		if (!isInternal) {
			if (interpreterOpts.ExeConfig
					== Interpreter::HybridSymbolicExecution || interpreterOpts.ExeConfig
					== Interpreter::HybridAbstractExecution) {
				current.ptreeNode->data = 0;
				std::pair<PTree::Node*, PTree::Node*> res = processTree->split(
						current.ptreeNode, &current, 0);
				current.ptreeNode = res.first;
			}
		}
		return StatePair(0, &current);
	} else {
		TimerStatIncrementer timer(stats::forkTime);
		ExecutionState *falseState, *trueState = &current;

		++stats::forks;

		falseState = trueState->branch();
		addedStates.insert(falseState);

		if (RandomizeFork && theRNG.getBool())
			std::swap(trueState, falseState);

		if (it != seedMap.end()) {
			std::vector<SeedInfo> seeds = it->second;
			it->second.clear();
			std::vector<SeedInfo> &trueSeeds = seedMap[trueState];
			std::vector<SeedInfo> &falseSeeds = seedMap[falseState];
			for (std::vector<SeedInfo>::iterator siit = seeds.begin(), siie =
					seeds.end(); siit != siie; ++siit) {
				ref<ConstantExpr> res;
				bool success = solver->getValue(current,
						siit->assignment.evaluate(condition), res);
				assert(success && "FIXME: Unhandled solver failure");
				(void) success;
				if (res->isTrue()) {
					trueSeeds.push_back(*siit);
				} else {
					falseSeeds.push_back(*siit);
				}
			}

			bool swapInfo = false;
			if (trueSeeds.empty()) {
				if (&current == trueState)
					swapInfo = true;
				seedMap.erase(trueState);
			}
			if (falseSeeds.empty()) {
				if (&current == falseState)
					swapInfo = true;
				seedMap.erase(falseState);
			}
			if (swapInfo) {
				std::swap(trueState->coveredNew, falseState->coveredNew);
				std::swap(trueState->coveredLines, falseState->coveredLines);
			}
		}
		//TanNguyen keep ptreeNode data
		current.ptreeNode->data = 0;
		std::pair<PTree::Node*, PTree::Node*> res = processTree->split(
				current.ptreeNode, falseState, trueState);
		falseState->ptreeNode = res.first;
		trueState->ptreeNode = res.second;

		if (!isInternal) {
			if (pathWriter) {
				falseState->pathOS = pathWriter->open(current.pathOS);
				trueState->pathOS << "1";
				falseState->pathOS << "0";
			}
			if (symPathWriter) {
				falseState->symPathOS = symPathWriter->open(current.symPathOS);
				trueState->symPathOS << "1";
				falseState->symPathOS << "0";
			}
		}

		if (INTERPOLATION_ENABLED) {
			std::pair<ITreeNode *, ITreeNode *> ires = interpTree->split(
					current.itreeNode, falseState, trueState);
			falseState->itreeNode = ires.first;
			trueState->itreeNode = ires.second;
		}

		addConstraint(*trueState, condition);
		addConstraint(*falseState, Expr::createIsZero(condition));

		// Kinda gross, do we even really still want this option?
		if (MaxDepth && MaxDepth <= trueState->depth) {
			terminateStateEarly(*trueState, "max-depth exceeded.");
			terminateStateEarly(*falseState, "max-depth exceeded.");
			return StatePair(0, 0);
		}

		return StatePair(trueState, falseState);
	}
}

void Executor::addConstraint(ExecutionState &state, ref<Expr> condition) {
	if (ConstantExpr *CE = dyn_cast < ConstantExpr > (condition)) {
		if (!CE->isTrue())
			llvm::report_fatal_error("attempt to add invalid constraint");
		return;
	}

	// Check to see if this constraint violates seeds.
	std::map<ExecutionState*, std::vector<SeedInfo> >::iterator it =
			seedMap.find(&state);
	if (it != seedMap.end()) {
		bool warn = false;
		for (std::vector<SeedInfo>::iterator siit = it->second.begin(), siie =
				it->second.end(); siit != siie; ++siit) {
			bool res;
			bool success = solver->mustBeFalse(state,
					siit->assignment.evaluate(condition), res);
			assert(success && "FIXME: Unhandled solver failure");
			(void) success;
			if (res) {
				siit->patchSeed(state, condition, solver);
				warn = true;
			}
		}
		if (warn)
			klee_warning("seeds patched for violating constraint");
	}

	state.addConstraint(condition);
	if (ivcEnabled)
		doImpliedValueConcretization(state, condition,
				ConstantExpr::alloc(1, Expr::Bool));
}

ref<klee::ConstantExpr> Executor::evalConstant(const Constant *c) {
	if (const llvm::ConstantExpr *ce = dyn_cast < llvm::ConstantExpr > (c)) {
		return evalConstantExpr(ce);
	} else {
		if (const ConstantInt *ci = dyn_cast < ConstantInt > (c)) {
			return ConstantExpr::alloc(ci->getValue());
		} else if (const ConstantFP *cf = dyn_cast < ConstantFP > (c)) {
			return ConstantExpr::alloc(cf->getValueAPF().bitcastToAPInt());
		} else if (const GlobalValue *gv = dyn_cast < GlobalValue > (c)) {
			return globalAddresses.find(gv)->second;
		} else if (isa < ConstantPointerNull > (c)) {
			return Expr::createPointer(0);
		} else if (isa < UndefValue > (c)
				|| isa < ConstantAggregateZero > (c)) {
			return ConstantExpr::create(0, getWidthForLLVMType(c->getType()));
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 1)
		} else if (const ConstantDataSequential *cds = dyn_cast
				< ConstantDataSequential > (c)) {
			std::vector<ref<Expr> > kids;
			for (unsigned i = 0, e = cds->getNumElements(); i != e; ++i) {
				ref<Expr> kid = evalConstant(cds->getElementAsConstant(i));
				kids.push_back(kid);
			}
			ref<Expr> res = ConcatExpr::createN(kids.size(), kids.data());
			return cast < ConstantExpr > (res);
#endif
		} else if (const ConstantStruct *cs = dyn_cast < ConstantStruct > (c)) {
			const StructLayout *sl = kmodule->targetData->getStructLayout(
					cs->getType());
			llvm::SmallVector<ref<Expr>, 4> kids;
			for (unsigned i = cs->getNumOperands(); i != 0; --i) {
				unsigned op = i - 1;
				ref<Expr> kid = evalConstant(cs->getOperand(op));

				uint64_t thisOffset = sl->getElementOffsetInBits(op),
						nextOffset =
								(op == cs->getNumOperands() - 1) ?
										sl->getSizeInBits() :
										sl->getElementOffsetInBits(op + 1);
				if (nextOffset - thisOffset > kid->getWidth()) {
					uint64_t paddingWidth = nextOffset - thisOffset
							- kid->getWidth();
					kids.push_back(ConstantExpr::create(0, paddingWidth));
				}

				kids.push_back(kid);
			}
			ref<Expr> res = ConcatExpr::createN(kids.size(), kids.data());
			return cast < ConstantExpr > (res);
		} else if (const ConstantArray *ca = dyn_cast < ConstantArray > (c)) {
			llvm::SmallVector<ref<Expr>, 4> kids;
			for (unsigned i = ca->getNumOperands(); i != 0; --i) {
				unsigned op = i - 1;
				ref<Expr> kid = evalConstant(ca->getOperand(op));
				kids.push_back(kid);
			}
			ref<Expr> res = ConcatExpr::createN(kids.size(), kids.data());
			return cast < ConstantExpr > (res);
		} else {
			// Constant{Vector}
			llvm::report_fatal_error("invalid argument to evalConstant()");
		}
	}
}

const Cell& Executor::eval(KInstruction *ki, unsigned index,
		ExecutionState &state) const {
	assert(index < ki->inst->getNumOperands());
	int vnumber = ki->operands[index];

	assert(
			vnumber != -1
					&& "Invalid operand to eval(), not a value or constant!");

	// Determine if this is a constant or not.
	if (vnumber < 0) {
		unsigned index = -vnumber - 2;
		return kmodule->constantTable[index];
	} else {
		unsigned index = vnumber;
		StackFrame &sf = state.stack.back();
		return sf.locals[index];
	}
}

void Executor::bindLocal(KInstruction *target, ExecutionState &state,
		ref<Expr> value, TaintSet taint) {
	Cell& cell = getDestCell(state, target);
	cell.value = value;
	cell.taint = taint;
}

void Executor::bindArgument(KFunction *kf, unsigned index,
		ExecutionState &state, ref<Expr> value, TaintSet taint) {
	Cell& cell = getArgumentCell(state, kf, index);
	cell.value = value;
	cell.taint = taint;
}

ref<Expr> Executor::toUnique(const ExecutionState &state, ref<Expr> &e) {
	ref<Expr> result = e;

	if (!isa < ConstantExpr > (e)) {
		ref<ConstantExpr> value;
		bool isTrue = false;

		solver->setTimeout(coreSolverTimeout);
		if (solver->getValue(state, e, value)
				&& solver->mustBeTrue(state, EqExpr::create(e, value), isTrue)
				&& isTrue)
			result = value;
		solver->setTimeout(0);
	}

	return result;
}

/* Concretize the given expression, and return a possible constant value. 
 'reason' is just a documentation string stating the reason for concretization. */
ref<klee::ConstantExpr> Executor::toConstant(ExecutionState &state, ref<Expr> e,
		const char *reason) {
	e = state.constraints.simplifyExpr(e);
	if (ConstantExpr *CE = dyn_cast < ConstantExpr > (e))
		return CE;

	ref<ConstantExpr> value;
	bool success = solver->getValue(state, e, value);
	assert(success && "FIXME: Unhandled solver failure");
	(void) success;

	std::string str;
	llvm::raw_string_ostream os(str);
	os << "silently concretizing (reason: " << reason << ") expression " << e
			<< " to value " << value << " (" << (*(state.pc)).info->file << ":"
			<< (*(state.pc)).info->line << ")";

	if (AllExternalWarnings)
		klee_warning(reason, os.str().c_str());
	else
		klee_warning_once(reason, "%s", os.str().c_str());

	addConstraint(state, EqExpr::create(e, value));

	return value;
}

void Executor::executeGetValue(ExecutionState &state, ref<Expr> e,
		KInstruction *target) {
	e = state.constraints.simplifyExpr(e);
	std::map<ExecutionState*, std::vector<SeedInfo> >::iterator it =
			seedMap.find(&state);
	if (it == seedMap.end() || isa < ConstantExpr > (e)) {
		ref<ConstantExpr> value;
		bool success = solver->getValue(state, e, value);
		assert(success && "FIXME: Unhandled solver failure");
		(void) success;
		bindLocal(target, state, value);

		if (INTERPOLATION_ENABLED) {
			interpTree->execute(target->inst, e, value);
		}
	} else {
		std::set<ref<Expr> > values;
		for (std::vector<SeedInfo>::iterator siit = it->second.begin(), siie =
				it->second.end(); siit != siie; ++siit) {
			ref<ConstantExpr> value;
			bool success = solver->getValue(state, siit->assignment.evaluate(e),
					value);
			assert(success && "FIXME: Unhandled solver failure");
			(void) success;
			values.insert(value);
		}

		std::vector<ref<Expr> > conditions;
		for (std::set<ref<Expr> >::iterator vit = values.begin(), vie =
				values.end(); vit != vie; ++vit)
			conditions.push_back(EqExpr::create(e, *vit));

		std::vector<ExecutionState*> branches;
		branch(state, conditions, branches);

		std::vector<ExecutionState*>::iterator bit = branches.begin();
		for (std::set<ref<Expr> >::iterator vit = values.begin(), vie =
				values.end(); vit != vie; ++vit) {
			ExecutionState *es = *bit;
			if (es)
				bindLocal(target, *es, *vit);
			if (INTERPOLATION_ENABLED) {
				std::vector<ref<Expr> > args;
				args.push_back(e);
				args.push_back(*vit);
				ITree::executeOnNode(es->itreeNode, target->inst, args);
			}
			++bit;
		}
	}
}

void Executor::stepInstruction(ExecutionState &state) {
	if (DebugPrintInstructions && HSETInfo.IsTurnOnNotification) {
		printFileLine(state, state.pc);
		llvm::errs().indent(10) << stats::instructions << " ";
		llvm::errs() << *(state.pc->inst) << '\n';
	}

	if (state.pathSpecialCount == (state.maxSpecialCount - 5)) {

		int sizeOfNew = state.maxSpecialCount + 100;
		KInstIterator* pathSpecialNew = new KInstIterator[sizeOfNew];

		for (int i = 0; i <= state.pathSpecialCount; i++) {
			pathSpecialNew[i] = state.pathSpecial[i];
		}

		delete[] state.pathSpecial;
		state.pathSpecial = pathSpecialNew;
		state.maxSpecialCount = sizeOfNew;

		//llvm::errs() << "End restructure mode " << state.maxSpecialCount
		//		<< "\n";
	}

	state.pathSpecial[state.pathSpecialCount] = state.pc;
	++state.pathSpecialCount;

	if (statsTracker)
		statsTracker->stepInstruction(state);

	++stats::instructions;
	state.prevPC = state.pc;
	++state.pc;

	if (stats::instructions == StopAfterNInstructions)
		haltExecution = true;
}

void Executor::executeCall(ExecutionState &state, KInstruction *ki, Function *f,
		std::vector<std::pair<ref<Expr>, TaintSet> > &arguments) {
	Instruction *i = ki->inst;
	if (f && f->isDeclaration()) {
		switch (f->getIntrinsicID()) {
		case Intrinsic::not_intrinsic:
			// state may be destroyed by this call, cannot touch
			callExternalFunction(state, ki, f, arguments);
			break;

			// va_arg is handled by caller and intrinsic lowering, see comment for
			// ExecutionState::varargs
		case Intrinsic::vastart: {
			StackFrame &sf = state.stack.back();
			assert(
					sf.varargs
							&& "vastart called in function with no vararg object");

			// FIXME: This is really specific to the architecture, not the pointer
			// size. This happens to work fir x86-32 and x86-64, however.
			Expr::Width WordSize = Context::get().getPointerWidth();
			if (WordSize == Expr::Int32) {
				executeMemoryOperation(state, true, arguments[0].first,
						sf.varargs->getBaseExpr(), ki, arguments[0].second, 0);
			} else {
				assert(WordSize == Expr::Int64 && "Unknown word size!");

				// X86-64 has quite complicated calling convention. However,
				// instead of implementing it, we can do a simple hack: just
				// make a function believe that all varargs are on stack.
				executeMemoryOperation(state, true, arguments[0].first,
						ConstantExpr::create(48, 32), ki, 0, 0); // gp_offset
				executeMemoryOperation(state, true,
						AddExpr::create(arguments[0].first,
								ConstantExpr::create(4, 64)),
						ConstantExpr::create(304, 32), ki, 0,
						arguments[0].second); // fp_offset
				executeMemoryOperation(state, true,
						AddExpr::create(arguments[0].first,
								ConstantExpr::create(8, 64)),
						sf.varargs->getBaseExpr(), ki, 0, arguments[0].second); // overflow_arg_area
				executeMemoryOperation(state, true,
						AddExpr::create(arguments[0].first,
								ConstantExpr::create(16, 64)),
						ConstantExpr::create(0, 64), ki, 0,
						arguments[0].second); // reg_save_area
			}
			break;
		}
		case Intrinsic::vaend:
			// va_end is a noop for the interpreter.
			//
			// FIXME: We should validate that the target didn't do something bad
			// with vaeend, however (like call it twice).
			break;

		case Intrinsic::vacopy:
			// va_copy should have been lowered.
			//
			// FIXME: It would be nice to check for errors in the usage of this as
			// well.
		default:
			klee_error("unknown intrinsic: %s", f->getName().data());
		}

		if (InvokeInst *ii = dyn_cast < InvokeInst > (i))
			transferToBasicBlock(ii->getNormalDest(), i->getParent(), state);
	} else {
		// FIXME: I'm not really happy about this reliance on prevPC but it is ok, I
		// guess. This just done to avoid having to pass KInstIterator everywhere
		// instead of the actual instruction, since we can't make a KInstIterator
		// from just an instruction (unlike LLVM).
		KFunction *kf = kmodule->functionMap[f];
		state.pushFrame(state.prevPC, kf);
		state.pc = kf->instructions;

		if (statsTracker)
			statsTracker->framePushed(state,
					&state.stack[state.stack.size() - 2]);

		// TODO: support "byval" parameter attribute
		// TODO: support zeroext, signext, sret attributes

		unsigned callingArgs = arguments.size();
		unsigned funcArgs = f->arg_size();
		if (!f->isVarArg()) {
			if (callingArgs > funcArgs) {
				klee_warning_once(f, "calling %s with extra arguments.",
						f->getName().data());
			} else if (callingArgs < funcArgs) {
				terminateStateOnError(state,
						"calling function with too few arguments", "user.err");
				return;
			}
		} else {
			Expr::Width WordSize = Context::get().getPointerWidth();

			if (callingArgs < funcArgs) {
				terminateStateOnError(state,
						"calling function with too few arguments", "user.err");
				return;
			}

			StackFrame &sf = state.stack.back();
			unsigned size = 0;
			for (unsigned i = funcArgs; i < callingArgs; i++) {
				// FIXME: This is really specific to the architecture, not the pointer
				// size. This happens to work fir x86-32 and x86-64, however.
				if (WordSize == Expr::Int32) {
					size += Expr::getMinBytesForWidth(
							arguments[i].first->getWidth());
				} else {
					Expr::Width argWidth = arguments[i].first->getWidth();
					// AMD64-ABI 3.5.7p5: Step 7. Align l->overflow_arg_area upwards to a 16
					// byte boundary if alignment needed by type exceeds 8 byte boundary.
					//
					// Alignment requirements for scalar types is the same as their size
					if (argWidth > Expr::Int64) {
						size = llvm::RoundUpToAlignment(size, 16);
					}
					size += llvm::RoundUpToAlignment(argWidth, WordSize) / 8;
				}
			}

			MemoryObject *mo = sf.varargs = memory->allocate(size, true, false,
					state.prevPC->inst);
			if (!mo) {
				terminateStateOnExecError(state, "out of memory (varargs)");
				return;
			}

			if ((WordSize == Expr::Int64) && (mo->address & 15)) {
				// Both 64bit Linux/Glibc and 64bit MacOSX should align to 16 bytes.
				klee_warning_once(0,
						"While allocating varargs: malloc did not align to 16 bytes.");
			}

			ObjectState *os = bindObjectInState(state, mo, true);
			unsigned offset = 0;
			for (unsigned i = funcArgs; i < callingArgs; i++) {
				// FIXME: This is really specific to the architecture, not the pointer
				// size. This happens to work fir x86-32 and x86-64, however.
				if (WordSize == Expr::Int32) {
					os->write(offset, arguments[i].first);
					for (unsigned j = 0; j < arguments[i].first->getWidth() / 8;
							j++)
						os->writeByteTaint(offset + j, arguments[i].second);
					offset += Expr::getMinBytesForWidth(
							arguments[i].first->getWidth());
				} else {
					assert(WordSize == Expr::Int64 && "Unknown word size!");

					Expr::Width argWidth = arguments[i].first->getWidth();
					if (argWidth > Expr::Int64) {
						offset = llvm::RoundUpToAlignment(offset, 16);
					}
					os->write(offset, arguments[i].first);
					for (unsigned j = 0; j < arguments[i].first->getWidth() / 8;
							j++)
						os->writeByteTaint(offset + j, arguments[i].second);
					offset += llvm::RoundUpToAlignment(argWidth, WordSize) / 8;
				}
			}
		}

		unsigned numFormals = f->arg_size();
		for (unsigned i = 0; i < numFormals; ++i)
			bindArgument(kf, i, state, arguments[i].first, arguments[i].second);

		if (INTERPOLATION_ENABLED) {
			std::vector<ref<Expr> > argumentExprMembers;
			argumentExprMembers.reserve(numFormals);
			for (unsigned j = 0; j < numFormals; ++j)
				argumentExprMembers.push_back(arguments[j].first);
			// We bind the abstract dependency call arguments
			state.itreeNode->bindCallArguments(state.prevPC->inst,
					argumentExprMembers);
		}
	}
}

void Executor::transferToBasicBlock(BasicBlock *dst, BasicBlock *src,
		ExecutionState &state) {
	// Note that in general phi nodes can reuse phi values from the same
	// block but the incoming value is the eval() result *before* the
	// execution of any phi nodes. this is pathological and doesn't
	// really seem to occur, but just in case we run the PhiCleanerPass
	// which makes sure this cannot happen and so it is safe to just
	// eval things in order. The PhiCleanerPass also makes sure that all
	// incoming blocks have the same order for each PHINode so we only
	// have to compute the index once.
	//
	// With that done we simply set an index in the state so that PHI
	// instructions know which argument to eval, set the pc, and continue.

	// XXX this lookup has to go ?
	KFunction *kf = state.stack.back().kf;
	unsigned entry = kf->basicBlockEntry[dst];
	state.pc = &kf->instructions[entry];
	if (state.pc->inst->getOpcode() == Instruction::PHI) {
		PHINode *first = static_cast<PHINode*>(state.pc->inst);
		state.incomingBBIndex = first->getBasicBlockIndex(src);
	}
}

void Executor::printFileLine(ExecutionState &state, KInstruction *ki) {
	const InstructionInfo &ii = *ki->info;
	if (ii.file != "")
		llvm::errs() << "     " << ii.file << ":" << ii.line << ":";
	else
		llvm::errs() << "     [no debug info]:";
}

/// Compute the true target of a function call, resolving LLVM and KLEE aliases
/// and bitcasts.
Function* Executor::getTargetFunction(Value *calledVal, ExecutionState &state) {
	SmallPtrSet<const GlobalValue*, 3> Visited;

	Constant *c = dyn_cast < Constant > (calledVal);
	if (!c)
		return 0;

	while (true) {
		if (GlobalValue *gv = dyn_cast < GlobalValue > (c)) {
			if (!Visited.insert(gv))
				return 0;

			std::string alias = state.getFnAlias(gv->getName());
			if (alias != "") {
				llvm::Module* currModule = kmodule->module;
				GlobalValue *old_gv = gv;
				gv = currModule->getNamedValue(alias);
				if (!gv) {
					llvm::errs() << "Function " << alias << "(), alias for "
							<< old_gv->getName() << " not found!\n";
					assert(0 && "function alias not found");
				}
			}

			if (Function *f = dyn_cast < Function > (gv))
				return f;
			else if (GlobalAlias *ga = dyn_cast < GlobalAlias > (gv))
				c = ga->getAliasee();
			else
				return 0;
		} else if (llvm::ConstantExpr *ce = dyn_cast < llvm::ConstantExpr
				> (c)) {
			if (ce->getOpcode() == Instruction::BitCast)
				c = ce->getOperand(0);
			else
				return 0;
		} else
			return 0;
	}
}

/// TODO remove?
static bool isDebugIntrinsic(const Function *f, KModule *KM) {
	return false;
}

static inline const llvm::fltSemantics * fpWidthToSemantics(unsigned width) {
	switch (width) {
	case Expr::Int32:
		return &llvm::APFloat::IEEEsingle;
	case Expr::Int64:
		return &llvm::APFloat::IEEEdouble;
	case Expr::Fl80:
		return &llvm::APFloat::x87DoubleExtended;
	default:
		return 0;
	}
}

void Executor::executeInstruction(ExecutionState &state, KInstruction *ki) {
	Instruction *i = ki->inst;
	if (interpreterOpts.TaintConfig.has(TaintConfig::Regions)) {
		int stack_counter = 0;
		int currentRegionDepth = state.getRegionDepth();
		int newRegionDepth = kmodule->regions.find(i->getParent())->second;
		if (currentRegionDepth < newRegionDepth)
			for (stack_counter = currentRegionDepth;
					stack_counter < newRegionDepth; stack_counter++)
				state.enterRegion();
		else if (currentRegionDepth > newRegionDepth)
			for (stack_counter = currentRegionDepth;
					stack_counter > newRegionDepth; stack_counter--)
				state.leaveRegion();
	}

	switch (i->getOpcode()) {
	// Control flow
	case Instruction::Ret: {
		ReturnInst *ri = cast < ReturnInst > (i);
		KInstIterator kcaller = state.stack.back().caller;
		Instruction *caller = kcaller ? kcaller->inst : 0;
		bool isVoidReturn = (ri->getNumOperands() == 0);
		ref<Expr> result = ConstantExpr::alloc(0, Expr::Bool);
		TaintSet taint = 0;

		if (!isVoidReturn) {
			Cell cell = eval(ki, 0, state);
			result = cell.value;
			taint = cell.taint;
		}

		if (state.stack.size() <= 1) {
			assert(!caller && "caller set on initial stack frame");
			terminateStateOnExit(state);
		} else {
			state.popFrame(ki, result);

			if (statsTracker)
				statsTracker->framePopped(state);

			if (InvokeInst *ii = dyn_cast < InvokeInst > (caller)) {
				transferToBasicBlock(ii->getNormalDest(), caller->getParent(),
						state);
			} else {
				state.pc = kcaller;
				++state.pc;
			}

			if (!isVoidReturn) {
				LLVM_TYPE_Q Type *t = caller->getType();
				if (t != Type::getVoidTy(getGlobalContext())) {
					// may need to do coercion due to bitcasts
					Expr::Width from = result->getWidth();
					Expr::Width to = getWidthForLLVMType(t);

					if (from != to) {
						CallSite cs = (
								isa < InvokeInst > (caller) ?
										CallSite(cast < InvokeInst > (caller)) :
										CallSite(cast < CallInst > (caller)));

						// XXX need to check other param attrs ?
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
						bool isSExt = cs.paramHasAttr(0, llvm::Attribute::SExt);
#elif LLVM_VERSION_CODE >= LLVM_VERSION(3, 2)
						bool isSExt = cs.paramHasAttr(0, llvm::Attributes::SExt);
#else
						bool isSExt = cs.paramHasAttr(0, llvm::Attribute::SExt);
#endif
						if (isSExt) {
							result = SExtExpr::create(result, to);
						} else {
							result = ZExtExpr::create(result, to);
						}
					}

					bindLocal(kcaller, state, result, taint);
				}
			} else {
				// We check that the return value has no users instead of
				// checking the type, since C defaults to returning int for
				// undeclared functions.
				if (!caller->use_empty()) {
					terminateStateOnExecError(state,
							"return void when caller expected a result");
				}
			}
		}
		break;
	}
#if LLVM_VERSION_CODE < LLVM_VERSION(3, 1)
		case Instruction::Unwind: {
			for (;;) {
				KInstruction *kcaller = state.stack.back().caller;
				state.popFrame(ki, ConstantExpr::alloc(0, Expr::Bool));

				if (statsTracker)
				statsTracker->framePopped(state);

				if (state.stack.empty()) {
					terminateStateOnExecError(state, "unwind from initial stack frame");
					break;
				} else {
					Instruction *caller = kcaller->programPoint;
					if (InvokeInst *ii = dyn_cast<InvokeInst>(caller)) {
						transferToBasicBlock(ii->getUnwindDest(), caller->getParent(), state);
						break;
					}
				}
			}
			if (INTERPOLATION_ENABLED)
			interpTree->execute(i);
			break;
		}
#endif
	case Instruction::Br: {
		BranchInst *bi = cast < BranchInst > (i);
		if (bi->isUnconditional()) {
			transferToBasicBlock(bi->getSuccessor(0), bi->getParent(), state);
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i);
		} else {
			// FIXME: Find a way that we don't have this hidden dependency.
			assert(
					bi->getCondition() == bi->getOperand(0)
							&& "Wrong operand index!");

			//TanNguyen: Temporary lock
			/*if (interpreterOpts.TaintConfig.has(TaintConfig::ControlFlow)) {
			 if (eval(ki, 0, state).taint != 0) {
			 llvm::errs() << "Tainted condition PC retainted \n";

			 if (state.currentTaintCount
			 == (state.maxCurrentTaint - 5)) {
			 int sizeOfNew = state.maxCurrentTaint + 100;
			 int* pathTaintNew = new int[sizeOfNew];
			 for (int i = 0; i <= state.currentTaintCount; i++) {
			 pathTaintNew[i] = state.stateTrackingTaint[i];
			 }
			 state.stateTrackingTaint = pathTaintNew;
			 state.maxCurrentTaint = sizeOfNew;
			 }
			 state.stateTrackingTaint[state.currentTaintCount] =
			 TaintInitializer++;
			 ++state.currentTaintCount;
			 }
			 state.setPCTaint(state.getPCTaint() | eval(ki, 0, state).taint);
			 }*/

			ref<Expr> cond = eval(ki, 0, state).value;
			Executor::StatePair branches = fork(state, cond, false);

			// NOTE: There is a hidden dependency here, markBranchVisited
			// requires that we still be in the context of the branch
			// instruction (it reuses its statistic id). Should be cleaned
			// up with convenient instruction specific data.
			if (statsTracker && state.stack.back().kf->trackCoverage)
				statsTracker->markBranchVisited(branches.first,
						branches.second);

			if (branches.first) {
				assert(
						branches.first->taint == state.taint
								&& "Taint should be propagated to forking states!");
				transferToBasicBlock(bi->getSuccessor(0), bi->getParent(),
						*branches.first);
			}
			if (branches.second) {
				assert(
						branches.second->taint == state.taint
								&& "Taint should be propagated to forking states!");
				transferToBasicBlock(bi->getSuccessor(1), bi->getParent(),
						*branches.second);
			}

			// Below we test if some of the branches are not available for
			// exploration, which means that there is a dependency of the program
			// state on the control variables in the conditional. Such variables
			// (allocations) need to be marked as belonging to the core.
			// This is mainly to take care of the case when the conditional
			// variables are not marked using unsatisfiability core as the
			// conditional is concrete and therefore there has been no invocation
			// of the solver to decide its satisfiability, and no generation
			// of the unsatisfiability core.
			if (INTERPOLATION_ENABLED
					&& ((!branches.first && branches.second)
							|| (branches.first && !branches.second)))
				interpTree->execute(i);
		}
		break;
	}
	case Instruction::Switch: {
		SwitchInst *si = cast < SwitchInst > (i);
		ref<Expr> cond = eval(ki, 0, state).value;
		BasicBlock *bb = si->getParent();

		//TanNguyen: Temporary lock
		/*if (interpreterOpts.TaintConfig.has(TaintConfig::ControlFlow)) {
		 if (eval(ki, 0, state).taint != 0) {
		 klee_warning(
		 "Tainted condition PC retainted from 0x%08x to 0x%08x",
		 eval(ki, 0, state).taint,
		 state.getPCTaint() | eval(ki, 0, state).taint);
		 if (state.currentTaintCount == (state.maxCurrentTaint - 5)) {
		 int sizeOfNew = state.maxCurrentTaint + 100;
		 int* pathTaintNew = new int[sizeOfNew];
		 for (int i = 0; i <= state.currentTaintCount; i++) {
		 pathTaintNew[i] = state.stateTrackingTaint[i];
		 }
		 state.stateTrackingTaint = pathTaintNew;
		 state.maxCurrentTaint = sizeOfNew;
		 }
		 state.stateTrackingTaint[state.currentTaintCount] =
		 TaintInitializer++;
		 ++state.currentTaintCount;
		 }
		 state.setPCTaint(state.getPCTaint() | eval(ki, 0, state).taint);
		 }*/

		cond = toUnique(state, cond);
		if (ConstantExpr *CE = dyn_cast < ConstantExpr > (cond)) {
			// Somewhat gross to create these all the time, but fine till we
			// switch to an internal rep.
			LLVM_TYPE_Q llvm::IntegerType *Ty = cast < IntegerType
					> (si->getCondition()->getType());
			ConstantInt *ci = ConstantInt::get(Ty, CE->getZExtValue());
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 1)
			unsigned index = si->findCaseValue(ci).getSuccessorIndex();
#else
			unsigned index = si->findCaseValue(ci);
#endif
			transferToBasicBlock(si->getSuccessor(index), si->getParent(),
					state);
		} else {
			std::map<BasicBlock*, ref<Expr> > targets;
			ref<Expr> isDefault = ConstantExpr::alloc(1, Expr::Bool);
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 1)      
			for (SwitchInst::CaseIt i = si->case_begin(), e = si->case_end();
					i != e; ++i) {
				ref<Expr> value = evalConstant(i.getCaseValue());
#else
				for (unsigned i=1, cases = si->getNumCases(); i<cases; ++i) {
					ref<Expr> value = evalConstant(si->getCaseValue(i));
#endif
				ref<Expr> match = EqExpr::create(cond, value);
				isDefault = AndExpr::create(isDefault,
						Expr::createIsZero(match));
				bool result;
				bool success = solver->mayBeTrue(state, match, result);
				assert(success && "FIXME: Unhandled solver failure");
				(void) success;
				if (result) {
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 1)
					BasicBlock *caseSuccessor = i.getCaseSuccessor();
#else
					BasicBlock *caseSuccessor = si->getSuccessor(i);
#endif
					std::map<BasicBlock*, ref<Expr> >::iterator it =
							targets.insert(
									std::make_pair(caseSuccessor,
											ConstantExpr::alloc(0, Expr::Bool))).first;

					it->second = OrExpr::create(match, it->second);
				}
			}
			bool res;
			bool success = solver->mayBeTrue(state, isDefault, res);
			assert(success && "FIXME: Unhandled solver failure");
			(void) success;
			if (res)
				targets.insert(std::make_pair(si->getDefaultDest(), isDefault));

			std::vector<ref<Expr> > conditions;
			for (std::map<BasicBlock*, ref<Expr> >::iterator it =
					targets.begin(), ie = targets.end(); it != ie; ++it)
				conditions.push_back(it->second);

			std::vector<ExecutionState*> branches;
			branch(state, conditions, branches);

			std::vector<ExecutionState*>::iterator bit = branches.begin();
			for (std::map<BasicBlock*, ref<Expr> >::iterator it =
					targets.begin(), ie = targets.end(); it != ie; ++it) {
				ExecutionState *es = *bit;
				if (es)
					transferToBasicBlock(it->first, bb, *es);
				++bit;
			}
		}
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i);
		break;
	}
	case Instruction::Unreachable:
		// Note that this is not necessarily an internal bug, llvm will
		// generate unreachable instructions in cases where it knows the
		// program will crash. So it is effectively a SEGV or internal
		// error.
		terminateStateOnExecError(state, "reached \"unreachable\" instruction");
		break;

	case Instruction::Invoke:
	case Instruction::Call: {
		CallSite cs(i);
		unsigned numArgs = cs.arg_size();
		Value *fp = cs.getCalledValue();
		Function *f = getTargetFunction(fp, state);

		// Skip debug intrinsics, we can't evaluate their metadata arguments.
		if (f && isDebugIntrinsic(f, kmodule))
			break;

		if (isa < InlineAsm > (fp)) {
			terminateStateOnExecError(state, "inline assembly is unsupported");
			break;
		}
		// evaluate arguments
		std::vector < std::pair<ref<Expr>, TaintSet> > arguments;
		arguments.reserve(numArgs);

		for (unsigned j = 0; j < numArgs; ++j) {
			Cell cell = eval(ki, j + 1, state);
			arguments.push_back(std::make_pair(cell.value, cell.taint));
		}

		if (f) {
			const FunctionType *fType = dyn_cast < FunctionType
					> (cast < PointerType > (f->getType())->getElementType());
			const FunctionType *fpType = dyn_cast < FunctionType
					> (cast < PointerType > (fp->getType())->getElementType());

			// special case the call with a bitcast case
			if (fType != fpType) {
				assert(fType && fpType && "unable to get function type");

				// XXX check result coercion

				// XXX this really needs thought and validation
				unsigned i = 0;
				for (std::vector<std::pair<ref<Expr>, TaintSet> >::iterator ai =
						arguments.begin(), ie = arguments.end(); ai != ie;
						++ai) {
					Expr::Width to, from = (*ai).first->getWidth();

					if (i < fType->getNumParams()) {
						to = getWidthForLLVMType(fType->getParamType(i));

						if (from != to) {
							// XXX need to check other param attrs ?
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
							bool isSExt = cs.paramHasAttr(i + 1,
									llvm::Attribute::SExt);
#elif LLVM_VERSION_CODE >= LLVM_VERSION(3, 2)
							bool isSExt = cs.paramHasAttr(i+1, llvm::Attributes::SExt);
#else
							bool isSExt = cs.paramHasAttr(i+1, llvm::Attribute::SExt);
#endif
							if (isSExt) {
								arguments[i].first = SExtExpr::create(
										arguments[i].first, to);
							} else {
								arguments[i].first = ZExtExpr::create(
										arguments[i].first, to);
							}
						}
					}

					i++;
				}
			}
			executeCall(state, ki, f, arguments);
		} else {
			ref<Expr> v = eval(ki, 0, state).value;

			ExecutionState *free = &state;
			bool hasInvalid = false, first = true;

			/* XXX This is wasteful, no need to do a full evaluate since we
			 have already got a value. But in the end the caches should
			 handle it for us, albeit with some overhead. */
			do {
				ref<ConstantExpr> value;
				bool success = solver->getValue(*free, v, value);
				assert(success && "FIXME: Unhandled solver failure");
				(void) success;
				StatePair res = fork(*free, EqExpr::create(v, value), true);
				if (res.first) {
					uint64_t addr = value->getZExtValue();
					if (legalFunctions.count(addr)) {
						f = (Function*) addr;

						// Don't give warning on unique resolution
						if (res.second || !first)
							klee_warning_once((void*) (unsigned long) addr,
									"resolved symbolic function pointer to: %s",
									f->getName().data());

						executeCall(*res.first, ki, f, arguments);
					} else {
						if (!hasInvalid) {
							terminateStateOnExecError(state,
									"invalid function pointer");
							hasInvalid = true;
						}
					}
				}

				first = false;
				free = res.second;
			} while (free);
		}
		break;
	}
	case Instruction::PHI: {
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 0)
		Cell result = eval(ki, state.incomingBBIndex, state);
#else
		Cell result = eval(ki, state.incomingBBIndex * 2, state);
#endif
		bindLocal(ki, state, result.value, result.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED) {
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 0)
			interpTree->executePHI(i, state.incomingBBIndex, result.value);
#else
			interpTree->executePHI(i, state.incomingBBIndex * 2, result.value);
#endif
		}

		break;
	}

		// Special instructions
	case Instruction::Select: {
		Cell cond = eval(ki, 0, state);
		Cell tExpr = eval(ki, 1, state);
		Cell fExpr = eval(ki, 2, state);
		ref<Expr> result = SelectExpr::create(cond.value, tExpr.value,
				fExpr.value);
		bindLocal(ki, state, result, cond.taint | tExpr.taint | fExpr.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, tExpr.value, fExpr.value);
		break;
	}

	case Instruction::VAArg:
		terminateStateOnExecError(state, "unexpected VAArg instruction");
		break;

		// Arithmetic / logical

	case Instruction::Add: {
		Cell left = eval(ki, 0, state);
		Cell right = eval(ki, 1, state);
		ref<Expr> result = AddExpr::create(left.value, right.value);
		bindLocal(ki, state, result, left.taint | right.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left.value, right.value);
		break;
	}

	case Instruction::Sub: {
		Cell left = eval(ki, 0, state);
		Cell right = eval(ki, 1, state);
		ref<Expr> result = SubExpr::create(left.value, right.value);
		bindLocal(ki, state, result, left.taint | right.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left.value, right.value);
		break;
	}

	case Instruction::Mul: {
		Cell left = eval(ki, 0, state);
		Cell right = eval(ki, 1, state);
		ref<Expr> result = MulExpr::create(left.value, right.value);
		bindLocal(ki, state, result, left.taint | right.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left.value, right.value);
		break;
	}

	case Instruction::UDiv: {
		Cell left = eval(ki, 0, state);
		Cell right = eval(ki, 1, state);
		ref<Expr> result = UDivExpr::create(left.value, right.value);
		bindLocal(ki, state, result, left.taint | right.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left.value, right.value);
		break;
	}

	case Instruction::SDiv: {
		Cell left = eval(ki, 0, state);
		Cell right = eval(ki, 1, state);
		ref<Expr> result = SDivExpr::create(left.value, right.value);
		bindLocal(ki, state, result, left.taint | right.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left.value, right.value);
		break;
	}

	case Instruction::URem: {
		Cell left = eval(ki, 0, state);
		Cell right = eval(ki, 1, state);
		ref<Expr> result = URemExpr::create(left.value, right.value);
		bindLocal(ki, state, result, left.taint | right.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left.value, right.value);
		break;
	}

	case Instruction::SRem: {
		Cell left = eval(ki, 0, state);
		Cell right = eval(ki, 1, state);
		ref<Expr> result = SRemExpr::create(left.value, right.value);
		bindLocal(ki, state, result, left.taint | right.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left.value, right.value);
		break;
	}

	case Instruction::And: {
		Cell left = eval(ki, 0, state);
		Cell right = eval(ki, 1, state);
		ref<Expr> result = AndExpr::create(left.value, right.value);
		bindLocal(ki, state, result, left.taint | right.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left.value, right.value);
		break;
	}

	case Instruction::Or: {
		Cell left = eval(ki, 0, state);
		Cell right = eval(ki, 1, state);
		ref<Expr> result = OrExpr::create(left.value, right.value);
		bindLocal(ki, state, result, left.taint | right.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left.value, right.value);
		break;
	}

	case Instruction::Xor: {
		Cell left = eval(ki, 0, state);
		Cell right = eval(ki, 1, state);
		ref<Expr> result = XorExpr::create(left.value, right.value);
		bindLocal(ki, state, result, left.taint | right.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left.value, right.value);
		break;
	}

	case Instruction::Shl: {
		Cell left = eval(ki, 0, state);
		Cell right = eval(ki, 1, state);
		ref<Expr> result = ShlExpr::create(left.value, right.value);
		bindLocal(ki, state, result, left.taint | right.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left.value, right.value);
		break;
	}

	case Instruction::LShr: {
		Cell left = eval(ki, 0, state);
		Cell right = eval(ki, 1, state);
		ref<Expr> result = LShrExpr::create(left.value, right.value);
		bindLocal(ki, state, result, left.taint | right.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left.value, right.value);
		break;
	}

	case Instruction::AShr: {
		Cell left = eval(ki, 0, state);
		Cell right = eval(ki, 1, state);
		ref<Expr> result = AShrExpr::create(left.value, right.value);
		bindLocal(ki, state, result, left.taint | right.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left.value, right.value);
		break;
	}

		// Compare

	case Instruction::ICmp: {
		CmpInst *ci = cast < CmpInst > (i);
		ICmpInst *ii = cast < ICmpInst > (ci);
		Cell left = eval(ki, 0, state);
		Cell right = eval(ki, 1, state);
		ref<Expr> result;

		switch (ii->getPredicate()) {
		case ICmpInst::ICMP_EQ: {
			result = EqExpr::create(left.value, right.value);
			break;
		}

		case ICmpInst::ICMP_NE: {
			result = NeExpr::create(left.value, right.value);
			break;
		}

		case ICmpInst::ICMP_UGT: {
			result = UgtExpr::create(left.value, right.value);
			break;
		}

		case ICmpInst::ICMP_UGE: {
			result = UgeExpr::create(left.value, right.value);
			break;
		}

		case ICmpInst::ICMP_ULT: {
			result = UltExpr::create(left.value, right.value);
			break;
		}

		case ICmpInst::ICMP_ULE: {
			result = UleExpr::create(left.value, right.value);
			break;
		}

		case ICmpInst::ICMP_SGT: {
			result = SgtExpr::create(left.value, right.value);
			break;
		}

		case ICmpInst::ICMP_SGE: {
			result = SgeExpr::create(left.value, right.value);
			break;
		}

		case ICmpInst::ICMP_SLT: {
			result = SltExpr::create(left.value, right.value);
			break;
		}

		case ICmpInst::ICMP_SLE: {
			result = SleExpr::create(left.value, right.value);
			break;
		}

		default:
			terminateStateOnExecError(state, "invalid ICmp predicate");
		}

		bindLocal(ki, state, result, left.taint | right.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left.value, right.value);
		break;
	}

		// Memory instructions...
	case Instruction::Alloca: {
		AllocaInst *ai = cast < AllocaInst > (i);
		unsigned elementSize = kmodule->targetData->getTypeStoreSize(
				ai->getAllocatedType());
		ref<Expr> size = Expr::createPointer(elementSize);
		if (ai->isArrayAllocation()) {
			ref<Expr> count = eval(ki, 0, state).value;
			count = Expr::createZExtToPointerWidth(count);
			size = MulExpr::create(size, count);
		}
		bool isLocal = i->getOpcode() == Instruction::Alloca;
		executeAlloc(state, size, isLocal, ki);
		break;
	}

	case Instruction::Load: {
		executeMemoryOperation(state, false, eval(ki, 0, state).value, 0, ki,
				eval(ki, 0, state).taint, 0);
		break;
	}
	case Instruction::Store: {
		executeMemoryOperation(state, true, eval(ki, 1, state).value,
				eval(ki, 0, state).value, ki, eval(ki, 1, state).taint,
				eval(ki, 0, state).taint);
		break;
	}

	case Instruction::GetElementPtr: {
		KGEPInstruction *kgepi = static_cast<KGEPInstruction*>(ki);
		Cell base = eval(ki, 0, state);
		TaintSet taint = base.taint;
		ref<Expr> result = base.value;

		ref<Expr> oldResult = result;
		for (std::vector<std::pair<unsigned, uint64_t> >::iterator it =
				kgepi->indices.begin(), ie = kgepi->indices.end(); it != ie;
				++it) {
			uint64_t elementSize = it->second;

			Cell index = eval(ki, it->first, state);
			result = AddExpr::create(result,
					MulExpr::create(Expr::createSExtToPointerWidth(index.value),
							Expr::createPointer(elementSize)));
			taint |= index.taint;
		}
		if (kgepi->offset)
			result = AddExpr::create(result,
					Expr::createPointer(kgepi->offset));

		bindLocal(ki, state, result, taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, oldResult);
		break;
	}

		// Conversion
	case Instruction::Trunc: {
		CastInst *ci = cast < CastInst > (i);
		Cell arg = eval(ki, 0, state);
		ref<Expr> result = ExtractExpr::create(arg.value, 0,
				getWidthForLLVMType(ci->getType()));
		bindLocal(ki, state, result, arg.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result);
		break;
	}
	case Instruction::ZExt: {
		CastInst *ci = cast < CastInst > (i);
		Cell arg = eval(ki, 0, state);
		ref<Expr> result = ZExtExpr::create(arg.value,
				getWidthForLLVMType(ci->getType()));
		bindLocal(ki, state, result, arg.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result);
		break;
	}
	case Instruction::SExt: {
		CastInst *ci = cast < CastInst > (i);
		Cell arg = eval(ki, 0, state);
		ref<Expr> result = SExtExpr::create(arg.value,
				getWidthForLLVMType(ci->getType()));
		bindLocal(ki, state, result, arg.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result);
		break;
	}

	case Instruction::IntToPtr: {
		CastInst *ci = cast < CastInst > (i);
		Expr::Width pType = getWidthForLLVMType(ci->getType());
		Cell arg = eval(ki, 0, state);
		ref<Expr> result = ZExtExpr::create(arg.value, pType);
		bindLocal(ki, state, result, arg.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result);
		break;
	}
	case Instruction::PtrToInt: {
		CastInst *ci = cast < CastInst > (i);
		Expr::Width iType = getWidthForLLVMType(ci->getType());
		Cell arg = eval(ki, 0, state);
		ref<Expr> result = ZExtExpr::create(arg.value, iType);
		bindLocal(ki, state, result, arg.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result);
		break;
	}

	case Instruction::BitCast: {
		Cell result = eval(ki, 0, state);
		bindLocal(ki, state, result.value, result.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result.value);
		break;
	}

		// Floating point instructions

	case Instruction::FAdd: {
		ref<ConstantExpr> left = toConstant(state, eval(ki, 0, state).value,
				"floating point");
		ref<ConstantExpr> right = toConstant(state, eval(ki, 1, state).value,
				"floating point");
		if (!fpWidthToSemantics(left->getWidth())
				|| !fpWidthToSemantics(right->getWidth()))
			return terminateStateOnExecError(state,
					"Unsupported FAdd operation");

#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
		llvm::APFloat Res(*fpWidthToSemantics(left->getWidth()),
				left->getAPValue());
		Res.add(
				APFloat(*fpWidthToSemantics(right->getWidth()),
						right->getAPValue()), APFloat::rmNearestTiesToEven);
#else
		llvm::APFloat Res(left->getAPValue());
		Res.add(APFloat(right->getAPValue()), APFloat::rmNearestTiesToEven);
#endif
		ref<Expr> result = ConstantExpr::alloc(Res.bitcastToAPInt());
		bindLocal(ki, state, result,
				eval(ki, 0, state).taint | eval(ki, 1, state).taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left, right);
		break;
	}

	case Instruction::FSub: {
		ref<ConstantExpr> left = toConstant(state, eval(ki, 0, state).value,
				"floating point");
		ref<ConstantExpr> right = toConstant(state, eval(ki, 1, state).value,
				"floating point");
		if (!fpWidthToSemantics(left->getWidth())
				|| !fpWidthToSemantics(right->getWidth()))
			return terminateStateOnExecError(state,
					"Unsupported FSub operation");
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
		llvm::APFloat Res(*fpWidthToSemantics(left->getWidth()),
				left->getAPValue());
		Res.subtract(
				APFloat(*fpWidthToSemantics(right->getWidth()),
						right->getAPValue()), APFloat::rmNearestTiesToEven);
#else
		llvm::APFloat Res(left->getAPValue());
		Res.subtract(APFloat(right->getAPValue()), APFloat::rmNearestTiesToEven);
#endif
		ref<Expr> result = ConstantExpr::alloc(Res.bitcastToAPInt());
		bindLocal(ki, state, result,
				eval(ki, 0, state).taint | eval(ki, 1, state).taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left, right);
		break;
	}

	case Instruction::FMul: {
		ref<ConstantExpr> left = toConstant(state, eval(ki, 0, state).value,
				"floating point");
		ref<ConstantExpr> right = toConstant(state, eval(ki, 1, state).value,
				"floating point");
		if (!fpWidthToSemantics(left->getWidth())
				|| !fpWidthToSemantics(right->getWidth()))
			return terminateStateOnExecError(state,
					"Unsupported FMul operation");

#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
		llvm::APFloat Res(*fpWidthToSemantics(left->getWidth()),
				left->getAPValue());
		Res.multiply(
				APFloat(*fpWidthToSemantics(right->getWidth()),
						right->getAPValue()), APFloat::rmNearestTiesToEven);
#else
		llvm::APFloat Res(left->getAPValue());
		Res.multiply(APFloat(right->getAPValue()), APFloat::rmNearestTiesToEven);
#endif
		ref<Expr> result = ConstantExpr::alloc(Res.bitcastToAPInt());
		bindLocal(ki, state, result,
				eval(ki, 0, state).taint | eval(ki, 1, state).taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left, right);
		break;
	}

	case Instruction::FDiv: {
		ref<ConstantExpr> left = toConstant(state, eval(ki, 0, state).value,
				"floating point");
		ref<ConstantExpr> right = toConstant(state, eval(ki, 1, state).value,
				"floating point");
		if (!fpWidthToSemantics(left->getWidth())
				|| !fpWidthToSemantics(right->getWidth()))
			return terminateStateOnExecError(state,
					"Unsupported FDiv operation");

#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
		llvm::APFloat Res(*fpWidthToSemantics(left->getWidth()),
				left->getAPValue());
		Res.divide(
				APFloat(*fpWidthToSemantics(right->getWidth()),
						right->getAPValue()), APFloat::rmNearestTiesToEven);
#else
		llvm::APFloat Res(left->getAPValue());
		Res.divide(APFloat(right->getAPValue()), APFloat::rmNearestTiesToEven);
#endif
		ref<Expr> result = ConstantExpr::alloc(Res.bitcastToAPInt());
		bindLocal(ki, state, result,
				eval(ki, 0, state).taint | eval(ki, 1, state).taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left, right);
		break;
	}

	case Instruction::FRem: {
		ref<ConstantExpr> left = toConstant(state, eval(ki, 0, state).value,
				"floating point");
		ref<ConstantExpr> right = toConstant(state, eval(ki, 1, state).value,
				"floating point");
		if (!fpWidthToSemantics(left->getWidth())
				|| !fpWidthToSemantics(right->getWidth()))
			return terminateStateOnExecError(state,
					"Unsupported FRem operation");
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
		llvm::APFloat Res(*fpWidthToSemantics(left->getWidth()),
				left->getAPValue());
		Res.mod(
				APFloat(*fpWidthToSemantics(right->getWidth()),
						right->getAPValue()), APFloat::rmNearestTiesToEven);
#else
		llvm::APFloat Res(left->getAPValue());
		Res.mod(APFloat(right->getAPValue()), APFloat::rmNearestTiesToEven);
#endif
		ref<Expr> result = ConstantExpr::alloc(Res.bitcastToAPInt());
		bindLocal(ki, state, result,
				eval(ki, 0, state).taint | eval(ki, 1, state).taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left, right);
		break;
	}

	case Instruction::FPTrunc: {
		FPTruncInst *fi = cast < FPTruncInst > (i);
		Expr::Width resultType = getWidthForLLVMType(fi->getType());
		ref<ConstantExpr> arg = toConstant(state, eval(ki, 0, state).value,
				"floating point");
		if (!fpWidthToSemantics(arg->getWidth())
				|| resultType > arg->getWidth())
			return terminateStateOnExecError(state,
					"Unsupported FPTrunc operation");

#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
		llvm::APFloat Res(*fpWidthToSemantics(arg->getWidth()),
				arg->getAPValue());
#else
		llvm::APFloat Res(arg->getAPValue());
#endif
		bool losesInfo = false;
		Res.convert(*fpWidthToSemantics(resultType),
				llvm::APFloat::rmNearestTiesToEven, &losesInfo);
		ref<Expr> result = ConstantExpr::alloc(Res);
		bindLocal(ki, state, result, eval(ki, 0, state).taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result);
		break;
	}

	case Instruction::FPExt: {
		FPExtInst *fi = cast < FPExtInst > (i);
		Expr::Width resultType = getWidthForLLVMType(fi->getType());
		ref<ConstantExpr> arg = toConstant(state, eval(ki, 0, state).value,
				"floating point");
		if (!fpWidthToSemantics(arg->getWidth())
				|| arg->getWidth() > resultType)
			return terminateStateOnExecError(state,
					"Unsupported FPExt operation");
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
		llvm::APFloat Res(*fpWidthToSemantics(arg->getWidth()),
				arg->getAPValue());
#else
		llvm::APFloat Res(arg->getAPValue());
#endif
		bool losesInfo = false;
		Res.convert(*fpWidthToSemantics(resultType),
				llvm::APFloat::rmNearestTiesToEven, &losesInfo);
		ref<Expr> result = ConstantExpr::alloc(Res);
		bindLocal(ki, state, result, eval(ki, 0, state).taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result);
		break;
	}

	case Instruction::FPToUI: {
		FPToUIInst *fi = cast < FPToUIInst > (i);
		Expr::Width resultType = getWidthForLLVMType(fi->getType());
		ref<ConstantExpr> arg = toConstant(state, eval(ki, 0, state).value,
				"floating point");
		if (!fpWidthToSemantics(arg->getWidth()) || resultType > 64)
			return terminateStateOnExecError(state,
					"Unsupported FPToUI operation");

#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
		llvm::APFloat Arg(*fpWidthToSemantics(arg->getWidth()),
				arg->getAPValue());
#else
		llvm::APFloat Arg(arg->getAPValue());
#endif
		uint64_t value = 0;
		bool isExact = true;
		Arg.convertToInteger(&value, resultType, false,
				llvm::APFloat::rmTowardZero, &isExact);
		ref<Expr> result = ConstantExpr::alloc(value, resultType);
		bindLocal(ki, state, result, eval(ki, 0, state).taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result);
		break;
	}

	case Instruction::FPToSI: {
		FPToSIInst *fi = cast < FPToSIInst > (i);
		Expr::Width resultType = getWidthForLLVMType(fi->getType());
		ref<ConstantExpr> arg = toConstant(state, eval(ki, 0, state).value,
				"floating point");
		if (!fpWidthToSemantics(arg->getWidth()) || resultType > 64)
			return terminateStateOnExecError(state,
					"Unsupported FPToSI operation");
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
		llvm::APFloat Arg(*fpWidthToSemantics(arg->getWidth()),
				arg->getAPValue());
#else
		llvm::APFloat Arg(arg->getAPValue());

#endif
		uint64_t value = 0;
		bool isExact = true;
		Arg.convertToInteger(&value, resultType, true,
				llvm::APFloat::rmTowardZero, &isExact);
		ref<Expr> result = ConstantExpr::alloc(value, resultType);
		bindLocal(ki, state, result, eval(ki, 0, state).taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result);
		break;
	}

	case Instruction::UIToFP: {
		UIToFPInst *fi = cast < UIToFPInst > (i);
		Expr::Width resultType = getWidthForLLVMType(fi->getType());
		ref<ConstantExpr> arg = toConstant(state, eval(ki, 0, state).value,
				"floating point");
		const llvm::fltSemantics *semantics = fpWidthToSemantics(resultType);
		if (!semantics)
			return terminateStateOnExecError(state,
					"Unsupported UIToFP operation");
		llvm::APFloat f(*semantics, 0);
		f.convertFromAPInt(arg->getAPValue(), false,
				llvm::APFloat::rmNearestTiesToEven);

		ref<Expr> result = ConstantExpr::alloc(f);
		bindLocal(ki, state, result, eval(ki, 0, state).taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result);
		break;
	}

	case Instruction::SIToFP: {
		SIToFPInst *fi = cast < SIToFPInst > (i);
		Expr::Width resultType = getWidthForLLVMType(fi->getType());
		ref<ConstantExpr> arg = toConstant(state, eval(ki, 0, state).value,
				"floating point");
		const llvm::fltSemantics *semantics = fpWidthToSemantics(resultType);
		if (!semantics)
			return terminateStateOnExecError(state,
					"Unsupported SIToFP operation");
		llvm::APFloat f(*semantics, 0);
		f.convertFromAPInt(arg->getAPValue(), true,
				llvm::APFloat::rmNearestTiesToEven);

		ref<Expr> result = ConstantExpr::alloc(f);
		bindLocal(ki, state, result, eval(ki, 0, state).taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result);
		break;
	}

	case Instruction::FCmp: {
		FCmpInst *fi = cast < FCmpInst > (i);
		ref<ConstantExpr> left = toConstant(state, eval(ki, 0, state).value,
				"floating point");
		ref<ConstantExpr> right = toConstant(state, eval(ki, 1, state).value,
				"floating point");
		if (!fpWidthToSemantics(left->getWidth())
				|| !fpWidthToSemantics(right->getWidth()))
			return terminateStateOnExecError(state,
					"Unsupported FCmp operation");

#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
		APFloat LHS(*fpWidthToSemantics(left->getWidth()), left->getAPValue());
		APFloat RHS(*fpWidthToSemantics(right->getWidth()),
				right->getAPValue());
#else
		APFloat LHS(left->getAPValue());
		APFloat RHS(right->getAPValue());
#endif
		APFloat::cmpResult CmpRes = LHS.compare(RHS);

		bool Result = false;
		switch (fi->getPredicate()) {
		// Predicates which only care about whether or not the operands are NaNs.
		case FCmpInst::FCMP_ORD:
			Result = CmpRes != APFloat::cmpUnordered;
			break;

		case FCmpInst::FCMP_UNO:
			Result = CmpRes == APFloat::cmpUnordered;
			break;

			// Ordered comparisons return false if either operand is NaN.  Unordered
			// comparisons return true if either operand is NaN.
		case FCmpInst::FCMP_UEQ:
			if (CmpRes == APFloat::cmpUnordered) {
				Result = true;
				break;
			}
		case FCmpInst::FCMP_OEQ:
			Result = CmpRes == APFloat::cmpEqual;
			break;

		case FCmpInst::FCMP_UGT:
			if (CmpRes == APFloat::cmpUnordered) {
				Result = true;
				break;
			}
		case FCmpInst::FCMP_OGT:
			Result = CmpRes == APFloat::cmpGreaterThan;
			break;

		case FCmpInst::FCMP_UGE:
			if (CmpRes == APFloat::cmpUnordered) {
				Result = true;
				break;
			}
		case FCmpInst::FCMP_OGE:
			Result = CmpRes == APFloat::cmpGreaterThan
					|| CmpRes == APFloat::cmpEqual;
			break;

		case FCmpInst::FCMP_ULT:
			if (CmpRes == APFloat::cmpUnordered) {
				Result = true;
				break;
			}
		case FCmpInst::FCMP_OLT:
			Result = CmpRes == APFloat::cmpLessThan;
			break;

		case FCmpInst::FCMP_ULE:
			if (CmpRes == APFloat::cmpUnordered) {
				Result = true;
				break;
			}
		case FCmpInst::FCMP_OLE:
			Result = CmpRes == APFloat::cmpLessThan
					|| CmpRes == APFloat::cmpEqual;
			break;

		case FCmpInst::FCMP_UNE:
			Result = CmpRes == APFloat::cmpUnordered
					|| CmpRes != APFloat::cmpEqual;
			break;
		case FCmpInst::FCMP_ONE:
			Result = CmpRes != APFloat::cmpUnordered
					&& CmpRes != APFloat::cmpEqual;
			break;

		default:
			assert(0 && "Invalid FCMP predicate!");
		case FCmpInst::FCMP_FALSE:
			Result = false;
			break;
		case FCmpInst::FCMP_TRUE:
			Result = true;
			break;
		}

		ref<Expr> result = ConstantExpr::alloc(Result, Expr::Bool);
		bindLocal(ki, state, result,
				eval(ki, 0, state).taint | eval(ki, 1, state).taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, left, right);
		break;
	}
	case Instruction::InsertValue: {
		KGEPInstruction *kgepi = static_cast<KGEPInstruction*>(ki);

		ref<Expr> agg = eval(ki, 0, state).value;
		ref<Expr> val = eval(ki, 1, state).value;

		ref<Expr> l = NULL, r = NULL;
		unsigned lOffset = kgepi->offset * 8, rOffset = kgepi->offset * 8
				+ val->getWidth();

		if (lOffset > 0)
			l = ExtractExpr::create(agg, 0, lOffset);
		if (rOffset < agg->getWidth())
			r = ExtractExpr::create(agg, rOffset, agg->getWidth() - rOffset);

		ref<Expr> result;
		if (!l.isNull() && !r.isNull())
			result = ConcatExpr::create(r, ConcatExpr::create(val, l));
		else if (!l.isNull())
			result = ConcatExpr::create(val, l);
		else if (!r.isNull())
			result = ConcatExpr::create(r, val);
		else
			result = val;

		bindLocal(ki, state, result,
				eval(ki, 0, state).taint | eval(ki, 1, state).taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result, agg, val);
		break;
	}
	case Instruction::ExtractValue: {
		KGEPInstruction *kgepi = static_cast<KGEPInstruction*>(ki);

		Cell agg = eval(ki, 0, state);

		ref<Expr> result = ExtractExpr::create(agg.value, kgepi->offset * 8,
				getWidthForLLVMType(i->getType()));

		bindLocal(ki, state, result, agg.taint);

		// Update dependency
		if (INTERPOLATION_ENABLED)
			interpTree->execute(i, result);
		break;
	}

		// Other instructions...
		// Unhandled
	case Instruction::ExtractElement:
	case Instruction::InsertElement:
	case Instruction::ShuffleVector:
		terminateStateOnError(state, "XXX vector instructions unhandled",
				"xxx.err");
		break;

	default:
		terminateStateOnExecError(state, "illegal instruction");
		break;
	}
}

void Executor::updateStates(ExecutionState *current) {

	// Clone pathSpecial Info
	for (std::set<ExecutionState*>::iterator it = addedStates.begin(), ie =
			addedStates.end(); it != ie; ++it) {
		ExecutionState *es = *it;
		es->pathSpecial = new KInstIterator[current->maxSpecialCount];
		es->maxSpecialCount = current->maxSpecialCount;

		for (int i = 0; i < current->pathSpecialCount; ++i) {
			es->pathSpecial[i] = current->pathSpecial[i];
		}
		es->pathSpecialCount = current->pathSpecialCount;
	}

	if (searcher) {
		searcher->update(current, addedStates, removedStates);
	}

	states.insert(addedStates.begin(), addedStates.end());
	addedStates.clear();

	for (std::set<ExecutionState*>::iterator it = removedStates.begin(), ie =
			removedStates.end(); it != ie; ++it) {
		ExecutionState *es = *it;
		std::set<ExecutionState*>::iterator it2 = states.find(es);
		assert(it2 != states.end());
		states.erase(it2);
		std::map<ExecutionState*, std::vector<SeedInfo> >::iterator it3 =
				seedMap.find(es);
		if (it3 != seedMap.end())
			seedMap.erase(it3);
		processTree->remove(es->ptreeNode);
		if (INTERPOLATION_ENABLED)
			interpTree->remove(es->itreeNode);
		delete es;
	}
	removedStates.clear();
}



template<typename TypeIt>
void Executor::computeOffsets(KGEPInstruction *kgepi, TypeIt ib, TypeIt ie) {
	ref<ConstantExpr> constantOffset = ConstantExpr::alloc(0,
			Context::get().getPointerWidth());
	uint64_t index = 1;
	for (TypeIt ii = ib; ii != ie; ++ii) {
		if (LLVM_TYPE_Q StructType *st = dyn_cast<StructType>(*ii)) {
			const StructLayout *sl = kmodule->targetData->getStructLayout(st);
			const ConstantInt *ci = cast<ConstantInt>(ii.getOperand());
			uint64_t addend = sl->getElementOffset(
					(unsigned) ci->getZExtValue());
			constantOffset = constantOffset->Add(
					ConstantExpr::alloc(addend,
							Context::get().getPointerWidth()));
		} else {
			const SequentialType *set = cast<SequentialType>(*ii);
			uint64_t elementSize = kmodule->targetData->getTypeStoreSize(
					set->getElementType());
			Value *operand = ii.getOperand();
			if (Constant *c = dyn_cast < Constant > (operand)) {
				ref<ConstantExpr> index = evalConstant(c)->SExt(
						Context::get().getPointerWidth());
				ref<ConstantExpr> addend = index->Mul(
						ConstantExpr::alloc(elementSize,
								Context::get().getPointerWidth()));
				constantOffset = constantOffset->Add(addend);
			} else {
				kgepi->indices.push_back(std::make_pair(index, elementSize));
			}
		}
		index++;
	}
	kgepi->offset = constantOffset->getZExtValue();
}



void Executor::bindInstructionConstants(KInstruction *KI) {
	KGEPInstruction *kgepi = static_cast<KGEPInstruction*>(KI);

	if (GetElementPtrInst *gepi = dyn_cast < GetElementPtrInst > (KI->inst)) {
		computeOffsets(kgepi, gep_type_begin(gepi), gep_type_end(gepi));
	} else if (InsertValueInst *ivi = dyn_cast < InsertValueInst > (KI->inst)) {
		computeOffsets(kgepi, iv_type_begin(ivi), iv_type_end(ivi));
		assert(
				kgepi->indices.empty()
						&& "InsertValue constant offset expected");
	} else if (ExtractValueInst *evi = dyn_cast < ExtractValueInst
			> (KI->inst)) {
		computeOffsets(kgepi, ev_type_begin(evi), ev_type_end(evi));
		assert(
				kgepi->indices.empty()
						&& "ExtractValue constant offset expected");
	}
}



void Executor::bindModuleConstants() {
	for (std::vector<KFunction*>::iterator it = kmodule->functions.begin(), ie =
			kmodule->functions.end(); it != ie; ++it) {
		KFunction *kf = *it;
		for (unsigned i = 0; i < kf->numInstructions; ++i)
			bindInstructionConstants(kf->instructions[i]);
	}

	kmodule->constantTable = new Cell[kmodule->constants.size()];
	for (unsigned i = 0; i < kmodule->constants.size(); ++i) {
		Cell &c = kmodule->constantTable[i];
		c.value = evalConstant(kmodule->constants[i]);
		c.taint = EMPTYTAINTSET;
	}
}



void Executor::checkMemoryUsage() {
	if (!MaxMemory)
		return;

	//TanNguyen: Bypass memory usage check
	return;

	if ((stats::instructions & 0xFFFF) == 0) {
		// We need to avoid calling GetTotalMallocUsage() often because it
		// is O(elts on freelist). This is really bad since we start
		// to pummel the freelist once we hit the memory cap.
		unsigned mbs = util::GetTotalMallocUsage() >> 20;
		if (mbs > MaxMemory) {
			if (mbs > MaxMemory + 100) {
				// just guess at how many to kill
				unsigned numStates = states.size();
				unsigned toKill = std::max(1U,
						numStates - numStates * MaxMemory / mbs);
				klee_warning("killing %d states (over memory cap)", toKill);
				std::vector<ExecutionState *> arr(states.begin(), states.end());
				for (unsigned i = 0, N = arr.size(); N && i < toKill;
						++i, --N) {
					unsigned idx = rand() % N;
					// Make two pulls to try and not hit a state that
					// covered new code.
					if (arr[idx]->coveredNew)
						idx = rand() % N;

					std::swap(arr[idx], arr[N - 1]);
					terminateStateEarly(*arr[N - 1], "Memory limit exceeded.");
				}
			}
			atMemoryLimit = true;
		} else {
			atMemoryLimit = false;
		}
	}
}



void Executor::run(ExecutionState &initialState) {

	bindModuleConstants();

	// Delay init till now so that ticks don't accrue during
	// optimization and such.
	initTimers();

	states.insert(&initialState);

	if (interpreterOpts.ExeConfig == Interpreter::SymbolicExecution) {
		if (usingSeeds) {
			std::vector<SeedInfo> &v = seedMap[&initialState];

			for (std::vector<KTest*>::const_iterator it = usingSeeds->begin(),
					ie = usingSeeds->end(); it != ie; ++it)
				v.push_back(SeedInfo(*it));

			int lastNumSeeds = usingSeeds->size() + 10;
			double lastTime, startTime = lastTime = util::getWallTime();
			ExecutionState *lastState = 0;
			while (!seedMap.empty()) {
				if (haltExecution)
					goto dump;

				std::map<ExecutionState*, std::vector<SeedInfo> >::iterator it =
						seedMap.upper_bound(lastState);
				if (it == seedMap.end())
					it = seedMap.begin();
				lastState = it->first;
				unsigned numSeeds = it->second.size();
				ExecutionState &state = *lastState;
				KInstruction *ki = state.pc;
				stepInstruction(state);

				executeInstruction(state, ki);
				processTimers(&state, MaxInstructionTime * numSeeds);
				updateStates(&state);

				if ((stats::instructions % 1000) == 0) {
					int numSeeds = 0, numStates = 0;
					for (std::map<ExecutionState*, std::vector<SeedInfo> >::iterator
							it = seedMap.begin(), ie = seedMap.end(); it != ie;
							++it) {
						numSeeds += it->second.size();
						numStates++;
					}
					double time = util::getWallTime();
					if (SeedTime > 0. && time > startTime + SeedTime) {
						klee_warning(
								"seed time expired, %d seeds remain over %d states",
								numSeeds, numStates);
						break;
					} else if (numSeeds <= lastNumSeeds - 10
							|| time >= lastTime + 10) {
						lastTime = time;
						lastNumSeeds = numSeeds;
						klee_message("%d seeds remaining over: %d states",
								numSeeds, numStates);
					}
				}
			}

			klee_message("seeding done (%d states remain)",
					(int) states.size());

			// XXX total hack, just because I like non uniform better but want
			// seed results to be equally weighted.
			for (std::set<ExecutionState*>::iterator it = states.begin(), ie =
					states.end(); it != ie; ++it) {
				(*it)->weight = 1.;
			}

			if (OnlySeed)
				goto dump;
		}

		searcher = constructUserSearcher(*this);

		searcher->update(0, states, std::set<ExecutionState*>());

		GlobalWCET = -1;
		std::clock_t p_start;
		p_start = std::clock();
		while (!states.empty() && !haltExecution) {
			NoInterpolation = true;
			ExecutionState &state = searcher->selectState();

			if (INTERPOLATION_ENABLED) {
				// We synchronize the node id to that of the state. The node id
				// is set only when it was the address of the first instruction
				// in the node.
				interpTree->setCurrentINode(state);

				// Uncomment the following statements to show the state
				// of the interpolation tree and the active node.

				//      llvm::errs() << "\nCurrent state:\n";
				//      processTree->dump();
				//      interpTree->dump();
				//      state.itreeNode->dump();
				//      llvm::errs() << "------------------- Executing New Instruction "
				//                      "-----------------------\n";
				//      state.pc->inst->dump();
			}

			if (INTERPOLATION_ENABLED
					&& interpTree->subsumptionCheck(solver, state,
							coreSolverTimeout)) {
				terminateStateOnSubsumption(state);
			} else {
				KInstruction *ki = state.pc;
				stepInstruction(state);
				HSETInfo.TotalNumberOfInstruction++;
				executeInstruction(state, ki);
				processTimers(&state, MaxInstructionTime);
				checkMemoryUsage();
				updateStates(&state);
			}
		}

		llvm::errs() << "WCET:" << GlobalWCET << "\n";
		llvm::errs() << "Total execution time:" << std::clock() - p_start<< "\n";

		delete searcher;
		searcher = 0;

		dump: if (DumpStatesOnHalt && !states.empty()) {
			llvm::errs()
					<< "KLEE: halting execution, dumping remaining states\n";
			for (std::set<ExecutionState*>::iterator it = states.begin(), ie =
					states.end(); it != ie; ++it) {
				ExecutionState &state = **it;
				stepInstruction(state); // keep stats rolling
				terminateStateEarly(state, "Execution halting.");
			}
			updateStates(0);
		}

	} else {

		int countRun = 0;
		float endRate = 1;
		int maxLoop = 99999;


		std::clock_t c_start;
		std::clock_t p_start;

		//TN: Temporary turn off Interpolation
		NoInterpolation = true;

		//TN: Start first abstract run
		++countRun;
		if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Start run " << countRun << "\n";

		HSETInfo.currentWCET = runWithAbstract(initialState, AbstractMethods, false);
		if(HSETInfo.IsTurnOnNotification) {
			llvm::errs() << "End run " << countRun << " , current Upper WCET:" << HSETInfo.currentWCET.WCET << "\n";
			llvm::errs() << "End run " << countRun << " , current Lower WCET:" << HSETInfo.CurrentLowerBound << "\n\n";
		}

		p_start = std::clock();
		llvm::errs() << "UWCET" << " " << "LWCET" << " " << "INode" << " " << "LNode"<< " " << "TNode" << "Time" << "\n";

		while (countRun < maxLoop && (endRate > 0.05 || endRate < 0.05) && !HSETInfo.currentWCET.isConcrete()) {
			++countRun;

			c_start = std::clock();
			if(HSETInfo.IsTurnOnNotification){
				llvm::errs() << "Start run " << countRun << "\n";
				llvm::errs() << "Run with guide. Chosen path will be (WCET = " << HSETInfo.currentWCET.WCET << "): ";
				llvm::errs() << HSETInfo.currentWCET.Path;
				llvm::errs() << "\n";
			}

			HSETInfo.currentWCET = runWithExecutionTree(processTree->root, HSETInfo.currentWCET.Path, 0, AbstractMethods);

			if (HSETInfo.currentWCET.LWCET > HSETInfo.CurrentLowerBound) HSETInfo.CurrentLowerBound = HSETInfo.currentWCET.LWCET;

			endRate = ((float) HSETInfo.currentWCET.WCET - (float) HSETInfo.CurrentLowerBound) / (float) HSETInfo.CurrentLowerBound;

			if(HSETInfo.IsTurnOnNotification){
				llvm::errs() << "End run " << countRun << " , current Upper WCET:" << HSETInfo.currentWCET.WCET << "\n";
				llvm::errs() << "End run " << countRun << " , current Lower WCET:" << HSETInfo.CurrentLowerBound << "\n";
				llvm::errs() << "End run " << countRun << " , number abstract node:" << HSETInfo.rawAbstractDictionary.size() << "\n";
				llvm::errs() << "End run " << countRun << " , number exact node:"<< HSETInfo.NumberExactInternalNode + HSETInfo.NumberExactLeafNode
						<<":"<< HSETInfo.NumberExactInternalNode <<":"<< HSETInfo.NumberExactLeafNode << "\n\n";
				//llvm::outs()<< "End run " << countRun << " , number path node:"<< HSETInfo.exactPathDictionary.size() << "\n";
				//llvm::outs() << "End run " << countRun << " , current execution time:" << std::clock() - c_start << "\n";
			}
			//llvm::errs() << HSETInfo.currentWCET.WCET << " " << HSETInfo.CurrentLowerBound << " " << HSETInfo.NumberExactInternalNode
			//		                            	  << " " << HSETInfo.NumberExactLeafNode  << " " << HSETInfo.exactPathDictionary.size() << " " << std::clock() - c_start << "\n";
		}

		if (HSETInfo.currentWCET.isConcrete()) {
			llvm::errs() << "Find concrete path!" << "\n";
			llvm::errs() << "Chosen path will be (WCET = " << HSETInfo.currentWCET.WCET << "): ";
			llvm::errs() << HSETInfo.currentWCET.Path;
			llvm::errs() << "\n";
		}

		llvm::errs() << "End execution " << countRun << " , number abstract node:" << HSETInfo.rawAbstractDictionary.size() << "\n";
		llvm::errs() << "End execution " << countRun << " , number exact node:"<< HSETInfo.NumberExactInternalNode + HSETInfo.NumberExactLeafNode
								<<":"<< HSETInfo.NumberExactInternalNode <<":"<< HSETInfo.NumberExactLeafNode << "\n";
		llvm::errs() << "Total execution time:" << std::clock() - p_start << "\n";
	}

	llvm::errs() << "Total instructions executed:" << HSETInfo.TotalNumberOfInstruction << "\n\n";

}

/* Begin HSET Methods*/
Executor::HSETSummary Executor::runWithAbstract(ExecutionState &initialState,
		Executor::HSETAbstractMethods abstractMethod, bool BypassingFirstBranch) {
	bool isTerminated = false;
	bool movedForward = false;
	HSETSummary resultHSET;

	std::map<RawAbstractState, HSETSummary>::const_iterator rawMemoriedState;

	ExecutionState state = *(new ExecutionState(initialState));
	while (state.pc) {
		movedForward = false;
		KInstruction *ki = state.pc;

		if(HSETInfo.IsTurnOnNotification){
			llvm::errs() << (*(state.pc)).dest << "--";
			llvm::errs() << *(ki->inst) << "\n";
		}

		rawMemoriedState = HSETInfo.rawAbstractDictionary.find(Executor::abstractRawState(state, abstractMethod));
		if (rawMemoriedState != HSETInfo.rawAbstractDictionary.end()) {
			if(HSETInfo.IsTurnOnNotification){
				llvm::errs() << "Find abstract match, reuse :" << (rawMemoriedState->second).WCET << "\n";
				llvm::errs() << "Position:" << (*state.pc).dest << "\n";
			}
			resultHSET.WCET += (rawMemoriedState->second).WCET;
			resultHSET.Path = (rawMemoriedState->second).Path;
			break;
		}

		Instruction *i = ki->inst;
		//HSETInfo.TotalNumberOfInstruction++;
		if(!(BypassingFirstBranch && i->getOpcode() == Instruction::Br)) resultHSET.WCET += estimateSpecificInstruction(ki->inst);

		switch (i->getOpcode()) {
		case Instruction::Ret: {
			ReturnInst *ri = cast < ReturnInst > (i);
			KInstIterator kcaller = state.stack.back().caller;
			Instruction *caller = kcaller ? kcaller->inst : 0;
			bool isVoidReturn = (ri->getNumOperands() == 0);
			if (state.stack.size() <= 1) {
				isTerminated = true;
			} else {
				ref<Expr> tempExpr = ConstantExpr::alloc(0, Expr::Bool);
				state.popFrame(ki, tempExpr);
				if (InvokeInst *ii = dyn_cast < InvokeInst > (caller)) {
					transferToBasicBlock(ii->getNormalDest(),
							caller->getParent(), state);
				} else {
					state.pc = kcaller;
					++state.pc;
				}

				if (!isVoidReturn) {
				} else {
					if (!caller->use_empty()) {
						isTerminated = true;
					}
				}
			}
			break;
		}

#if LLVM_VERSION_CODE < LLVM_VERSION(3, 1)
			case Instruction::Unwind: {
				for (;;) {
					KInstruction *kcaller = state.stack.back().caller;
					state.popFrame(ki, ConstantExpr::alloc(0, Expr::Bool));
					if (state.stack.empty()) {
						isTerminated = true;
						break;
					} else {
						Instruction *caller = kcaller->programPoint;
						if (InvokeInst *ii = dyn_cast < InvokeInst > (caller)) {
							transferToBasicBlock(ii->getUnwindDest(),
									caller->getParent(), state);
							//movedForward = true;
							break;
						}
					}
				}
				break;
			}
#endif

		case Instruction::Br: {
			BranchInst *bi = cast < BranchInst > (i);
			if (bi->isUnconditional()) {
				transferToBasicBlock(bi->getSuccessor(0), bi->getParent(),
						state);
				movedForward = true;
			} else {
				ExecutionState *falseState, *trueState;
				falseState = new ExecutionState(state);
				trueState = new ExecutionState(state);
				transferToBasicBlock(bi->getSuccessor(0), bi->getParent(),
						*trueState);
				transferToBasicBlock(bi->getSuccessor(1), bi->getParent(),
						*falseState);

				if(HSETInfo.IsTurnOnNotification){
					llvm::errs() << "Meet branch instruction, current WCET is "	<< resultHSET.WCET << "\n";
					llvm::errs() << "Follow true branch with abstract: \n";
				}

				HSETSummary trueHSET = runWithAbstract(*trueState,
						abstractMethod, false);

				if(HSETInfo.IsTurnOnNotification){
					llvm::errs() << resultHSET.WCET << " --- True WCET is "	<< trueHSET.WCET << "\n";
					llvm::errs() << "Follow false branch with abstract: \n";
				}

				HSETSummary falseHSET = runWithAbstract(*falseState,
						abstractMethod, false);

				if(HSETInfo.IsTurnOnNotification){
					llvm::errs() << resultHSET.WCET << " --- False WCET is " << falseHSET.WCET << "\n";
				}

				if (trueHSET.WCET > falseHSET.WCET) {
					resultHSET.updateNextNode("1");
					resultHSET.concat(trueHSET);
				} else {
					resultHSET.updateNextNode("0");
					resultHSET.concat(falseHSET);
				}
				isTerminated = true;
			}
			break;
		}
		case Instruction::Switch: {
			SwitchInst *si = cast < SwitchInst > (i);

			BasicBlock *bb = si->getParent();
			std::map<BasicBlock*, ref<Expr> > targets;
			std::map<BasicBlock*, unsigned > targetsPosition;


			//TN: Cases
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 1)
			for (SwitchInst::CaseIt i = si->case_begin(), e = si->case_end();i != e; ++i) {
#else
			for (unsigned i=1, cases = si->getNumCases(); i<cases; ++i) {
#endif
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 1)
				BasicBlock *caseSuccessor = i.getCaseSuccessor();
				targetsPosition.insert(std::make_pair(caseSuccessor, i.getSuccessorIndex()));
#else
				BasicBlock *caseSuccessor = si->getSuccessor(i);
				targetsPosition.insert(std::make_pair(caseSuccessor, i));
#endif
				targets.insert(std::make_pair(caseSuccessor, ConstantExpr::alloc(0, Expr::Bool)));

			}

			ref<Expr> isDefault = ConstantExpr::alloc(1, Expr::Bool);
			targets.insert(std::make_pair(si->getDefaultDest(), isDefault));
			targetsPosition.insert(std::make_pair(si->getDefaultDest(), 0));

			HSETSummary maxHSET;
			HSETSummary tempHSET;
			int count = 0;

			std::string maxPosition = "";
			std::string pathLog;
			std::map<BasicBlock*, unsigned>::iterator indexInfo;


			for (std::map<BasicBlock*, ref<Expr> >::iterator it = targets.begin(), ie = targets.end(); it != ie; ++it) {
				ExecutionState *es = new ExecutionState(state);
				transferToBasicBlock(it->first, bb, *es);
				tempHSET = runWithAbstract(*es, abstractMethod,false);
				if (tempHSET.WCET > maxHSET.WCET) {
					maxHSET = tempHSET.clone(0);

					indexInfo = targetsPosition.find(it->first);
					pathLog = "";
					for(unsigned i = 0 ; i< indexInfo->second; i++) pathLog +='0';
					pathLog +='1';

					maxPosition = pathLog;
				}

				++count;
			}

			resultHSET.updateNextNode(maxPosition);
			resultHSET.concat(maxHSET);
			isTerminated = true;

			break;
		}
		case Instruction::Unreachable: {
			isTerminated = true;
			break;
		}
		case Instruction::Invoke:
		case Instruction::Call: {
			CallSite cs(i);

			Value *fp = cs.getCalledValue();
			Function *f = getTargetFunction(fp, state);

			// Skip debug intrinsics, we can't evaluate their metadata arguments.
			if (f && isDebugIntrinsic(f, kmodule))
				break;

			if (isa < InlineAsm > (fp)) {
				isTerminated = true;
				break;
			}

			if (f) {
				if (f && f->isDeclaration()) {
					if (InvokeInst *ii = dyn_cast < InvokeInst > (i))
						transferToBasicBlock(ii->getNormalDest(),
								i->getParent(), state);
				} else {
					KFunction *kf = kmodule->functionMap[f];
					state.pushFrame(state.prevPC, kf);
					state.pc = kf->instructions;
				}

				movedForward = true;
				switch (f->getIntrinsicID()) {
				case Intrinsic::not_intrinsic:
					movedForward = false;
					break;
				default:
					break;
				}
				//movedForward = true;
			} else {
				// To Do
				// Can not map with current do while loop code base on result from solver
			}
			break;
		}
		case Instruction::ExtractElement:
		case Instruction::InsertElement:
		case Instruction::ShuffleVector:
		case Instruction::VAArg: {
			isTerminated = true;
			break;
		}
		default: {
			break;
		}
		}

		if (isTerminated) {
			break;
		} else {
			if (!movedForward) {
				state.prevPC = state.pc;
				++state.pc;
			}
		}
	}

	std::map<RawAbstractState, HSETSummary>::iterator tmpGeneralInfo;
	tmpGeneralInfo = HSETInfo.rawAbstractDictionary.find(Executor::abstractRawState(initialState, abstractMethod));
	if (tmpGeneralInfo == HSETInfo.rawAbstractDictionary.end()) {
		std::pair<RawAbstractState, HSETSummary> curGeneralInfo(Executor::abstractRawState(initialState, abstractMethod),resultHSET);
		HSETInfo.rawAbstractDictionary.insert(curGeneralInfo);

		if(HSETInfo.IsTurnOnNotification){
			llvm::errs() << "Abstract saving: " << resultHSET.WCET << "\n";
			llvm::errs() << "For position:" << (*(initialState.pc)).dest << "\n";
		}

	}

	return resultHSET;
}

std::string Executor::ExtractPath(std::string p, int depth, char lastMember){
	if(depth < 0) return "";
	else{
		std::stringstream ss;
		if (depth > 0) ss << p.substr(0,depth);
		ss << lastMember;
		//llvm::errs() << "Extract Path:" << p << " " << depth <<" "<< lastMember << "\n";
		//llvm::errs() << "Output:"<<ss.str()<< "\n";
		return ss.str();
	}
}

std::string Executor::ExtractPath(std::string p, int maxNode){
	std::stringstream ss;

	std::string result = "";
	for(int i = 0; i< maxNode; i++)
		if(p[i] == 1) ss << "1";
		else if (p[i] == 0) ss << "0";
		else break;
	return ss.str();
}

std::string Executor::ExtractNodeSummary(std::string p){
	PTreeNode *runningNode = ExtractNode(p);
	if(runningNode == 0) return "";
	else return runningNode->ExecutionSummary;
}

PTreeNode* Executor::ExtractNode(std::string p){
	PTreeNode *runningNode = processTree->root;
	for(unsigned i = 0; i < p.size() ; i++){
		if(p[i] == '1')
			if(runningNode->right) runningNode = runningNode->right;
			else {
				runningNode = 0;
				break;
			}
		else if(p[i] == '0'){
			if(runningNode->left) runningNode = runningNode->left;
			else {
				runningNode = 0;
				break;
			}
		}
	}
	return runningNode;
}

Executor::HSETSummary Executor::runWithExecutionTree(PTreeNode *runningNode,std::string guilde, int depth,Executor::HSETAbstractMethods abstractMethod) {
	HSETSummary resultHSET;
	bool isLeafNode = true;
	resultHSET.Concrete = true;
	resultHSET.WCET = resultHSET.LWCET = runningNode->executionTime;
	std::map<std::string, std::string, comparer>::iterator tmpExactCachedState;

	if (runningNode->left || runningNode->right) {
		isLeafNode = false;

		if(HSETInfo.IsTurnOnNotification){
			llvm::errs() << "Meet branch instruction, current WCET is "
				<< resultHSET.WCET << "\n";
		}

		HSETSummary trueHSET, falseHSET;
		if ((unsigned)depth >= guilde.length() || guilde[depth] == '1') {
			if (runningNode->right) {
				if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Follow true branch with symbolic: \n";
				if (runningNode->right->data) {
					if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Start real symbolic\n";
					trueHSET = runWithSymbolicExecution(*(runningNode->right->data), guilde, depth + 1,	abstractMethod, false);
				} else {
					trueHSET = runWithExecutionTree(runningNode->right, guilde,	depth + 1, abstractMethod);
				}
				resultHSET.LWCET += trueHSET.LWCET;
				if(HSETInfo.IsTurnOnNotification) llvm::errs() << resultHSET.WCET << " --- True WCET is "	<< trueHSET.WCET << "\n";
			} else {
				if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Infeasible true branch \n";
				trueHSET.WCET = -99999;
			}
			if (runningNode->left) {

				//tmpExactCachedState = HSETInfo.exactPathDictionary.find(ExtractPath(guilde, depth, '0'));
				//if (tmpExactCachedState != HSETInfo.exactPathDictionary.end()) {
				std::string nodeSummary = ExtractNodeSummary(ExtractPath(guilde, depth, '0'));
				if (nodeSummary != "") {
					if(HSETInfo.IsTurnOnNotification){
						//llvm::errs() << "Find explored path, reuse :"<< (tmpExactCachedState->second)[0] << "\n";
						llvm::errs() << "Path:";
						for (int i = 0; i < depth; i++)	llvm::errs() << guilde[i];
						llvm::errs() << "0\n";
					}
					//falseHSET = *(new HSETSummary(tmpExactCachedState->second));
					falseHSET = *(new HSETSummary(nodeSummary));
				} else {
					if (runningNode->left->data) {
						if(interpreterOpts.ExeConfig == Interpreter::HybridAbstractExecution){
							if(HSETInfo.IsTurnOnNotification) llvm::errs()<<"Temporary Symbolic Tree";
							char tempGuilde = guilde[depth];
							guilde[depth] = '0';
							falseHSET = runWithSymbolicExecution(*(runningNode->left->data), guilde, depth + 1,
								abstractMethod, true);
							guilde[depth] = tempGuilde;

						} else if(interpreterOpts.ExeConfig == Interpreter::HybridSymbolicExecution)
							falseHSET = runWithAbstract(*(runningNode->left->data),abstractMethod,false);
					} else {
						if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Infeasible false branch.1 \n";
						falseHSET.WCET = -99999;
					}
				}
				if(HSETInfo.IsTurnOnNotification) llvm::errs() << resultHSET.WCET << " --- False WCET is "
						<< falseHSET.WCET << "\n";
			}
		} else {
			if (runningNode->left) {
				if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Follow false branch with symbolic: \n";
				if (runningNode->left->data) {
					if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Start real symbolic\n";
					falseHSET = runWithSymbolicExecution(*(runningNode->left->data), guilde, depth + 1,abstractMethod, false);
				} else {
					falseHSET = runWithExecutionTree(runningNode->left, guilde,	depth + 1, abstractMethod);
				}
				resultHSET.LWCET += falseHSET.LWCET;
				if(HSETInfo.IsTurnOnNotification) llvm::errs() << resultHSET.WCET << " --- False WCET is "
						<< falseHSET.WCET << "\n";
			} else {
				if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Infeasible false branch.3 \n";
				falseHSET.WCET = -99999;
			}

			if (runningNode->right) {
				//tmpExactCachedState = HSETInfo.exactPathDictionary.find(ExtractPath(guilde, depth, '1'));
				//if (tmpExactCachedState != HSETInfo.exactPathDictionary.end()) {
				std::string nodeSummary = ExtractNodeSummary(ExtractPath(guilde, depth, '1'));
				if (nodeSummary != "") {
					if(HSETInfo.IsTurnOnNotification){
						//llvm::errs() << "Find explored path, reuse :"<< (tmpExactCachedState->second)[0] << "\n";
						llvm::errs() << "Path:";
						for (int i = 0; i < depth; i++)
							llvm::errs() << guilde[i];
						llvm::errs() << "1\n";
					}
					//trueHSET = *(new HSETSummary(tmpExactCachedState->second));
					trueHSET = *(new HSETSummary(nodeSummary));
				} else {
					if (runningNode->right->data) {
						if(interpreterOpts.ExeConfig == Interpreter::HybridAbstractExecution){
							if(HSETInfo.IsTurnOnNotification) llvm::errs()<<"Temporary Symbolic Tree";
							char tempGuilde = guilde[depth];
							guilde[depth] = '1';
							trueHSET = runWithSymbolicExecution(*(runningNode->right->data), guilde, depth + 1,
								abstractMethod, true);
							guilde[depth] = tempGuilde;
						} else if(interpreterOpts.ExeConfig == Interpreter::HybridSymbolicExecution)
							trueHSET = runWithAbstract(*(runningNode->right->data),abstractMethod,false);
					} else {
						if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Infeasible true branch.1 \n";
						trueHSET.WCET = -99999;
					}
				}
				if(HSETInfo.IsTurnOnNotification) llvm::errs() << resultHSET.WCET << " --- True WCET is " << trueHSET.WCET << "\n";
			}
		}
		if (trueHSET.WCET > falseHSET.WCET) {
			resultHSET.updateNextNode("1");
			resultHSET.concat(trueHSET);
		} else if (trueHSET.WCET == falseHSET.WCET) {
			if (trueHSET.isConcrete()) {
				resultHSET.updateNextNode("1");
				resultHSET.concat(trueHSET);
			} else {
				resultHSET.updateNextNode("0");
				resultHSET.concat(falseHSET);
			}
		} else {
			resultHSET.updateNextNode("0");
			resultHSET.concat(falseHSET);
		}
	} else {
		if (runningNode->data) {
			if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Start real symbolic\n";
			resultHSET = runWithSymbolicExecution(*(runningNode->data), guilde,
					depth, abstractMethod, false);
		} else
			resultHSET.WCET = -99999;
	}

	PTreeNode* workingNode = ExtractNode(ExtractPath(guilde, depth - 1 , guilde[depth - 1]));
	std::stringstream iss;
	iss << resultHSET.WCET << " " << resultHSET.LWCET << " " << resultHSET.isConcrete() << " " << resultHSET.Path;

	if (workingNode != 0) {
		std::stringstream iss2(workingNode->ExecutionSummary);
		std::string temp;
		iss2 >> temp; iss2 >> temp; iss2 >> temp;
		if((temp == "1") && resultHSET.isConcrete()){
			if(isLeafNode){
				--HSETInfo.NumberExactLeafNode;
			} else {
				--HSETInfo.NumberExactInternalNode;
			}
		}
		workingNode->ExecutionSummary = "";
	}

	if(HSETInfo.IsTurnOnNotification){
		llvm::errs() << "Saving Path:";
		for (int i = 0; i < depth; i++)
			llvm::errs() << guilde[i];
		llvm::errs() << " " << resultHSET.WCET;
		llvm::errs() << "\n";
	}

	//HSETInfo.exactPathDictionary.insert(curExactInfo);
	workingNode->ExecutionSummary = iss.str();

	if(resultHSET.isConcrete()){
		if(isLeafNode){
			++HSETInfo.NumberExactLeafNode;
		} else {
			++HSETInfo.NumberExactInternalNode;
		}
	}
	return resultHSET;
}



Executor::HSETSummary Executor::runWithSymbolicExecution(ExecutionState &state,
		std::string guilde, int depth,
		Executor::HSETAbstractMethods abstractMethod, bool IsAbstractWalk) {
	bool isTerminated = false;
	bool movedForward = false;
	bool isLeafNode = true;
	HSETSummary resultHSET;
	resultHSET.Concrete = true;

	std::map<std::string, std::string, comparer>::iterator tmpExactCachedState;
	while (state.pc) {
		KInstruction *ki = state.pc;
		Instruction *i = ki->inst;
		movedForward = false;
		HSETInfo.TotalNumberOfInstruction++;
		resultHSET.WCET += estimateSpecificInstruction(ki->inst);
		state.ptreeNode->executionTime = resultHSET.LWCET = resultHSET.WCET;
		if(HSETInfo.IsTurnOnNotification) llvm::errs() << *i << "\n";

		switch (i->getOpcode()) {
		// Control flow
		case Instruction::Ret: {
			ReturnInst *ri = cast < ReturnInst > (i);
			KInstIterator kcaller = state.stack.back().caller;
			Instruction *caller = kcaller ? kcaller->inst : 0;
			bool isVoidReturn = (ri->getNumOperands() == 0);
			ref<Expr> tempExpr = ConstantExpr::alloc(0, Expr::Bool);
			TaintSet taint = 0;

			if (!isVoidReturn) {
				Cell cell = eval(ki, 0, state);
				tempExpr = cell.value;
				taint = cell.taint;
			}

			if (state.stack.size() <= 1) {
				isTerminated = true;
			} else {
				ref<Expr> result = ConstantExpr::alloc(0, Expr::Bool);
				state.popFrame(ki, result);

				if (statsTracker)
					statsTracker->framePopped(state);

				if (InvokeInst *ii = dyn_cast < InvokeInst > (caller)) {
					transferToBasicBlock(ii->getNormalDest(),
							caller->getParent(), state);
				} else {
					state.pc = kcaller;
					++state.pc;
				}
				//movedForward = true;
				if (!isVoidReturn) {
					LLVM_TYPE_Q Type *t = caller->getType();
					if (t != Type::getVoidTy(getGlobalContext())) {
						// may need to do coercion due to bitcasts
						Expr::Width from = result->getWidth();
						Expr::Width to = getWidthForLLVMType(t);

						if (from != to) {
							CallSite cs =
									(isa < InvokeInst > (caller) ?
											CallSite(
													cast < InvokeInst
															> (caller)) :
											CallSite(cast < CallInst > (caller)));

							// XXX need to check other param attrs ?
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
							bool isSExt = cs.paramHasAttr(0,
									llvm::Attribute::SExt);
#elif LLVM_VERSION_CODE >= LLVM_VERSION(3, 2)
							bool isSExt = cs.paramHasAttr(0, llvm::Attributes::SExt);
#else
							bool isSExt = cs.paramHasAttr(0, llvm::Attribute::SExt);
#endif
							if (isSExt) {
								result = SExtExpr::create(result, to);
							} else {
								result = ZExtExpr::create(result, to);
							}
						}

						bindLocal(kcaller, state, result, taint);
					}
				} else {
					// We check that the return value has no users instead of
					// checking the type, since C defaults to returning int for
					// undeclared functions.
					if (!caller->use_empty()) {
						isTerminated = true;
					}
				}
			}
			break;
		}
#if LLVM_VERSION_CODE < LLVM_VERSION(3, 1)
			case Instruction::Unwind: {
				for (;;) {
					KInstruction *kcaller = state.stack.back().caller;
					state.popFrame(ki, ConstantExpr::alloc(0, Expr::Bool));

					if (statsTracker)
					statsTracker->framePopped(state);

					if (state.stack.empty()) {
						isTerminated = true;
						break;
					} else {
						Instruction *caller = kcaller->programPoint;
						if (InvokeInst *ii = dyn_cast<InvokeInst>(caller)) {
							transferToBasicBlock(ii->getUnwindDest(), caller->getParent(), state);
							//movedForward = true;
							break;
						}
					}
				}
				if (INTERPOLATION_ENABLED)
				interpTree->execute(i);
				break;
			}
#endif
		case Instruction::Br: {
			BranchInst *bi = cast < BranchInst > (i);
			if (bi->isUnconditional()) {
				transferToBasicBlock(bi->getSuccessor(0), bi->getParent(),
						state);
				movedForward = true;

				if (INTERPOLATION_ENABLED)
					interpTree->execute(i);
			} else {
				// FIXME: Find a way that we don't have this hidden dependency.
				assert(
						bi->getCondition() == bi->getOperand(0)
								&& "Wrong operand index!");

				//TanNguyen: Temporary lock
				/*if (interpreterOpts.TaintConfig.has(TaintConfig::ControlFlow)) {
				 if (eval(ki, 0, state).taint != 0) {
				 llvm::errs() << "Tainted condition PC retainted \n";

				 if (state.currentTaintCount
				 == (state.maxCurrentTaint - 5)) {
				 int sizeOfNew = state.maxCurrentTaint + 100;
				 int* pathTaintNew = new int[sizeOfNew];
				 for (int i = 0; i <= state.currentTaintCount; i++) {
				 pathTaintNew[i] = state.stateTrackingTaint[i];
				 }
				 state.stateTrackingTaint = pathTaintNew;
				 state.maxCurrentTaint = sizeOfNew;
				 }
				 state.stateTrackingTaint[state.currentTaintCount] =
				 TaintInitializer++;
				 ++state.currentTaintCount;
				 }
				 state.setPCTaint(state.getPCTaint() | eval(ki, 0, state).taint);
				 }*/
				ref<Expr> cond = eval(ki, 0, state).value;
				Executor::StatePair branches = fork(state, cond, false);

				// NOTE: There is a hidden dependency here, markBranchVisited
				// requires that we still be in the context of the branch
				// instruction (it reuses its statistic id). Should be cleaned
				// up with convenient instruction specific data.
				if (statsTracker && state.stack.back().kf->trackCoverage)
					statsTracker->markBranchVisited(branches.first,
							branches.second);

				if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Meet branch instruction, current WCET is "
						<< resultHSET.WCET << "\n";

				if(branches.first || branches.second) isLeafNode = false;

				if(IsAbstractWalk){

					if(branches.first && branches.second){
						HSETSummary trueHSET, falseHSET;

						if(HSETInfo.IsTurnOnNotification) llvm::errs()<<"Start real abstract";
						transferToBasicBlock(bi->getSuccessor(0), bi->getParent(),*branches.first);
						trueHSET = runWithAbstract(*branches.first,abstractMethod, false);

						transferToBasicBlock(bi->getSuccessor(1), bi->getParent(),*branches.second);
						falseHSET = runWithAbstract(*branches.second,abstractMethod, false);

						if (trueHSET.WCET > falseHSET.WCET) {
							resultHSET.updateNextNode("1");
							resultHSET.concat(trueHSET);
						} else if (trueHSET.WCET == falseHSET.WCET) {
							if (trueHSET.isConcrete()) {
								resultHSET.updateNextNode("1");
								resultHSET.concat(trueHSET);
							} else {
								resultHSET.updateNextNode("0");
								resultHSET.concat(falseHSET);
							}
						} else {
							resultHSET.updateNextNode("0");
							resultHSET.concat(falseHSET);
						}
					}
					else if (branches.first){
						HSETSummary tempHSET;
						transferToBasicBlock(bi->getSuccessor(0), bi->getParent(),
														*branches.first);
						char tempG = guilde[depth];
						guilde[depth] = '1';
						tempHSET = runWithSymbolicExecution(*branches.first,
								guilde, depth + 1, abstractMethod, true);
						guilde[depth] = tempG;
						resultHSET.updateNextNode("1");
						resultHSET.concat(tempHSET);
					}
					else if (branches.second) {
						HSETSummary tempHSET;
						transferToBasicBlock(bi->getSuccessor(1), bi->getParent(),
														*branches.second);
						char tempG = guilde[depth];
						guilde[depth] = '0';
						tempHSET = runWithSymbolicExecution(*branches.second,
								guilde, depth + 1, abstractMethod, true);
						guilde[depth] = tempG;
						resultHSET.updateNextNode("0");
						resultHSET.concat(tempHSET);
					}
				}
				else {
					HSETSummary trueHSET, falseHSET;
					if (branches.first) {
						assert(
								branches.first->taint == state.taint
										&& "Taint should be propagated to forking states!");
						transferToBasicBlock(bi->getSuccessor(0), bi->getParent(),
								*branches.first);

						if ((unsigned)depth >= guilde.length() || guilde[depth] == '1') {
							if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Follow true branch with symbolic: \n";
							trueHSET = runWithSymbolicExecution(*branches.first,
									guilde, depth + 1, abstractMethod, false);

							resultHSET.LWCET += trueHSET.LWCET;
						} else {
							if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Follow true branch with abstract: \n";

							//tmpExactCachedState = HSETInfo.exactPathDictionary.find(ExtractPath(guilde,depth,'1'));
							//if (tmpExactCachedState	!= HSETInfo.exactPathDictionary.end()) {
							std::string nodeSummary = ExtractNodeSummary(ExtractPath(guilde, depth, '1'));
							if (nodeSummary != "") {
								if(HSETInfo.IsTurnOnNotification){
									//llvm::errs() << "Find explored path, reuse :"
									//	<< (tmpExactCachedState->second)[0]
									//	<< "\n";
									llvm::errs() << "Path:";
									for (int i = 0; i < depth; i++)
										llvm::errs() << guilde[i];
									llvm::errs() << "1\n";
								}
								//trueHSET = *(new HSETSummary(tmpExactCachedState->second));
								trueHSET = *(new HSETSummary(nodeSummary));
							} else{
								if(interpreterOpts.ExeConfig == Interpreter::HybridAbstractExecution){
									if(HSETInfo.IsTurnOnNotification) llvm::errs()<<"Temporary Symbolic Tree";
									char tempG = guilde[depth];
									guilde[depth] = '1';
									trueHSET = runWithSymbolicExecution(*branches.first, guilde, depth + 1,
										abstractMethod, true);
									guilde[depth] = tempG;
								} else if(interpreterOpts.ExeConfig == Interpreter::HybridSymbolicExecution)
									trueHSET = runWithAbstract(*branches.first, abstractMethod, false);
							}
						}
						if(HSETInfo.IsTurnOnNotification) llvm::errs() << resultHSET.WCET << " --- True WCET is "
								<< trueHSET.WCET << "\n";
					} else {
						if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Infeasible true branch. \n";
						trueHSET.WCET = -99999;
					}
					if (branches.second) {
						assert(
								branches.second->taint == state.taint
										&& "Taint should be propagated to forking states!");
						transferToBasicBlock(bi->getSuccessor(1), bi->getParent(),
								*branches.second);

						if (guilde[depth] == '1') {
							if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Follow false branch with abstract: \n";

							//tmpExactCachedState = HSETInfo.exactPathDictionary.find(ExtractPath(guilde,depth,'0'));
							//if (tmpExactCachedState	!= HSETInfo.exactPathDictionary.end()) {
							std::string nodeSummary = ExtractNodeSummary(ExtractPath(guilde, depth, '0'));
							if (nodeSummary != "") {
								if(HSETInfo.IsTurnOnNotification){
									//llvm::errs() << "Find explored path, reuse :"
									//	<< (tmpExactCachedState->second)[0]
									//	<< "\n";
									llvm::errs() << "Path:";
									for (int i = 0; i < depth; i++)
										llvm::errs() << guilde[i];
									llvm::errs() << "0\n";
								}
								//falseHSET = *(new HSETSummary(tmpExactCachedState->second));
								falseHSET = *(new HSETSummary(nodeSummary));
							} else{
								if(interpreterOpts.ExeConfig == Interpreter::HybridAbstractExecution){
									if(HSETInfo.IsTurnOnNotification) llvm::errs()<<"Temporary Symbolic Tree";
									char tempG = guilde[depth];
									guilde[depth] = '0';
									falseHSET = runWithSymbolicExecution(*branches.second, guilde, depth + 1,
										abstractMethod, true);
									guilde[depth] = tempG;
								} else if(interpreterOpts.ExeConfig == Interpreter::HybridSymbolicExecution)
									falseHSET = runWithAbstract(*branches.second,abstractMethod,false);
							}
						} else {
							if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Follow false branch with symbolic: \n";
							falseHSET = runWithSymbolicExecution(*branches.second,
									guilde, depth + 1, abstractMethod, false);

							resultHSET.LWCET += falseHSET.LWCET;
						}
						if(HSETInfo.IsTurnOnNotification) llvm::errs() << resultHSET.WCET << " --- False WCET is "
								<< falseHSET.WCET << "\n";
					} else {
						if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Infeasible false branch. \n";
						falseHSET.WCET = -99999;
					}

					if (trueHSET.WCET > falseHSET.WCET) {
						resultHSET.updateNextNode("1");
						resultHSET.concat(trueHSET);
					} else if (trueHSET.WCET == falseHSET.WCET) {
						if (trueHSET.isConcrete()) {
							resultHSET.updateNextNode("1");
							resultHSET.concat(trueHSET);
						} else {
							resultHSET.updateNextNode("0");
							resultHSET.concat(falseHSET);
						}
					} else {
						resultHSET.updateNextNode("0");
						resultHSET.concat(falseHSET);
					}
				}
				isTerminated = true;

				// Below we test if some of the branches are not available for
				// exploration, which means that there is a dependency of the program
				// state on the control variables in the conditional. Such variables
				// (allocations) need to be marked as belonging to the core.
				// This is mainly to take care of the case when the conditional
				// variables are not marked using unsatisfiability core as the
				// conditional is concrete and therefore there has been no invocation
				// of the solver to decide its satisfiability, and no generation
				// of the unsatisfiability core.
				if (INTERPOLATION_ENABLED
						&& ((!branches.first && branches.second)
								|| (branches.first && !branches.second)))
					interpTree->execute(i);
			}
			break;
		}
		case Instruction::Switch: {
			SwitchInst *si = cast < SwitchInst > (i);
			ref<Expr> cond = eval(ki, 0, state).value;
			BasicBlock *bb = si->getParent();
			isLeafNode = false;
			//TanNguyen: Temporary lock
			/*if (interpreterOpts.TaintConfig.has(TaintConfig::ControlFlow)) {
			 if (eval(ki, 0, state).taint != 0) {
			 klee_warning(
			 "Tainted condition PC retainted from 0x%08x to 0x%08x",
			 eval(ki, 0, state).taint,
			 state.getPCTaint() | eval(ki, 0, state).taint);
			 if (state.currentTaintCount == (state.maxCurrentTaint - 5)) {
			 int sizeOfNew = state.maxCurrentTaint + 100;
			 int* pathTaintNew = new int[sizeOfNew];
			 for (int i = 0; i <= state.currentTaintCount; i++) {
			 pathTaintNew[i] = state.stateTrackingTaint[i];
			 }
			 state.stateTrackingTaint = pathTaintNew;
			 state.maxCurrentTaint = sizeOfNew;
			 }
			 state.stateTrackingTaint[state.currentTaintCount] =
			 TaintInitializer++;
			 ++state.currentTaintCount;
			 }
			 state.setPCTaint(state.getPCTaint() | eval(ki, 0, state).taint);
			 }*/

			cond = toUnique(state, cond);
			if (ConstantExpr *CE = dyn_cast < ConstantExpr > (cond)) {

				// Somewhat gross to create these all the time, but fine till we
				// switch to an internal rep.
				LLVM_TYPE_Q llvm::IntegerType *Ty = cast < IntegerType
						> (si->getCondition()->getType());
				ConstantInt *ci = ConstantInt::get(Ty, CE->getZExtValue());
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 1)
				unsigned index = si->findCaseValue(ci).getSuccessorIndex();
#else
				unsigned index = si->findCaseValue(ci);
#endif

				transferToBasicBlock(si->getSuccessor(index), si->getParent(),
										state);

				//Todo fix this point TN
				HSETSummary tempHSET;
				std::string chosenPath = "";
				bool isFollowingPath = true;

				for(unsigned i = 0 ; i< index; i++) chosenPath +='0';
				chosenPath +='1';

				if(depth + index < guilde.length())
					for(unsigned i = 0 ; i<= index; i++){
						if(guilde[depth + i] != chosenPath[i]){
							isFollowingPath = false;
							break;
						}
					}
				else isFollowingPath = false;

				movedForward = true;
				int cuttingPoint = 0;
				for(unsigned j = depth; j < guilde.length(); j++) if(guilde[j] == '1') {cuttingPoint = j;break;}
				if (isFollowingPath) {
						guilde = guilde.substr(0,depth) + guilde.substr(cuttingPoint + 1, guilde.length() - cuttingPoint - 1);
					} else {
						guilde = guilde.substr(0,depth);
					}
				resultHSET.Path += chosenPath;
				} else {
				std::map<BasicBlock*, ref<Expr> > targets;
				std::map<BasicBlock*, unsigned > targetsPosition;
				ref<Expr> isDefault = ConstantExpr::alloc(1, Expr::Bool);


#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 1)
				for (SwitchInst::CaseIt i = si->case_begin(), e =
						si->case_end(); i != e; ++i) {
					ref<Expr> value = evalConstant(i.getCaseValue());
#else
					for (unsigned i=1, cases = si->getNumCases(); i<cases; ++i) {
						ref<Expr> value = evalConstant(si->getCaseValue(i));
#endif
					ref<Expr> match = EqExpr::create(cond, value);
					isDefault = AndExpr::create(isDefault,
							Expr::createIsZero(match));
					bool result;
					bool success = solver->mayBeTrue(state, match, result);
					assert(success && "FIXME: Unhandled solver failure");
					(void) success;
					if (result) {
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 1)
						BasicBlock *caseSuccessor = i.getCaseSuccessor();
						targetsPosition.insert(std::make_pair(caseSuccessor, i.getSuccessorIndex()));
#else
						BasicBlock *caseSuccessor = si->getSuccessor(i);
						targetsPosition.insert(std::make_pair(caseSuccessor, i));
#endif
						std::map<BasicBlock*, ref<Expr> >::iterator it =
								targets.insert(
										std::make_pair(caseSuccessor,
												ConstantExpr::alloc(0,
														Expr::Bool))).first;

						it->second = OrExpr::create(match, it->second);
					}
				}
				bool res;
				bool success = solver->mayBeTrue(state, isDefault, res);
				assert(success && "FIXME: Unhandled solver failure");
				(void) success;
				//TN: Always add
				//if (res)
					targets.insert(
							std::make_pair(si->getDefaultDest(), isDefault));
					targetsPosition.insert(std::make_pair(si->getDefaultDest(), 0));

				std::vector<ref<Expr> > conditions;
				for (std::map<BasicBlock*, ref<Expr> >::iterator it =
						targets.begin(), ie = targets.end(); it != ie; ++it)
					conditions.push_back(it->second);
				///////////////////////////////
				std::vector<ExecutionState*> branches;
				branch(state, conditions, branches);

				HSETSummary maxHSET;
				HSETSummary tempHSET;

				bool isFollowingPath = true;
				std::string chosingPath = "";
				std::string maxPath = "";

				isLeafNode = false;
				if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Entering Switch" << "\n";
				unsigned caseIndex;
				//Todo Fix this point
				std::vector<ExecutionState*>::iterator bit = branches.begin();
				for (std::map<BasicBlock*, ref<Expr> >::iterator it =
						targets.begin(), ie = targets.end(); it != ie; ++it) {

					ExecutionState *es = *bit;
					if (es) {
						transferToBasicBlock(it->first, bb, *es);

						caseIndex = (targetsPosition.find(it->first))->second;
						chosingPath = "";
						for(unsigned i = 0 ; i< caseIndex; i++) chosingPath +='0';
						chosingPath +='1';

						if(depth + caseIndex < guilde.length())
							for(unsigned i = 0 ; i<= caseIndex; i++){
								if(guilde[depth + i] != chosingPath[i]){
									isFollowingPath = false;
									break;
								}
							}
						else isFollowingPath = false;

						if (isFollowingPath) {
							if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Following path with symbolic" << caseIndex << "\n";
							tempHSET = runWithSymbolicExecution(*es, guilde, depth + caseIndex + 1, abstractMethod, false);
							resultHSET.LWCET += tempHSET.LWCET;
						} else {
							std::string nodeSummary = ExtractNodeSummary(guilde.substr(0,depth) + chosingPath);
							if (nodeSummary != "") {
								tempHSET = *(new HSETSummary(nodeSummary));
							} else{
								if(interpreterOpts.ExeConfig == Interpreter::HybridAbstractExecution){
									tempHSET = runWithSymbolicExecution(*es, guilde.substr(0,depth) + chosingPath, depth + chosingPath.length(), abstractMethod, true);
								} else if(interpreterOpts.ExeConfig == Interpreter::HybridSymbolicExecution)
									tempHSET = runWithAbstract(*es, abstractMethod, false);
							}
						}
						if (tempHSET.WCET > maxHSET.WCET || (tempHSET.WCET == maxHSET.WCET && tempHSET.isConcrete())) {
							maxHSET = tempHSET.clone(0);
							maxPath = chosingPath;
						}
					}
					++bit;

				}
				resultHSET.updateNextNode(maxPath);
				resultHSET.concat(maxHSET);
				isTerminated = true;
			}


			if (INTERPOLATION_ENABLED)
				interpTree->execute(i);
			break;
		}
		case Instruction::Unreachable:
			// Note that this is not necessarily an internal bug, llvm will
			// generate unreachable instructions in cases where it knows the
			// program will crash. So it is effectively a SEGV or internal
			// error.
			isTerminated = true;
			break;

		case Instruction::Invoke:
		case Instruction::Call: {
			CallSite cs(i);
			unsigned numArgs = cs.arg_size();
			Value *fp = cs.getCalledValue();
			Function *f = getTargetFunction(fp, state);

			// Skip debug intrinsics, we can't evaluate their metadata arguments.
			if (f && isDebugIntrinsic(f, kmodule))
				break;

			if (isa < InlineAsm > (fp)) {
				isTerminated = true;
				break;
			}
			// evaluate arguments
			std::vector < std::pair<ref<Expr>, TaintSet> > arguments;
			arguments.reserve(numArgs);

			for (unsigned j = 0; j < numArgs; ++j) {
				Cell cell = eval(ki, j + 1, state);
				arguments.push_back(std::make_pair(cell.value, cell.taint));
			}

			if (f) {
				const FunctionType *fType =
						dyn_cast < FunctionType
								> (cast < PointerType
										> (f->getType())->getElementType());
				const FunctionType *fpType = dyn_cast < FunctionType
						> (cast < PointerType
								> (fp->getType())->getElementType());

				// special case the call with a bitcast case
				if (fType != fpType) {
					assert(fType && fpType && "unable to get function type");

					// XXX check result coercion

					// XXX this really needs thought and validation
					unsigned i = 0;
					for (std::vector<std::pair<ref<Expr>, TaintSet> >::iterator
							ai = arguments.begin(), ie = arguments.end();
							ai != ie; ++ai) {
						Expr::Width to, from = (*ai).first->getWidth();

						if (i < fType->getNumParams()) {
							to = getWidthForLLVMType(fType->getParamType(i));

							if (from != to) {
								// XXX need to check other param attrs ?
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
								bool isSExt = cs.paramHasAttr(i + 1,
										llvm::Attribute::SExt);
#elif LLVM_VERSION_CODE >= LLVM_VERSION(3, 2)
								bool isSExt = cs.paramHasAttr(i+1, llvm::Attributes::SExt);
#else
								bool isSExt = cs.paramHasAttr(i+1, llvm::Attribute::SExt);
#endif
								if (isSExt) {
									arguments[i].first = SExtExpr::create(
											arguments[i].first, to);
								} else {
									arguments[i].first = ZExtExpr::create(
											arguments[i].first, to);
								}
							}
						}

						i++;
					}
				}

				executeCall(state, ki, f, arguments);
				movedForward = true;
				if (f->isDeclaration()) {
					switch (f->getIntrinsicID()) {
					case Intrinsic::not_intrinsic:
						movedForward = false;
						break;
					default:
						break;
					}
				}

			} else {
				ref<Expr> v = eval(ki, 0, state).value;

				ExecutionState *free = &state;
				bool hasInvalid = false, first = true;

				/* XXX This is wasteful, no need to do a full evaluate since we
				 have already got a value. But in the end the caches should
				 handle it for us, albeit with some overhead. */
				do {
					ref<ConstantExpr> value;
					bool success = solver->getValue(*free, v, value);
					assert(success && "FIXME: Unhandled solver failure");
					(void) success;
					StatePair res = fork(*free, EqExpr::create(v, value), true);
					if (res.first) {
						uint64_t addr = value->getZExtValue();
						if (legalFunctions.count(addr)) {
							f = (Function*) addr;

							// Don't give warning on unique resolution
							if (res.second || !first)
								klee_warning_once((void*) (unsigned long) addr,
										"resolved symbolic function pointer to: %s",
										f->getName().data());

							executeCall(*res.first, ki, f, arguments);
						} else {
							if (!hasInvalid) {
								isTerminated = true;
								hasInvalid = true;
							}
						}
					}

					first = false;
					free = res.second;
				} while (free);
			}

			break;
		}
		case Instruction::PHI: {
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 0)
			Cell result = eval(ki, state.incomingBBIndex, state);
#else
			Cell result = eval(ki, state.incomingBBIndex * 2, state);
#endif
			bindLocal(ki, state, result.value, result.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED) {
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 0)
				interpTree->executePHI(i, state.incomingBBIndex, result.value);
#else
				interpTree->executePHI(i, state.incomingBBIndex * 2, result.value);
#endif
			}

			break;
		}

			// Special instructions
		case Instruction::Select: {
			Cell cond = eval(ki, 0, state);
			Cell tExpr = eval(ki, 1, state);
			Cell fExpr = eval(ki, 2, state);
			ref<Expr> result = SelectExpr::create(cond.value, tExpr.value,
					fExpr.value);
			bindLocal(ki, state, result,
					cond.taint | tExpr.taint | fExpr.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, tExpr.value, fExpr.value);
			break;
		}

		case Instruction::VAArg:
			isTerminated = true;
			break;

			// Arithmetic / logical

		case Instruction::Add: {
			Cell left = eval(ki, 0, state);
			Cell right = eval(ki, 1, state);
			ref<Expr> result = AddExpr::create(left.value, right.value);
			bindLocal(ki, state, result, left.taint | right.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left.value, right.value);
			break;
		}

		case Instruction::Sub: {
			Cell left = eval(ki, 0, state);
			Cell right = eval(ki, 1, state);
			ref<Expr> result = SubExpr::create(left.value, right.value);
			bindLocal(ki, state, result, left.taint | right.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left.value, right.value);
			break;
		}

		case Instruction::Mul: {
			Cell left = eval(ki, 0, state);
			Cell right = eval(ki, 1, state);
			ref<Expr> result = MulExpr::create(left.value, right.value);
			bindLocal(ki, state, result, left.taint | right.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left.value, right.value);
			break;
		}

		case Instruction::UDiv: {
			Cell left = eval(ki, 0, state);
			Cell right = eval(ki, 1, state);
			ref<Expr> result = UDivExpr::create(left.value, right.value);
			bindLocal(ki, state, result, left.taint | right.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left.value, right.value);
			break;
		}

		case Instruction::SDiv: {
			Cell left = eval(ki, 0, state);
			Cell right = eval(ki, 1, state);
			ref<Expr> result = SDivExpr::create(left.value, right.value);
			bindLocal(ki, state, result, left.taint | right.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left.value, right.value);
			break;
		}

		case Instruction::URem: {
			Cell left = eval(ki, 0, state);
			Cell right = eval(ki, 1, state);
			ref<Expr> result = URemExpr::create(left.value, right.value);
			bindLocal(ki, state, result, left.taint | right.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left.value, right.value);
			break;
		}

		case Instruction::SRem: {
			Cell left = eval(ki, 0, state);
			Cell right = eval(ki, 1, state);
			ref<Expr> result = SRemExpr::create(left.value, right.value);
			bindLocal(ki, state, result, left.taint | right.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left.value, right.value);
			break;
		}

		case Instruction::And: {
			Cell left = eval(ki, 0, state);
			Cell right = eval(ki, 1, state);
			ref<Expr> result = AndExpr::create(left.value, right.value);
			bindLocal(ki, state, result, left.taint | right.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left.value, right.value);
			break;
		}

		case Instruction::Or: {
			Cell left = eval(ki, 0, state);
			Cell right = eval(ki, 1, state);
			ref<Expr> result = OrExpr::create(left.value, right.value);
			bindLocal(ki, state, result, left.taint | right.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left.value, right.value);
			break;
		}

		case Instruction::Xor: {
			Cell left = eval(ki, 0, state);
			Cell right = eval(ki, 1, state);
			ref<Expr> result = XorExpr::create(left.value, right.value);
			bindLocal(ki, state, result, left.taint | right.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left.value, right.value);
			break;
		}

		case Instruction::Shl: {
			Cell left = eval(ki, 0, state);
			Cell right = eval(ki, 1, state);
			ref<Expr> result = ShlExpr::create(left.value, right.value);
			bindLocal(ki, state, result, left.taint | right.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left.value, right.value);
			break;
		}

		case Instruction::LShr: {
			Cell left = eval(ki, 0, state);
			Cell right = eval(ki, 1, state);
			ref<Expr> result = LShrExpr::create(left.value, right.value);
			bindLocal(ki, state, result, left.taint | right.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left.value, right.value);
			break;
		}

		case Instruction::AShr: {
			Cell left = eval(ki, 0, state);
			Cell right = eval(ki, 1, state);
			ref<Expr> result = AShrExpr::create(left.value, right.value);
			bindLocal(ki, state, result, left.taint | right.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left.value, right.value);
			break;
		}

			// Compare

		case Instruction::ICmp: {
			CmpInst *ci = cast < CmpInst > (i);
			ICmpInst *ii = cast < ICmpInst > (ci);
			Cell left = eval(ki, 0, state);
			Cell right = eval(ki, 1, state);
			ref<Expr> result;

			switch (ii->getPredicate()) {
			case ICmpInst::ICMP_EQ: {
				result = EqExpr::create(left.value, right.value);
				break;
			}

			case ICmpInst::ICMP_NE: {
				result = NeExpr::create(left.value, right.value);
				break;
			}

			case ICmpInst::ICMP_UGT: {
				result = UgtExpr::create(left.value, right.value);
				break;
			}

			case ICmpInst::ICMP_UGE: {
				result = UgeExpr::create(left.value, right.value);
				break;
			}

			case ICmpInst::ICMP_ULT: {
				result = UltExpr::create(left.value, right.value);
				break;
			}

			case ICmpInst::ICMP_ULE: {
				result = UleExpr::create(left.value, right.value);
				break;
			}

			case ICmpInst::ICMP_SGT: {
				result = SgtExpr::create(left.value, right.value);
				break;
			}

			case ICmpInst::ICMP_SGE: {
				result = SgeExpr::create(left.value, right.value);
				break;
			}

			case ICmpInst::ICMP_SLT: {
				result = SltExpr::create(left.value, right.value);
				break;
			}

			case ICmpInst::ICMP_SLE: {
				result = SleExpr::create(left.value, right.value);
				break;
			}

			default:
				terminateStateOnExecError(state, "invalid ICmp predicate");
			}

			bindLocal(ki, state, result, left.taint | right.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left.value, right.value);
			break;
		}

			// Memory instructions...
		case Instruction::Alloca: {
			AllocaInst *ai = cast < AllocaInst > (i);
			unsigned elementSize = kmodule->targetData->getTypeStoreSize(
					ai->getAllocatedType());
			ref<Expr> size = Expr::createPointer(elementSize);
			if (ai->isArrayAllocation()) {
				ref<Expr> count = eval(ki, 0, state).value;
				count = Expr::createZExtToPointerWidth(count);
				size = MulExpr::create(size, count);
			}
			bool isLocal = i->getOpcode() == Instruction::Alloca;
			executeAlloc(state, size, isLocal, ki);
			break;
		}

		case Instruction::Load: {
			executeMemoryOperation(state, false, eval(ki, 0, state).value, 0,
					ki, eval(ki, 0, state).taint, 0);
			break;
		}
		case Instruction::Store: {
			executeMemoryOperation(state, true, eval(ki, 1, state).value,
					eval(ki, 0, state).value, ki, eval(ki, 1, state).taint,
					eval(ki, 0, state).taint);
			break;
		}

		case Instruction::GetElementPtr: {
			KGEPInstruction *kgepi = static_cast<KGEPInstruction*>(ki);
			Cell base = eval(ki, 0, state);
			TaintSet taint = base.taint;
			ref<Expr> result = base.value;

			ref<Expr> oldResult = result;
			for (std::vector<std::pair<unsigned, uint64_t> >::iterator it =
					kgepi->indices.begin(), ie = kgepi->indices.end(); it != ie;
					++it) {
				uint64_t elementSize = it->second;

				Cell index = eval(ki, it->first, state);
				result = AddExpr::create(result,
						MulExpr::create(
								Expr::createSExtToPointerWidth(index.value),
								Expr::createPointer(elementSize)));
				taint |= index.taint;
			}
			if (kgepi->offset)
				result = AddExpr::create(result,
						Expr::createPointer(kgepi->offset));

			bindLocal(ki, state, result, taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, oldResult);
			break;
		}

			// Conversion
		case Instruction::Trunc: {
			CastInst *ci = cast < CastInst > (i);
			Cell arg = eval(ki, 0, state);
			ref<Expr> result = ExtractExpr::create(arg.value, 0,
					getWidthForLLVMType(ci->getType()));
			bindLocal(ki, state, result, arg.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result);
			break;
		}
		case Instruction::ZExt: {
			CastInst *ci = cast < CastInst > (i);
			Cell arg = eval(ki, 0, state);
			ref<Expr> result = ZExtExpr::create(arg.value,
					getWidthForLLVMType(ci->getType()));
			bindLocal(ki, state, result, arg.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result);
			break;
		}
		case Instruction::SExt: {
			CastInst *ci = cast < CastInst > (i);
			Cell arg = eval(ki, 0, state);
			ref<Expr> result = SExtExpr::create(arg.value,
					getWidthForLLVMType(ci->getType()));
			bindLocal(ki, state, result, arg.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result);
			break;
		}

		case Instruction::IntToPtr: {
			CastInst *ci = cast < CastInst > (i);
			Expr::Width pType = getWidthForLLVMType(ci->getType());
			Cell arg = eval(ki, 0, state);
			ref<Expr> result = ZExtExpr::create(arg.value, pType);
			bindLocal(ki, state, result, arg.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result);
			break;
		}
		case Instruction::PtrToInt: {
			CastInst *ci = cast < CastInst > (i);
			Expr::Width iType = getWidthForLLVMType(ci->getType());
			Cell arg = eval(ki, 0, state);
			ref<Expr> result = ZExtExpr::create(arg.value, iType);
			bindLocal(ki, state, result, arg.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result);
			break;
		}

		case Instruction::BitCast: {
			Cell result = eval(ki, 0, state);
			bindLocal(ki, state, result.value, result.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result.value);
			break;
		}

			// Floating point instructions

		case Instruction::FAdd: {
			ref<ConstantExpr> left = toConstant(state, eval(ki, 0, state).value,
					"floating point");
			ref<ConstantExpr> right = toConstant(state,
					eval(ki, 1, state).value, "floating point");
			if (!fpWidthToSemantics(left->getWidth())
					|| !fpWidthToSemantics(right->getWidth()))
				isTerminated = true;

#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
			llvm::APFloat Res(*fpWidthToSemantics(left->getWidth()),
					left->getAPValue());
			Res.add(
					APFloat(*fpWidthToSemantics(right->getWidth()),
							right->getAPValue()), APFloat::rmNearestTiesToEven);
#else
			llvm::APFloat Res(left->getAPValue());
			Res.add(APFloat(right->getAPValue()), APFloat::rmNearestTiesToEven);
#endif
			ref<Expr> result = ConstantExpr::alloc(Res.bitcastToAPInt());
			bindLocal(ki, state, result,
					eval(ki, 0, state).taint | eval(ki, 1, state).taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left, right);
			break;
		}

		case Instruction::FSub: {
			ref<ConstantExpr> left = toConstant(state, eval(ki, 0, state).value,
					"floating point");
			ref<ConstantExpr> right = toConstant(state,
					eval(ki, 1, state).value, "floating point");
			if (!fpWidthToSemantics(left->getWidth())
					|| !fpWidthToSemantics(right->getWidth()))
				isTerminated = true;
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
			llvm::APFloat Res(*fpWidthToSemantics(left->getWidth()),
					left->getAPValue());
			Res.subtract(
					APFloat(*fpWidthToSemantics(right->getWidth()),
							right->getAPValue()), APFloat::rmNearestTiesToEven);
#else
			llvm::APFloat Res(left->getAPValue());
			Res.subtract(APFloat(right->getAPValue()), APFloat::rmNearestTiesToEven);
#endif
			ref<Expr> result = ConstantExpr::alloc(Res.bitcastToAPInt());
			bindLocal(ki, state, result,
					eval(ki, 0, state).taint | eval(ki, 1, state).taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left, right);
			break;
		}

		case Instruction::FMul: {
			ref<ConstantExpr> left = toConstant(state, eval(ki, 0, state).value,
					"floating point");
			ref<ConstantExpr> right = toConstant(state,
					eval(ki, 1, state).value, "floating point");
			if (!fpWidthToSemantics(left->getWidth())
					|| !fpWidthToSemantics(right->getWidth()))
				isTerminated = true;

#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
			llvm::APFloat Res(*fpWidthToSemantics(left->getWidth()),
					left->getAPValue());
			Res.multiply(
					APFloat(*fpWidthToSemantics(right->getWidth()),
							right->getAPValue()), APFloat::rmNearestTiesToEven);
#else
			llvm::APFloat Res(left->getAPValue());
			Res.multiply(APFloat(right->getAPValue()), APFloat::rmNearestTiesToEven);
#endif
			ref<Expr> result = ConstantExpr::alloc(Res.bitcastToAPInt());
			bindLocal(ki, state, result,
					eval(ki, 0, state).taint | eval(ki, 1, state).taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left, right);
			break;
		}

		case Instruction::FDiv: {
			ref<ConstantExpr> left = toConstant(state, eval(ki, 0, state).value,
					"floating point");
			ref<ConstantExpr> right = toConstant(state,
					eval(ki, 1, state).value, "floating point");
			if (!fpWidthToSemantics(left->getWidth())
					|| !fpWidthToSemantics(right->getWidth()))
				isTerminated = true;

#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
			llvm::APFloat Res(*fpWidthToSemantics(left->getWidth()),
					left->getAPValue());
			Res.divide(
					APFloat(*fpWidthToSemantics(right->getWidth()),
							right->getAPValue()), APFloat::rmNearestTiesToEven);
#else
			llvm::APFloat Res(left->getAPValue());
			Res.divide(APFloat(right->getAPValue()), APFloat::rmNearestTiesToEven);
#endif
			ref<Expr> result = ConstantExpr::alloc(Res.bitcastToAPInt());
			bindLocal(ki, state, result,
					eval(ki, 0, state).taint | eval(ki, 1, state).taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left, right);
			break;
		}

		case Instruction::FRem: {
			ref<ConstantExpr> left = toConstant(state, eval(ki, 0, state).value,
					"floating point");
			ref<ConstantExpr> right = toConstant(state,
					eval(ki, 1, state).value, "floating point");
			if (!fpWidthToSemantics(left->getWidth())
					|| !fpWidthToSemantics(right->getWidth()))
				isTerminated = true;
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
			llvm::APFloat Res(*fpWidthToSemantics(left->getWidth()),
					left->getAPValue());
			Res.mod(
					APFloat(*fpWidthToSemantics(right->getWidth()),
							right->getAPValue()), APFloat::rmNearestTiesToEven);
#else
			llvm::APFloat Res(left->getAPValue());
			Res.mod(APFloat(right->getAPValue()), APFloat::rmNearestTiesToEven);
#endif
			ref<Expr> result = ConstantExpr::alloc(Res.bitcastToAPInt());
			bindLocal(ki, state, result,
					eval(ki, 0, state).taint | eval(ki, 1, state).taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left, right);
			break;
		}

		case Instruction::FPTrunc: {
			FPTruncInst *fi = cast < FPTruncInst > (i);
			Expr::Width resultType = getWidthForLLVMType(fi->getType());
			ref<ConstantExpr> arg = toConstant(state, eval(ki, 0, state).value,
					"floating point");
			if (!fpWidthToSemantics(arg->getWidth())
					|| resultType > arg->getWidth())
				isTerminated = true;
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
			llvm::APFloat Res(*fpWidthToSemantics(arg->getWidth()),
					arg->getAPValue());
#else
			llvm::APFloat Res(arg->getAPValue());
#endif
			bool losesInfo = false;
			Res.convert(*fpWidthToSemantics(resultType),
					llvm::APFloat::rmNearestTiesToEven, &losesInfo);
			ref<Expr> result = ConstantExpr::alloc(Res);
			bindLocal(ki, state, result, eval(ki, 0, state).taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result);
			break;
		}

		case Instruction::FPExt: {
			FPExtInst *fi = cast < FPExtInst > (i);
			Expr::Width resultType = getWidthForLLVMType(fi->getType());
			ref<ConstantExpr> arg = toConstant(state, eval(ki, 0, state).value,
					"floating point");
			if (!fpWidthToSemantics(arg->getWidth())
					|| arg->getWidth() > resultType)
				isTerminated = true;
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
			llvm::APFloat Res(*fpWidthToSemantics(arg->getWidth()),
					arg->getAPValue());
#else
			llvm::APFloat Res(arg->getAPValue());
#endif
			bool losesInfo = false;
			Res.convert(*fpWidthToSemantics(resultType),
					llvm::APFloat::rmNearestTiesToEven, &losesInfo);
			ref<Expr> result = ConstantExpr::alloc(Res);
			bindLocal(ki, state, result, eval(ki, 0, state).taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result);
			break;
		}

		case Instruction::FPToUI: {
			FPToUIInst *fi = cast < FPToUIInst > (i);
			Expr::Width resultType = getWidthForLLVMType(fi->getType());
			ref<ConstantExpr> arg = toConstant(state, eval(ki, 0, state).value,
					"floating point");
			if (!fpWidthToSemantics(arg->getWidth()) || resultType > 64)
				isTerminated = true;

#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
			llvm::APFloat Arg(*fpWidthToSemantics(arg->getWidth()),
					arg->getAPValue());
#else
			llvm::APFloat Arg(arg->getAPValue());
#endif
			uint64_t value = 0;
			bool isExact = true;
			Arg.convertToInteger(&value, resultType, false,
					llvm::APFloat::rmTowardZero, &isExact);
			ref<Expr> result = ConstantExpr::alloc(value, resultType);
			bindLocal(ki, state, result, eval(ki, 0, state).taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result);
			break;
		}

		case Instruction::FPToSI: {
			FPToSIInst *fi = cast < FPToSIInst > (i);
			Expr::Width resultType = getWidthForLLVMType(fi->getType());
			ref<ConstantExpr> arg = toConstant(state, eval(ki, 0, state).value,
					"floating point");
			if (!fpWidthToSemantics(arg->getWidth()) || resultType > 64)
				isTerminated = true;
#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
			llvm::APFloat Arg(*fpWidthToSemantics(arg->getWidth()),
					arg->getAPValue());
#else
			llvm::APFloat Arg(arg->getAPValue());

#endif
			uint64_t value = 0;
			bool isExact = true;
			Arg.convertToInteger(&value, resultType, true,
					llvm::APFloat::rmTowardZero, &isExact);
			ref<Expr> result = ConstantExpr::alloc(value, resultType);
			bindLocal(ki, state, result, eval(ki, 0, state).taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result);
			break;
		}

		case Instruction::UIToFP: {
			UIToFPInst *fi = cast < UIToFPInst > (i);
			Expr::Width resultType = getWidthForLLVMType(fi->getType());
			ref<ConstantExpr> arg = toConstant(state, eval(ki, 0, state).value,
					"floating point");
			const llvm::fltSemantics *semantics = fpWidthToSemantics(
					resultType);
			if (!semantics)
				isTerminated = true;
			llvm::APFloat f(*semantics, 0);
			f.convertFromAPInt(arg->getAPValue(), false,
					llvm::APFloat::rmNearestTiesToEven);

			ref<Expr> result = ConstantExpr::alloc(f);
			bindLocal(ki, state, result, eval(ki, 0, state).taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result);
			break;
		}

		case Instruction::SIToFP: {
			SIToFPInst *fi = cast < SIToFPInst > (i);
			Expr::Width resultType = getWidthForLLVMType(fi->getType());
			ref<ConstantExpr> arg = toConstant(state, eval(ki, 0, state).value,
					"floating point");
			const llvm::fltSemantics *semantics = fpWidthToSemantics(
					resultType);
			if (!semantics)
				isTerminated = true;
			llvm::APFloat f(*semantics, 0);
			f.convertFromAPInt(arg->getAPValue(), true,
					llvm::APFloat::rmNearestTiesToEven);

			ref<Expr> result = ConstantExpr::alloc(f);
			bindLocal(ki, state, result, eval(ki, 0, state).taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result);
			break;
		}

		case Instruction::FCmp: {
			FCmpInst *fi = cast < FCmpInst > (i);
			ref<ConstantExpr> left = toConstant(state, eval(ki, 0, state).value,
					"floating point");
			ref<ConstantExpr> right = toConstant(state,
					eval(ki, 1, state).value, "floating point");
			if (!fpWidthToSemantics(left->getWidth())
					|| !fpWidthToSemantics(right->getWidth()))
				isTerminated = true;

#if LLVM_VERSION_CODE >= LLVM_VERSION(3, 3)
			APFloat LHS(*fpWidthToSemantics(left->getWidth()),
					left->getAPValue());
			APFloat RHS(*fpWidthToSemantics(right->getWidth()),
					right->getAPValue());
#else
			APFloat LHS(left->getAPValue());
			APFloat RHS(right->getAPValue());
#endif
			APFloat::cmpResult CmpRes = LHS.compare(RHS);

			bool Result = false;
			switch (fi->getPredicate()) {
			// Predicates which only care about whether or not the operands are NaNs.
			case FCmpInst::FCMP_ORD:
				Result = CmpRes != APFloat::cmpUnordered;
				break;

			case FCmpInst::FCMP_UNO:
				Result = CmpRes == APFloat::cmpUnordered;
				break;

				// Ordered comparisons return false if either operand is NaN.  Unordered
				// comparisons return true if either operand is NaN.
			case FCmpInst::FCMP_UEQ:
				if (CmpRes == APFloat::cmpUnordered) {
					Result = true;
					break;
				}
			case FCmpInst::FCMP_OEQ:
				Result = CmpRes == APFloat::cmpEqual;
				break;

			case FCmpInst::FCMP_UGT:
				if (CmpRes == APFloat::cmpUnordered) {
					Result = true;
					break;
				}
			case FCmpInst::FCMP_OGT:
				Result = CmpRes == APFloat::cmpGreaterThan;
				break;

			case FCmpInst::FCMP_UGE:
				if (CmpRes == APFloat::cmpUnordered) {
					Result = true;
					break;
				}
			case FCmpInst::FCMP_OGE:
				Result = CmpRes == APFloat::cmpGreaterThan
						|| CmpRes == APFloat::cmpEqual;
				break;

			case FCmpInst::FCMP_ULT:
				if (CmpRes == APFloat::cmpUnordered) {
					Result = true;
					break;
				}
			case FCmpInst::FCMP_OLT:
				Result = CmpRes == APFloat::cmpLessThan;
				break;

			case FCmpInst::FCMP_ULE:
				if (CmpRes == APFloat::cmpUnordered) {
					Result = true;
					break;
				}
			case FCmpInst::FCMP_OLE:
				Result = CmpRes == APFloat::cmpLessThan
						|| CmpRes == APFloat::cmpEqual;
				break;

			case FCmpInst::FCMP_UNE:
				Result = CmpRes == APFloat::cmpUnordered
						|| CmpRes != APFloat::cmpEqual;
				break;
			case FCmpInst::FCMP_ONE:
				Result = CmpRes != APFloat::cmpUnordered
						&& CmpRes != APFloat::cmpEqual;
				break;

			default:
				assert(0 && "Invalid FCMP predicate!");
			case FCmpInst::FCMP_FALSE:
				Result = false;
				break;
			case FCmpInst::FCMP_TRUE:
				Result = true;
				break;
			}

			ref<Expr> result = ConstantExpr::alloc(Result, Expr::Bool);
			bindLocal(ki, state, result,
					eval(ki, 0, state).taint | eval(ki, 1, state).taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, left, right);
			break;
		}
		case Instruction::InsertValue: {
			KGEPInstruction *kgepi = static_cast<KGEPInstruction*>(ki);

			ref<Expr> agg = eval(ki, 0, state).value;
			ref<Expr> val = eval(ki, 1, state).value;

			ref<Expr> l = NULL, r = NULL;
			unsigned lOffset = kgepi->offset * 8, rOffset = kgepi->offset * 8
					+ val->getWidth();

			if (lOffset > 0)
				l = ExtractExpr::create(agg, 0, lOffset);
			if (rOffset < agg->getWidth())
				r = ExtractExpr::create(agg, rOffset,
						agg->getWidth() - rOffset);

			ref<Expr> result;
			if (!l.isNull() && !r.isNull())
				result = ConcatExpr::create(r, ConcatExpr::create(val, l));
			else if (!l.isNull())
				result = ConcatExpr::create(val, l);
			else if (!r.isNull())
				result = ConcatExpr::create(r, val);
			else
				result = val;

			bindLocal(ki, state, result,
					eval(ki, 0, state).taint | eval(ki, 1, state).taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result, agg, val);
			break;
		}
		case Instruction::ExtractValue: {
			KGEPInstruction *kgepi = static_cast<KGEPInstruction*>(ki);

			Cell agg = eval(ki, 0, state);

			ref<Expr> result = ExtractExpr::create(agg.value, kgepi->offset * 8,
					getWidthForLLVMType(i->getType()));

			bindLocal(ki, state, result, agg.taint);

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(i, result);
			break;
		}

			// Other instructions...
			// Unhandled
		case Instruction::ExtractElement:
		case Instruction::InsertElement:
		case Instruction::ShuffleVector:
			isTerminated = true;
			break;

		default:
			isTerminated = true;
			break;
		}

		if (isTerminated) {
			break;
		} else {

			if (!movedForward) {
				state.prevPC = state.pc;
				++state.pc;
			}
		}
	}

	std::stringstream iss;
	iss << resultHSET.WCET << " " << resultHSET.LWCET << " " << resultHSET.isConcrete() << " " << resultHSET.Path;

	PTreeNode* workingNode = ExtractNode(ExtractPath(guilde, depth - 1 , guilde[depth - 1]));
	if (workingNode != 0) {
		std::stringstream iss2(workingNode->ExecutionSummary);
		std::string temp;
		iss2 >> temp; iss2 >> temp; iss2 >> temp;
		if((temp == "1") && resultHSET.isConcrete()){
			if(isLeafNode){
				--HSETInfo.NumberExactLeafNode;
			} else {
				--HSETInfo.NumberExactInternalNode;
			}
		}
		workingNode->ExecutionSummary = "";
	}

	if(HSETInfo.IsTurnOnNotification){
		llvm::errs() << "Saving Path:";
		for (int i = 0; i < depth; i++)
			llvm::errs() << guilde[i];
		llvm::errs() << " " << resultHSET.WCET << "\n";
	}

	//HSETInfo.exactPathDictionary.insert(curExactInfo);
	workingNode->ExecutionSummary = iss.str();

	if(resultHSET.isConcrete()){
		if(isLeafNode){
			++HSETInfo.NumberExactLeafNode;
		} else {
			++HSETInfo.NumberExactInternalNode;
		}
	}

	return resultHSET;
}

Executor::RawAbstractState Executor::abstractRawState(ExecutionState &state,
		Executor::HSETAbstractMethods abstractMethod) {
	return *(new RawAbstractState(state));
}

bool Executor::compareRawAbstractDomain(RawAbstractState leftState,
		RawAbstractState rightState) {
	return leftState == rightState;
}
/* End HSET Methods*/

std::string Executor::getAddressInfo(ExecutionState &state,
		ref<Expr> address) const {
	std::string Str;
	llvm::raw_string_ostream info(Str);
	info << "\taddress: " << address << "\n";
	uint64_t example;
	if (ConstantExpr *CE = dyn_cast < ConstantExpr > (address)) {
		example = CE->getZExtValue();
	} else {
		ref<ConstantExpr> value;
		bool success = solver->getValue(state, address, value);
		assert(success && "FIXME: Unhandled solver failure");
		(void) success;
		example = value->getZExtValue();
		info << "\texample: " << example << "\n";
		std::pair<ref<Expr>, ref<Expr> > res = solver->getRange(state, address);
		info << "\trange: [" << res.first << ", " << res.second << "]\n";
	}

	MemoryObject hack((unsigned) example);
	MemoryMap::iterator lower = state.addressSpace.objects.upper_bound(&hack);
	info << "\tnext: ";
	if (lower == state.addressSpace.objects.end()) {
		info << "none\n";
	} else {
		const MemoryObject *mo = lower->first;
		std::string alloc_info;
		mo->getAllocInfo(alloc_info);
		info << "object at " << mo->address << " of size " << mo->size << "\n"
				<< "\t\t" << alloc_info << "\n";
	}

	if (lower != state.addressSpace.objects.begin()) {
		--lower;
		info << "\tprev: ";
		if (lower == state.addressSpace.objects.end()) {
			info << "none\n";
		} else {
			const MemoryObject *mo = lower->first;
			std::string alloc_info;
			mo->getAllocInfo(alloc_info);
			info << "object at " << mo->address << " of size " << mo->size
					<< "\n" << "\t\t" << alloc_info << "\n";
		}
	}

	return info.str();
}

int Executor::estimateSpecificInstruction(llvm::Instruction* i) {
	int _InsTime = 0;
	int basic = 1;
	switch (i->getOpcode()) {
// Control flow
	case Instruction::Ret: {
		_InsTime = basic * 1;
		break;
	}
	case Instruction::Br: {
		_InsTime = basic * 1;
		break;
	}
	case Instruction::Switch: {
		_InsTime = basic * 1;
		break;
	}
	case Instruction::Unreachable: {
		_InsTime = basic * 1;
		break;
	}
	case Instruction::Invoke:
	case Instruction::Call: {
		_InsTime = basic * 2;
		break;
	}
	case Instruction::PHI: {
		_InsTime = basic * 1;
		break;
	}

		// Special instructions
	case Instruction::Select: {
		_InsTime = basic * 1;
		break;
	}

	case Instruction::VAArg: {
		_InsTime = basic * 1;
		break;
	}
		// Arithmetic / logical

	case Instruction::Add: {
		_InsTime = basic * 2;
		break;
	}

	case Instruction::Sub: {
		_InsTime = basic * 2;
		break;
	}

	case Instruction::Mul: {
		_InsTime = basic * 3;
		break;
	}

	case Instruction::UDiv: {
		_InsTime = basic * 3;
		break;
	}

	case Instruction::SDiv: {
		_InsTime = basic * 3;
		break;
	}

	case Instruction::URem: {
		_InsTime = basic * 3;
		break;
	}

	case Instruction::SRem: {
		_InsTime = basic * 3;
		break;
	}

	case Instruction::And: {
		_InsTime = basic * 1;
		break;
	}

	case Instruction::Or: {
		_InsTime = basic * 1;
		break;
	}

	case Instruction::Xor: {
		_InsTime = basic * 1;
		break;
	}

	case Instruction::Shl: {
		_InsTime = basic * 1;
		break;
	}

	case Instruction::LShr: {
		_InsTime = basic * 1;
		break;
	}

	case Instruction::AShr: {
		_InsTime = basic * 1;
		break;
	}

		// Compare

	case Instruction::ICmp: {
		_InsTime = basic * 3;
		break;
	}

		// Memory instructions...
	case Instruction::Alloca: {
		_InsTime = basic * 3;
		break;
	}

	case Instruction::Load: {
		_InsTime = basic * 3;
		break;
	}
	case Instruction::Store: {
		_InsTime = basic * 3;
		break;
	}

	case Instruction::GetElementPtr: {
		_InsTime = basic * 2;
		break;
	}

		// Conversion
	case Instruction::Trunc: {
		_InsTime = basic * 1;
		break;
	}
	case Instruction::ZExt: {
		_InsTime = basic * 1;
		break;
	}
	case Instruction::SExt: {
		_InsTime = basic * 1;
		break;
	}

	case Instruction::IntToPtr: {
		_InsTime = basic * 2;
		break;
	}
	case Instruction::PtrToInt: {
		_InsTime = basic * 2;
		break;
	}

	case Instruction::BitCast: {
		_InsTime = basic * 2;
		break;
	}

		// Floating point instructions

	case Instruction::FAdd: {
		_InsTime = basic * 3;
		break;
	}

	case Instruction::FSub: {
		_InsTime = basic * 3;
		break;
	}

	case Instruction::FMul: {
		_InsTime = basic * 5;
		break;
	}

	case Instruction::FDiv: {
		_InsTime = basic * 5;
		break;
	}

	case Instruction::FRem: {
		_InsTime = basic * 5;
		break;
	}

	case Instruction::FPTrunc: {
		_InsTime = basic * 5;
		break;
	}

	case Instruction::FPExt: {
		_InsTime = basic * 6;
		break;
	}

	case Instruction::FPToUI: {
		_InsTime = basic * 3;
		break;
	}

	case Instruction::FPToSI: {
		_InsTime = basic * 3;
		break;
	}

	case Instruction::UIToFP: {
		_InsTime = basic * 3;
		break;
	}

	case Instruction::SIToFP: {
		_InsTime = basic * 3;
		break;
	}

	case Instruction::FCmp: {
		_InsTime = basic * 5;
		break;
	}
	case Instruction::InsertValue: {

		break;
	}
	case Instruction::ExtractValue: {

		break;
	}

		// Other instructions...
		// Unhandled
	case Instruction::ExtractElement:
	case Instruction::InsertElement:
	case Instruction::ShuffleVector:
		_InsTime = basic * 3;
		break;

	default:
		_InsTime = basic * 2;
		break;
	}
	return _InsTime;
}

int Executor::calculateTotalTime(ExecutionState &state) {
	int _TotalExtime = 0;

	for (int j = 0; j < state.pathSpecialCount; j++) {
		Instruction *i = state.pathSpecial[j]->inst;
		_TotalExtime = _TotalExtime + estimateSpecificInstruction(i);
	}
	return _TotalExtime;
}

void Executor::terminateState(ExecutionState &state) {
	if (replayOut && replayPosition != replayOut->numObjects) {
		klee_warning_once(replayOut,
				"replay did not consume all objects in test input.");
	}

// Report execution time
	if(HSETInfo.IsTurnOnNotification){
		llvm::errs() << "State End : " << state.depth << "\n";
		for (int j = 0; j < state.pathSpecialCount; j++) {
			llvm::errs() << *(state.pathSpecial[j]->inst) << "\n";
		}
	}

// Report taint path
//llvm::errs() << "Taint Path : " << "\n";
//for (int j = 0; j < state.currentTaintCount; j++) {
//	llvm::errs() << state.stateTrackingTaint[j] << "\n";
//}
//llvm::errs() << "\n";

//llvm::errs() << "State constraints:\n";
//ExprPPrinter::printQuery(llvm::errs(), state.constraints,
//		ConstantExpr::alloc(0, Expr::Bool));
//llvm::errs() << "\n";
// End reporting

	interpreterHandler->incPathsExplored();

	std::set<ExecutionState*>::iterator it = addedStates.find(&state);
	if (it == addedStates.end()) {
		state.pc = state.prevPC;

		removedStates.insert(&state);
	} else {
		// never reached searcher, just delete immediately
		std::map<ExecutionState*, std::vector<SeedInfo> >::iterator it3 =
				seedMap.find(&state);
		if (it3 != seedMap.end())
			seedMap.erase(it3);
		addedStates.erase(it);
		processTree->remove(state.ptreeNode);

		if (INTERPOLATION_ENABLED)
			interpTree->remove(state.itreeNode);
		delete &state;
	}
}

void Executor::terminateStateOnSubsumption(ExecutionState &state) {
	assert(INTERPOLATION_ENABLED);

// Implementationwise, basically the same as terminateStateEarly method,
// but with different statistics functions called, and empty error
// message as this is not an error.
	interpreterHandler->incSubsumptionTermination();
	if (!OnlyOutputStatesCoveringNew || state.coveredNew
			|| (AlwaysOutputSeeds && seedMap.count(&state))) {
		interpreterHandler->incSubsumptionTerminationTest();
		interpreterHandler->processTestCase(state, 0, "early");
	}
	terminateState(state);
}

void Executor::terminateStateEarly(ExecutionState &state,
		const Twine &message) {
	interpreterHandler->incEarlyTermination();
	if (!OnlyOutputStatesCoveringNew || state.coveredNew
			|| (AlwaysOutputSeeds && seedMap.count(&state))) {
		interpreterHandler->incEarlyTerminationTest();
		interpreterHandler->processTestCase(state,
				(message + "\n").str().c_str(), "early");
	}
	llvm::errs() << "Early Stop state:" << message << "\n";
	terminateState(state);
}

void Executor::terminateStateOnExit(ExecutionState &state) {
	interpreterHandler->incExitTermination();
	if (!OnlyOutputStatesCoveringNew || state.coveredNew
			|| (AlwaysOutputSeeds && seedMap.count(&state))) {
		interpreterHandler->incExitTerminationTest();
		interpreterHandler->processTestCase(state, 0, 0);
	}
	int executionTime = calculateTotalTime(state);
	if(HSETInfo.IsTurnOnNotification) llvm::errs() << "Total Time : " << executionTime << "\n\n";
	if (executionTime > GlobalWCET) {
		GlobalWCET = executionTime;

	}
	if(HSETInfo.IsTurnOnNotification) llvm::errs() << "New WCET :" << GlobalWCET << "\n";
	terminateState(state);
}

const InstructionInfo & Executor::getLastNonKleeInternalInstruction(
		const ExecutionState &state, Instruction ** lastInstruction) {
// unroll the stack of the applications state and find
// the last instruction which is not inside a KLEE internal function
	ExecutionState::stack_ty::const_reverse_iterator it = state.stack.rbegin(),
			itE = state.stack.rend();

// don't check beyond the outermost function (i.e. main())
	itE--;

	const InstructionInfo * ii = 0;
	if (kmodule->internalFunctions.count(it->kf->function) == 0) {
		ii = state.prevPC->info;
		*lastInstruction = state.prevPC->inst;
		//  Cannot return yet because even though
		//  it->function is not an internal function it might of
		//  been called from an internal function.
	}

// Wind up the stack and check if we are in a KLEE internal function.
// We visit the entire stack because we want to return a CallInstruction
// that was not reached via any KLEE internal functions.
	for (; it != itE; ++it) {
		// check calling instruction and if it is contained in a KLEE internal function
		const Function * f = (*it->caller).inst->getParent()->getParent();
		if (kmodule->internalFunctions.count(f)) {
			ii = 0;
			continue;
		}
		if (!ii) {
			ii = (*it->caller).info;
			*lastInstruction = (*it->caller).inst;
		}
	}

	if (!ii) {
		// something went wrong, play safe and return the current instruction info
		*lastInstruction = state.prevPC->inst;
		return *state.prevPC->info;
	}
	return *ii;
}
void Executor::terminateStateOnError(ExecutionState &state,
		const llvm::Twine &messaget, const char *suffix,
		const llvm::Twine &info) {
	interpreterHandler->incErrorTermination();

	std::string message = messaget.str();
	static std::set<std::pair<Instruction*, std::string> > emittedErrors;
	Instruction * lastInst;
	const InstructionInfo &ii = getLastNonKleeInternalInstruction(state,
			&lastInst);

	if (EmitAllErrors
			|| emittedErrors.insert(std::make_pair(lastInst, message)).second) {
		if (ii.file != "") {
			klee_message("ERROR: %s:%d: %s", ii.file.c_str(), ii.line,
					message.c_str());
		} else {
			klee_message("ERROR: (location information missing) %s",
					message.c_str());
		}
		if (!EmitAllErrors)
			klee_message("NOTE: now ignoring this error at this location");

		std::string MsgString;
		llvm::raw_string_ostream msg(MsgString);
		msg << "Error: " << message << "\n";
		if (ii.file != "") {
			msg << "File: " << ii.file << "\n";
			msg << "Line: " << ii.line << "\n";
			msg << "assembly.ll line: " << ii.assemblyLine << "\n";
		}
		msg << "Stack: \n";
		state.dumpStack(msg);

		std::string info_str = info.str();
		if (info_str != "")
			msg << "Info: \n" << info_str;

		interpreterHandler->incErrorTerminationTest();
		interpreterHandler->processTestCase(state, msg.str().c_str(), suffix);
	}

	terminateState(state);
}

// XXX shoot me
static const char *okExternalsList[] = { "printf", "fprintf", "puts", "getpid" };
static std::set<std::string> okExternals(okExternalsList,
		okExternalsList
				+ (sizeof(okExternalsList) / sizeof(okExternalsList[0])));

void Executor::callExternalFunction(ExecutionState &state, KInstruction *target,
		Function *function,
		std::vector<std::pair<ref<Expr>, TaintSet> > &my_arguments) {
// check if specialFunctionHandler wants it
	std::vector<ref<Expr> > arguments;
// evaluate arguments
	arguments.reserve(my_arguments.size());
	for (unsigned int i = 0; i < my_arguments.size(); i++)
		arguments.push_back(my_arguments[i].first);

	if (specialFunctionHandler->handle(state, function, target, arguments))
		return;

	if (NoExternals && !okExternals.count(function->getName())) {
		llvm::errs() << "KLEE:ERROR: Calling not-OK external function : "
				<< function->getName().str() << "\n";
		terminateStateOnError(state, "externals disallowed", "user.err");
		return;
	}

// normal external function handling path
// allocate 128 bits for each argument (+return value) to support fp80's;
// we could iterate through all the arguments first and determine the exact
// size we need, but this is faster, and the memory usage isn't significant.
	uint64_t *args = (uint64_t*) alloca(
			2 * sizeof(*args) * (arguments.size() + 1));
	memset(args, 0, 2 * sizeof(*args) * (arguments.size() + 1));
	unsigned wordIndex = 2;
	for (std::vector<ref<Expr> >::iterator ai = arguments.begin(), ae =
			arguments.end(); ai != ae; ++ai) {
		if (AllowExternalSymCalls) { // don't bother checking uniqueness
			ref<ConstantExpr> ce;
			bool success = solver->getValue(state, *ai, ce);
			assert(success && "FIXME: Unhandled solver failure");
			(void) success;
			ce->toMemory(&args[wordIndex]);
			wordIndex += (ce->getWidth() + 63) / 64;
		} else {
			ref<Expr> arg = toUnique(state, *ai);
			if (ConstantExpr *ce = dyn_cast < ConstantExpr > (arg)) {
				// XXX kick toMemory functions from here
				ce->toMemory(&args[wordIndex]);
				wordIndex += (ce->getWidth() + 63) / 64;
			} else {
				terminateStateOnExecError(state,
						"external call with symbolic argument: "
								+ function->getName());
				return;
			}
		}
	}

	state.addressSpace.copyOutConcretes();

	if (!SuppressExternalWarnings) {

		std::string TmpStr;
		llvm::raw_string_ostream os(TmpStr);
		os << "calling external: " << function->getName().str() << "(";
		for (unsigned i = 0; i < arguments.size(); i++) {
			os << arguments[i];
			if (i != arguments.size() - 1)
				os << ", ";
		}
		os << ")";

		if (AllExternalWarnings)
			klee_warning("%s", os.str().c_str());
		else
			klee_warning_once(function, "%s", os.str().c_str());
	}

	bool success = externalDispatcher->executeCall(function, target->inst,
			args);
	if (!success) {
		terminateStateOnError(state,
				"failed external call: " + function->getName(), "external.err");
		return;
	}

	if (!state.addressSpace.copyInConcretes()) {
		terminateStateOnError(state, "external modified read-only object",
				"external.err");
		return;
	}

	LLVM_TYPE_Q Type *resultType = target->inst->getType();
	if (resultType != Type::getVoidTy(getGlobalContext())) {
		ref<Expr> e = ConstantExpr::fromMemory((void*) args,
				getWidthForLLVMType(resultType));
		bindLocal(target, state, e);

		if (INTERPOLATION_ENABLED) {
			std::vector<ref<Expr> > tmpArgs;
			tmpArgs.push_back(e);
			for (unsigned i = 0; i < arguments.size(); ++i) {
				tmpArgs.push_back(arguments.at(i));
			}
			interpTree->execute(target->inst, tmpArgs);
		}
	}
}

/***/

ref<Expr> Executor::replaceReadWithSymbolic(ExecutionState &state,
		ref<Expr> e) {
	unsigned n = interpreterOpts.MakeConcreteSymbolic;
	if (!n || replayOut || replayPath)
		return e;

// right now, we don't replace symbolics (is there any reason to?)
	if (!isa < ConstantExpr > (e))
		return e;

	if (n != 1 && random() % n)
		return e;

// create a new fresh location, assert it is equal to concrete value in e
// and return it.

	static unsigned id;
	const std::string arrayName("rrws_arr" + llvm::utostr(++id));
	const unsigned arrayWidth(Expr::getMinBytesForWidth(e->getWidth()));
	const Array *array = arrayCache.CreateArray(arrayName, arrayWidth);
	ref<Expr> res = Expr::createTempRead(array, e->getWidth());
	ref<Expr> eq = NotOptimizedExpr::create(EqExpr::create(e, res));
	llvm::errs() << "Making symbolic: " << eq << "\n";
	state.addConstraint(eq);

	if (INTERPOLATION_ENABLED) {
		// We create shadow array as existentially-quantified
		// variables for subsumption checking
		const Array *shadow = arrayCache.CreateArray(
				ShadowArray::getShadowName(arrayName), arrayWidth);
		ShadowArray::addShadowArrayMap(array, shadow);
	}

	return res;
}

ObjectState *Executor::bindObjectInState(ExecutionState &state,
		const MemoryObject *mo, bool isLocal, const Array *array) {
	ObjectState *os = array ? new ObjectState(mo, array) : new ObjectState(mo);
	state.addressSpace.bindObject(mo, os);

// Its possible that multiple bindings of the same mo in the state
// will put multiple copies on this list, but it doesn't really
// matter because all we use this list for is to unbind the object
// on function return.
	if (isLocal)
		state.stack.back().allocas.push_back(mo);

	return os;
}

void Executor::executeAlloc(ExecutionState &state, ref<Expr> size, bool isLocal,
		KInstruction *target, bool zeroMemory, const ObjectState *reallocFrom) {
	size = toUnique(state, size);
	if (ConstantExpr *CE = dyn_cast < ConstantExpr > (size)) {
		MemoryObject *mo = memory->allocate(CE->getZExtValue(), isLocal, false,
				state.prevPC->inst);
		if (!mo) {
			bindLocal(target, state,
					ConstantExpr::alloc(0, Context::get().getPointerWidth()));
		} else {
			ObjectState *os = bindObjectInState(state, mo, isLocal);
			if (zeroMemory) {
				os->initializeToZero();
			} else {
				os->initializeToRandom();
			}
			bindLocal(target, state, mo->getBaseExpr());

			// Update dependency
			if (INTERPOLATION_ENABLED)
				interpTree->execute(target->inst, mo->getBaseExpr());

			if (reallocFrom) {
				unsigned count = std::min(reallocFrom->size, os->size);
				for (unsigned i = 0; i < count; i++)
					os->write(i, reallocFrom->read8(i));
				state.addressSpace.unbindObject(reallocFrom->getObject());
			}
		}
	} else {
		// XXX For now we just pick a size. Ideally we would support
		// symbolic sizes fully but even if we don't it would be better to
		// "smartly" pick a value, for example we could fork and pick the
		// min and max values and perhaps some intermediate (reasonable
		// value).
		//
		// It would also be nice to recognize the case when size has
		// exactly two values and just fork (but we need to get rid of
		// return argument first). This shows up in pcre when llvm
		// collapses the size expression with a select.

		ref<ConstantExpr> example;
		bool success = solver->getValue(state, size, example);
		assert(success && "FIXME: Unhandled solver failure");
		(void) success;

		// Try and start with a small example.
		Expr::Width W = example->getWidth();
		while (example->Ugt(ConstantExpr::alloc(128, W))->isTrue()) {
			ref<ConstantExpr> tmp = example->LShr(ConstantExpr::alloc(1, W));
			bool res;
			bool success = solver->mayBeTrue(state, EqExpr::create(tmp, size),
					res);
			assert(success && "FIXME: Unhandled solver failure");
			(void) success;
			if (!res)
				break;
			example = tmp;
		}

		StatePair fixedSize = fork(state, EqExpr::create(example, size), true);

		if (fixedSize.second) {
			// Check for exactly two values
			ref<ConstantExpr> tmp;
			bool success = solver->getValue(*fixedSize.second, size, tmp);
			assert(success && "FIXME: Unhandled solver failure");
			(void) success;
			bool res;
			success = solver->mustBeTrue(*fixedSize.second,
					EqExpr::create(tmp, size), res);
			assert(success && "FIXME: Unhandled solver failure");
			(void) success;
			if (res) {
				executeAlloc(*fixedSize.second, tmp, isLocal, target,
						zeroMemory, reallocFrom);
			} else {
				// See if a *really* big value is possible. If so assume
				// malloc will fail for it, so lets fork and return 0.
				StatePair hugeSize = fork(*fixedSize.second,
						UltExpr::create(ConstantExpr::alloc(1 << 31, W), size),
						true);
				if (hugeSize.first) {
					klee_message("NOTE: found huge malloc, returning 0");
					ref<Expr> result = ConstantExpr::alloc(0,
							Context::get().getPointerWidth());
					bindLocal(target, *hugeSize.first, result);

					// Update dependency
					if (INTERPOLATION_ENABLED)
						interpTree->execute(target->inst, result);
				}

				if (hugeSize.second) {

					std::string Str;
					llvm::raw_string_ostream info(Str);
					ExprPPrinter::printOne(info, "  size expr", size);
					info << "  concretization : " << example << "\n";
					info << "  unbound example: " << tmp << "\n";
					terminateStateOnError(*hugeSize.second,
							"concretized symbolic size", "model.err",
							info.str());
				}
			}
		}

		if (fixedSize.first) // can be zero when fork fails
			executeAlloc(*fixedSize.first, example, isLocal, target, zeroMemory,
					reallocFrom);
	}
}

void Executor::executeFree(ExecutionState &state, ref<Expr> address,
		KInstruction *target) {
	StatePair zeroPointer = fork(state, Expr::createIsZero(address), true);
	if (zeroPointer.first) {
		if (target)
			bindLocal(target, *zeroPointer.first, Expr::createPointer(0));
	}
	if (zeroPointer.second) { // address != 0
		ExactResolutionList rl;
		resolveExact(*zeroPointer.second, address, rl, "free");

		for (Executor::ExactResolutionList::iterator it = rl.begin(), ie =
				rl.end(); it != ie; ++it) {
			const MemoryObject *mo = it->first.first;
			if (mo->isLocal) {
				terminateStateOnError(*it->second, "free of alloca", "free.err",
						getAddressInfo(*it->second, address));
			} else if (mo->isGlobal) {
				terminateStateOnError(*it->second, "free of global", "free.err",
						getAddressInfo(*it->second, address));
			} else {
				it->second->addressSpace.unbindObject(mo);
				if (target)
					bindLocal(target, *it->second, Expr::createPointer(0));
			}
		}
	}
}

void Executor::resolveExact(ExecutionState &state, ref<Expr> p,
		ExactResolutionList &results, const std::string &name) {
// XXX we may want to be capping this?
	ResolutionList rl;
	state.addressSpace.resolve(state, solver, p, rl);

	ExecutionState *unbound = &state;
	for (ResolutionList::iterator it = rl.begin(), ie = rl.end(); it != ie;
			++it) {
		ref<Expr> inBounds = EqExpr::create(p, it->first->getBaseExpr());

		StatePair branches = fork(*unbound, inBounds, true);

		if (branches.first)
			results.push_back(std::make_pair(*it, branches.first));

		unbound = branches.second;
		if (!unbound) // Fork failure
			break;
	}

	if (unbound) {
		terminateStateOnError(*unbound,
				"memory error: invalid pointer: " + name, "ptr.err",
				getAddressInfo(*unbound, p));
	}
}

bool Executor::resolveOne(ExecutionState &state, ref<Expr> address,
		ObjectPair &op) {
// fast path: single in-bounds resolution
	bool success;
	solver->setTimeout(coreSolverTimeout);

	if (!state.addressSpace.resolveOne(state, solver, address, op, success)) {
		address = toConstant(state, address, "resolveOne failure");
		success = state.addressSpace.resolveOne(cast < ConstantExpr > (address),
				op);
	}
	solver->setTimeout(0);
	return success;
}

void Executor::executeMemoryOperation(ExecutionState &state, bool isWrite,
		ref<Expr> address, ref<Expr> value /* undef if read */,
		KInstruction *target /* undef if write */,
		TaintSet taintr /* undef if write */,
		TaintSet taintw /* undef if read */) {
	Expr::Width type = (
			isWrite ?
					value->getWidth() :
					getWidthForLLVMType(target->inst->getType()));
	unsigned bytes = Expr::getMinBytesForWidth(type);

	if (SimplifySymIndices) {
		if (!isa < ConstantExpr > (address))
			address = state.constraints.simplifyExpr(address);
		if (isWrite && !isa < ConstantExpr > (value))
			value = state.constraints.simplifyExpr(value);
	}

// fast path: single in-bounds resolution
	ObjectPair op;
	bool success;
	solver->setTimeout(coreSolverTimeout);
	if (!state.addressSpace.resolveOne(state, solver, address, op, success)) {
		address = toConstant(state, address, "resolveOne failure");
		success = state.addressSpace.resolveOne(cast < ConstantExpr > (address),
				op);
	}
	solver->setTimeout(0);

	if (success) {
		const MemoryObject *mo = op.first;

		if (MaxSymArraySize && mo->size >= MaxSymArraySize) {
			address = toConstant(state, address, "max-sym-array-size");
		}

		ref<Expr> offset = mo->getOffsetExpr(address);

		bool inBounds;
		solver->setTimeout(coreSolverTimeout);
		bool success = solver->mustBeTrue(state,
				mo->getBoundsCheckOffset(offset, bytes), inBounds);
		solver->setTimeout(0);
		if (!success) {
			state.pc = state.prevPC;
			terminateStateEarly(state, "Query timed out (bounds check).");
			return;
		}

		if (inBounds) {
			const ObjectState *os = op.second;
			if (isWrite) {
				if (os->readOnly) {
					terminateStateOnError(state,
							"memory error: object read only", "readonly.err");
				} else {
					ObjectState *wos = state.addressSpace.getWriteable(mo, os);
					wos->write(offset, value);

					if (interpreterOpts.TaintConfig.has(TaintConfig::Direct)) {
						unsigned offset_cnt;
						toConstant(state, offset,
								"write taint symbolic offset not impl")->toMemory(
								&offset_cnt);
						for (unsigned j = 0; j < type / 8; j++)
							wos->writeByteTaint(offset_cnt + j,
									taintw | taintr);
					}

					// Update dependency
					if (INTERPOLATION_ENABLED && target)
						interpTree->execute(target->inst, value, address);
				}
			} else {
				TaintSet taint = taintr | taintw;
				ref<Expr> result = os->read(offset, type);

				if (interpreterOpts.MakeConcreteSymbolic)
					result = replaceReadWithSymbolic(state, result);
				{
					if (interpreterOpts.TaintConfig.has(TaintConfig::Direct)) {
						unsigned offset_cnt;
						unsigned int bytes = type / 8;
						toConstant(state, offset,
								"read taint symbolic offset not impl")->toMemory(
								&offset_cnt);
						for (unsigned j = 0; j < bytes; j++)
							taint |= os->readByteTaint(offset_cnt + j);
					}
				}

				bindLocal(target, state, result, taint);

				// Update dependency
				if (INTERPOLATION_ENABLED && target)
					interpTree->execute(target->inst, result, address);
			}

			return;
		}
	}

// we are on an error path (no resolution, multiple resolution, one
// resolution with out of bounds)

	ResolutionList rl;
	solver->setTimeout(coreSolverTimeout);
	bool incomplete = state.addressSpace.resolve(state, solver, address, rl, 0,
			coreSolverTimeout);
	solver->setTimeout(0);

// XXX there is some query wasteage here. who cares?
	ExecutionState *unbound = &state;

	for (ResolutionList::iterator i = rl.begin(), ie = rl.end(); i != ie; ++i) {
		const MemoryObject *mo = i->first;
		const ObjectState *os = i->second;
		ref<Expr> inBounds = mo->getBoundsCheckPointer(address, bytes);

		StatePair branches = fork(*unbound, inBounds, true);
		ExecutionState *bound = branches.first;

		// bound can be 0 on failure or overlapped
		if (bound) {
			if (isWrite) {
				if (os->readOnly) {
					terminateStateOnError(*bound,
							"memory error: object read only", "readonly.err");
				} else {
					ObjectState *wos = bound->addressSpace.getWriteable(mo, os);
					ref<Expr> offset = mo->getOffsetExpr(address);
					wos->write(offset, value);
					if (interpreterOpts.TaintConfig.has(TaintConfig::Direct)) {
						unsigned offset_cnt;
						toConstant(state, offset,
								"write taint symbolic offset not impl")->toMemory(
								&offset_cnt);
						for (unsigned j = 0; j < type / 8; j++)
							wos->writeByteTaint(offset_cnt + j,
									taintw | taintr);
					}
				}
			} else {
				TaintSet taint = taintr | taintw;
				ref<Expr> offset = mo->getOffsetExpr(address);
				ref<Expr> result = os->read(offset, type);
				if (interpreterOpts.TaintConfig.has(TaintConfig::Direct)) {
					unsigned offset_cnt;
					unsigned int bytes = type / 8;
					toConstant(state, offset,
							"read taint symbolic offset not impl")->toMemory(
							&offset_cnt);
					for (unsigned j = 0; j < bytes; j++)
						taint |= os->readByteTaint(offset_cnt + j);
				}
				bindLocal(target, *bound, result, taint);
			}
		}

		unbound = branches.second;
		if (!unbound)
			break;
	}

// XXX should we distinguish out of bounds and overlapped cases?
	if (unbound) {
		if (incomplete) {
			terminateStateEarly(*unbound, "Query timed out (resolve).");
		} else {
			terminateStateOnError(*unbound,
					"memory error: out of bound pointer", "ptr.err",
					getAddressInfo(*unbound, address));
		}
	}
}

void Executor::executeMakeSymbolic(ExecutionState &state,
		const MemoryObject *mo, const std::string &name) {
// Create a new object state for the memory object (instead of a copy).
	if (!replayOut) {
		// Find a unique name for this array.  First try the original name,
		// or if that fails try adding a unique identifier.
		unsigned id = 0;
		std::string uniqueName = name;
		while (!state.arrayNames.insert(uniqueName).second) {
			uniqueName = name + "_" + llvm::utostr(++id);
		}
		const Array *array = arrayCache.CreateArray(uniqueName, mo->size);
		if (INTERPOLATION_ENABLED) {
			// We create shadow array as existentially-quantified
			// variables for subsumption checking
			const Array *shadow = arrayCache.CreateArray(
					ShadowArray::getShadowName(uniqueName), mo->size);
			ShadowArray::addShadowArrayMap(array, shadow);
		}

		bindObjectInState(state, mo, false, array);
		state.addSymbolic(mo, array);

		std::map<ExecutionState*, std::vector<SeedInfo> >::iterator it =
				seedMap.find(&state);
		if (it != seedMap.end()) { // In seed mode we need to add this as a
				// binding.
			for (std::vector<SeedInfo>::iterator siit = it->second.begin(),
					siie = it->second.end(); siit != siie; ++siit) {
				SeedInfo &si = *siit;
				KTestObject *obj = si.getNextInput(mo, NamedSeedMatching);

				if (!obj) {
					if (ZeroSeedExtension) {
						std::vector<unsigned char> &values =
								si.assignment.bindings[array];
						values = std::vector<unsigned char>(mo->size, '\0');
					} else if (!AllowSeedExtension) {
						terminateStateOnError(state,
								"ran out of inputs during seeding", "user.err");
						break;
					}
				} else {
					if (obj->numBytes != mo->size
							&& ((!(AllowSeedExtension || ZeroSeedExtension)
									&& obj->numBytes < mo->size)
									|| (!AllowSeedTruncation
											&& obj->numBytes > mo->size))) {
						std::stringstream msg;
						msg << "replace size mismatch: " << mo->name << "["
								<< mo->size << "]" << " vs " << obj->name << "["
								<< obj->numBytes << "]" << " in test\n";

						terminateStateOnError(state, msg.str(), "user.err");
						break;
					} else {
						std::vector<unsigned char> &values =
								si.assignment.bindings[array];
						values.insert(values.begin(), obj->bytes,
								obj->bytes + std::min(obj->numBytes, mo->size));
						if (ZeroSeedExtension) {
							for (unsigned i = obj->numBytes; i < mo->size; ++i)
								values.push_back('\0');
						}
					}
				}
			}
		}
	} else {
		ObjectState *os = bindObjectInState(state, mo, false);
		if (replayPosition >= replayOut->numObjects) {
			terminateStateOnError(state, "replay count mismatch", "user.err");
		} else {
			KTestObject *obj = &replayOut->objects[replayPosition++];
			if (obj->numBytes != mo->size) {
				terminateStateOnError(state, "replay size mismatch",
						"user.err");
			} else {
				for (unsigned i = 0; i < mo->size; i++)
					os->write8(i, obj->bytes[i]);
			}
		}
	}
}

/***/

void Executor::runFunctionAsMain(Function *f, int argc, char **argv,
		char **envp) {

	std::vector<ref<Expr> > arguments;

// force deterministic initialization of memory objects
	srand(1);
	srandom(1);

	MemoryObject *argvMO = 0;

// In order to make uclibc happy and be closer to what the system is
// doing we lay out the environments at the end of the argv array
// (both are terminated by a null). There is also a final terminating
// null that uclibc seems to expect, possibly the ELF header?

	int envc;
	for (envc = 0; envp[envc]; ++envc)
		;

	unsigned NumPtrBytes = Context::get().getPointerWidth() / 8;
	KFunction *kf = kmodule->functionMap[f];
	assert(kf);
	Function::arg_iterator ai = f->arg_begin(), ae = f->arg_end();
	if (ai != ae) {
		arguments.push_back(ConstantExpr::alloc(argc, Expr::Int32));

		if (++ai != ae) {
			argvMO = memory->allocate((argc + 1 + envc + 1 + 1) * NumPtrBytes,
					false, true, f->begin()->begin());

			arguments.push_back(argvMO->getBaseExpr());

			if (++ai != ae) {
				uint64_t envp_start = argvMO->address
						+ (argc + 1) * NumPtrBytes;
				arguments.push_back(Expr::createPointer(envp_start));

				if (++ai != ae)
					klee_error("invalid main function (expect 0-3 arguments)");
			}
		}
	}

	ExecutionState *state = new ExecutionState(kmodule->functionMap[f]);

	if (pathWriter)
		state->pathOS = pathWriter->open();
	if (symPathWriter)
		state->symPathOS = symPathWriter->open();

	if (statsTracker)
		statsTracker->framePushed(*state, 0);

	assert(arguments.size() == f->arg_size() && "wrong number of arguments");
	for (unsigned i = 0, e = f->arg_size(); i != e; ++i)
		bindArgument(kf, i, *state, arguments[i]);

	if (argvMO) {
		ObjectState *argvOS = bindObjectInState(*state, argvMO, false);

		for (int i = 0; i < argc + 1 + envc + 1 + 1; i++) {
			if (i == argc || i >= argc + 1 + envc) {
				// Write NULL pointer
				argvOS->write(i * NumPtrBytes, Expr::createPointer(0));
			} else {
				char *s = i < argc ? argv[i] : envp[i - (argc + 1)];
				int j, len = strlen(s);

				MemoryObject *arg = memory->allocate(len + 1, false, true,
						state->pc->inst);
				ObjectState *os = bindObjectInState(*state, arg, false);
				for (j = 0; j < len + 1; j++)
					os->write8(j, s[j]);

				// Write pointer to newly allocated and initialised argv/envp c-string
				argvOS->write(i * NumPtrBytes, arg->getBaseExpr());
			}
		}
	}

	initializeGlobals(*state);

	processTree = new PTree(state);
	state->ptreeNode = processTree->root;

	if (INTERPOLATION_ENABLED) {
		interpTree = new ITree(state);  //added by Felicia
		state->itreeNode = interpTree->root;
		SearchTree::initialize(interpTree->root);
	}

	run(*state);
	delete processTree;
	processTree = 0;

	if (INTERPOLATION_ENABLED) {
		SearchTree::save(interpreterHandler->getOutputFilename("tree.dot"));
		SearchTree::deallocate();

#ifdef SUPPORT_Z3
		// Print interpolation time statistics
		if (InterpolationStat)
			interpTree->dumpInterpolationStat();
#endif

		delete interpTree;
		interpTree = 0;
	}

// hack to clear memory objects
	delete memory;
	memory = new MemoryManager(NULL);

	globalObjects.clear();
	globalAddresses.clear();

	if (statsTracker)
		statsTracker->done();
}

unsigned Executor::getPathStreamID(const ExecutionState &state) {
	assert(pathWriter);
	return state.pathOS.getID();
}

unsigned Executor::getSymbolicPathStreamID(const ExecutionState &state) {
	assert(symPathWriter);
	return state.symPathOS.getID();
}

void Executor::getConstraintLog(const ExecutionState &state, std::string &res,
		Interpreter::LogType logFormat) {

	std::ostringstream info;

	switch (logFormat) {
	case STP: {
		Query query(state.constraints, ConstantExpr::alloc(0, Expr::Bool));
		char *log = solver->getConstraintLog(query);
		res = std::string(log);
		free(log);
	}
		break;

	case KQUERY: {
		std::string Str;
		llvm::raw_string_ostream info(Str);
		ExprPPrinter::printConstraints(info, state.constraints);
		res = info.str();
	}
		break;

	case SMTLIB2: {
		std::string Str;
		llvm::raw_string_ostream info(Str);
		ExprSMTLIBPrinter printer;
		printer.setOutput(info);
		Query query(state.constraints, ConstantExpr::alloc(0, Expr::Bool));
		printer.setQuery(query);
		printer.generateOutput();
		res = info.str();
	}
		break;

	default:
		klee_warning(
				"Executor::getConstraintLog() : Log format not supported!");
	}
}

bool Executor::getSymbolicSolution(const ExecutionState &state,
		std::vector<std::pair<std::string, std::vector<unsigned char> > > &res) {
	solver->setTimeout(coreSolverTimeout);

	ExecutionState tmp(state);

// Go through each byte in every test case and attempt to restrict
// it to the constraints contained in cexPreferences.  (Note:
// usually this means trying to make it an ASCII character (0-127)
// and therefore human readable. It is also possible to customize
// the preferred constraints.  See test/Features/PreferCex.c for
// an example) While this process can be very expensive, it can
// also make understanding individual test cases much easier.
	for (unsigned i = 0; i != state.symbolics.size(); ++i) {
		const MemoryObject *mo = state.symbolics[i].first;
		std::vector<ref<Expr> >::const_iterator pi = mo->cexPreferences.begin(),
				pie = mo->cexPreferences.end();
		for (; pi != pie; ++pi) {
			bool mustBeTrue;
			// Attempt to bound byte to constraints held in cexPreferences
			bool success = solver->mustBeTrue(tmp, Expr::createIsZero(*pi),
					mustBeTrue);
			// If it isn't possible to constrain this particular byte in the desired
			// way (normally this would mean that the byte can't be constrained to
			// be between 0 and 127 without making the entire constraint list UNSAT)
			// then just continue on to the next byte.
			if (!success)
				break;
			// If the particular constraint operated on in this iteration through
			// the loop isn't implied then add it to the list of constraints.
			if (!mustBeTrue)
				tmp.addConstraint(*pi);
		}
		if (pi != pie)
			break;
	}

	std::vector < std::vector<unsigned char> > values;
	std::vector<const Array*> objects;
	for (unsigned i = 0; i != state.symbolics.size(); ++i)
		objects.push_back(state.symbolics[i].second);
	bool success = solver->getInitialValues(tmp, objects, values);
	solver->setTimeout(0);
	if (!success) {
		klee_warning(
				"unable to compute initial values (invalid constraints?)!");
		ExprPPrinter::printQuery(llvm::errs(), state.constraints,
				ConstantExpr::alloc(0, Expr::Bool));
		return false;
	}

	for (unsigned i = 0; i != state.symbolics.size(); ++i)
		res.push_back(
				std::make_pair(state.symbolics[i].first->name, values[i]));
	return true;
}

void Executor::getCoveredLines(const ExecutionState &state,
		std::map<const std::string*, std::set<unsigned> > &res) {
	res = state.coveredLines;
}

void Executor::doImpliedValueConcretization(ExecutionState &state, ref<Expr> e,
		ref<ConstantExpr> value) {

	abort(); // FIXME: Broken until we sort out how to do the write back.

	if (DebugCheckForImpliedValues)
		ImpliedValue::checkForImpliedValues(solver->solver, e, value);

	ImpliedValueList results;
	ImpliedValue::getImpliedValues(e, value, results);
	for (ImpliedValueList::iterator it = results.begin(), ie = results.end();
			it != ie; ++it) {
		ReadExpr *re = it->first.get();

		if (ConstantExpr *CE = dyn_cast < ConstantExpr > (re->index)) {
			// FIXME: This is the sole remaining usage of the Array object
			// variable. Kill me.
			const MemoryObject *mo = 0; //re->updates.root->object;
			const ObjectState *os = state.addressSpace.findObject(mo);

			if (!os) {
				// object has been free'd, no need to concretize (although as
				// in other cases we would like to concretize the outstanding
				// reads, but we have no facility for that yet)
			} else {
				assert(
						!os->readOnly
								&& "not possible? read only object with static read?");
				ObjectState *wos = state.addressSpace.getWriteable(mo, os);
				wos->write(CE, it->second);
			}
		}
	}
}

Expr::Width Executor::getWidthForLLVMType(LLVM_TYPE_Q llvm::Type *type) const {
	return kmodule->targetData->getTypeSizeInBits(type);
}

///

Interpreter *Interpreter::create(const InterpreterOptions &opts,
		InterpreterHandler *ih) {
	return new Executor(opts, ih);
}
