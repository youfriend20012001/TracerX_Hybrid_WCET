//===-- Expr.h --------------------------------------------------*- C++ -*-===//
//
//                     The KLEE Symbolic Virtual Machine
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef KLEE_EXPR_H
#define KLEE_EXPR_H

#include "klee/util/Bits.h"
#include "klee/util/Ref.h"

#include "llvm/ADT/APInt.h"
#include "llvm/ADT/APFloat.h"
#include "llvm/ADT/DenseSet.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Support/raw_ostream.h"

#include <sstream>
#include <set>
#include <vector>
#include <map>


namespace llvm {
  class Type;
  class raw_ostream;
}

namespace klee {

class Array;
class ArrayCache;
class ConstantExpr;
class ObjectState;

template<class T> class ref;


/// Class representing symbolic expressions.
/**

<b>Expression canonicalization</b>: we define certain rules for
canonicalization rules for Exprs in order to simplify code that
pattern matches Exprs (since the number of forms are reduced), to open
up further chances for optimization, and to increase similarity for
caching and other purposes.

The general rules are:
<ol>
<li> No Expr has all constant arguments.</li>

<li> Booleans:
    <ol type="a">
     <li> \c Ne, \c Ugt, \c Uge, \c Sgt, \c Sge are not used </li>
     <li> The only acceptable operations with boolean arguments are 
          \c Not \c And, \c Or, \c Xor, \c Eq, 
	  as well as \c SExt, \c ZExt,
          \c Select and \c NotOptimized. </li>
     <li> The only boolean operation which may involve a constant is boolean not (<tt>== false</tt>). </li>
     </ol>
</li>

<li> Linear Formulas: 
   <ol type="a">
   <li> For any subtree representing a linear formula, a constant
   term must be on the LHS of the root node of the subtree.  In particular, 
   in a BinaryExpr a constant must always be on the LHS.  For example, subtraction 
   by a constant c is written as <tt>add(-c, ?)</tt>.  </li>
    </ol>
</li>


<li> Chains are unbalanced to the right </li>

</ol>


<b>Steps required for adding an expr</b>:
   -# Add case to printKind
   -# Add to ExprVisitor
   -# Add to IVC (implied value concretization) if possible

Todo: Shouldn't bool \c Xor just be written as not equal?

*/

class Expr {
public:
  static unsigned count;

  static const unsigned MAGIC_HASH_CONSTANT = 39;

  /// The type of an expression is simply its width, in bits. 
  typedef unsigned Width; 
  
  static const Width InvalidWidth = 0;
  static const Width Bool = 1;
  static const Width Int8 = 8;
  static const Width Int16 = 16;
  static const Width Int32 = 32;
  static const Width Int64 = 64;
  static const Width Fl80 = 80;
  
  enum TaintGranularLevel
  {
	  UnderTaint = 0,
	  NormalTaint = 2,
	  OverTaint = 4
  };

  static TaintGranularLevel tLevel;

  enum Kind {
    InvalidKind = -1,

    // Primitive

    Constant = 0,

    // Special

    /// Prevents optimization below the given expression.  Used for
    /// testing: make equality constraints that KLEE will not use to
    /// optimize to concretes.
    NotOptimized,

    //// Skip old varexpr, just for deserialization, purge at some point
    Read=NotOptimized+2, 
    Select,
    Concat,
    Extract,

    // Casting,
    ZExt,
    SExt,

    // All subsequent kinds are binary.

    // Arithmetic
    Add,
    Sub,
    Mul,
    UDiv,
    SDiv,
    URem,
    SRem,

    // Bit
    Not,
    And,
    Or,
    Xor,
    Shl,
    LShr,
    AShr,
    
    // Compare
    Eq,
    Ne,  ///< Not used in canonical form
    Ult,
    Ule,
    Ugt, ///< Not used in canonical form
    Uge, ///< Not used in canonical form
    Slt,
    Sle,
    Sgt, ///< Not used in canonical form
    Sge, ///< Not used in canonical form
    Exists,
    LastKind = Exists,
    CastKindFirst = ZExt,
    CastKindLast = SExt,
    BinaryKindFirst = Add,
    BinaryKindLast = Sge,
    CmpKindFirst = Eq,
    CmpKindLast = Sge
  };

  unsigned refCount;
protected:  
  unsigned hashValue;
  ref<Expr> *taintsDetails;

public:
  Expr() : refCount(0){ Expr::count++; taintsDetails = 0;}
  virtual ~Expr() { Expr::count--; } 

  virtual Kind getKind() const = 0;
  virtual Width getWidth() const = 0;
  
  virtual unsigned getNumKids() const = 0;
  virtual ref<Expr> getKid(unsigned i) const = 0;
    
  virtual void print(llvm::raw_ostream &os) const;


  /// dump - Print the expression to stderr.
  void dump() const;

  /// Returns the pre-computed hash of the current expression
  virtual unsigned hash() const { return hashValue; }

  /// (Re)computes the hash of the current expression.
  /// Returns the hash value. 
  virtual unsigned computeHash();
  
  /// Returns 0 iff b is structuraly equivalent to *this
  typedef llvm::DenseSet<std::pair<const Expr *, const Expr *> > ExprEquivSet;
  int compare(const Expr &b, ExprEquivSet &equivs) const;
  int compare(const Expr &b) const {
    static ExprEquivSet equivs;
    int r = compare(b, equivs);
    equivs.clear();
    return r;
  }

  virtual int compareContents(const Expr &b) const { return 0; }

  // Given an array of new kids return a copy of the expression
  // but using those children. 
  virtual ref<Expr> rebuild(ref<Expr> kids[/* getNumKids() */]) const = 0;

  //

  /// isZero - Is this a constant zero.
  bool isZero() const;
  
  /// isTrue - Is this the true expression.
  bool isTrue() const;

  /// isFalse - Is this the false expression.
  bool isFalse() const;

  /* Static utility methods */

  static void printKind(llvm::raw_ostream &os, Kind k);
  static void printWidth(llvm::raw_ostream &os, Expr::Width w);

  /// returns the smallest number of bytes in which the given width fits
  static inline unsigned getMinBytesForWidth(Width w) {
      return (w + 7) / 8;
  }

  /* Kind utilities */

  /* Utility creation functions */
  static ref<Expr> createSExtToPointerWidth(ref<Expr> e);
  static ref<Expr> createZExtToPointerWidth(ref<Expr> e);
  static ref<Expr> createImplies(ref<Expr> hyp, ref<Expr> conc);
  static ref<Expr> createIsZero(ref<Expr> e);

  /// Create a little endian read of the given type at offset 0 of the
  /// given object.
  static ref<Expr> createTempRead(const Array *array, Expr::Width w);
  
  static ref<ConstantExpr> createPointer(uint64_t v);

  struct CreateArg;
  static ref<Expr> createFromKind(Kind k, std::vector<CreateArg> args);

  static bool isValidKidWidth(unsigned kid, Width w) { return true; }
  static bool needsResultType() { return false; }

  static bool classof(const Expr *) { return true; }
  
  // Mark 'taint' value for bit at 'offset'
  void markTaint(unsigned offset, ref<Expr> taint){
	  initialTaint();
	  if(taint.isNull() || offset >= getWidth())
		  return;
	  taintsDetails[offset] = taint;
  }
  
  // Read taint value of bit at 'offset'
  virtual ref<Expr> readTaintDetails(unsigned offset){return 0;}
  
  // Initial no taint value for expression
  virtual void initialTaint() {};


protected:
  // Propagate tainted value
  virtual void propagateTaint() {};

  int extractTaintLevel(int i);
};

struct Expr::CreateArg {
  ref<Expr> expr;
  Width width;
  
  CreateArg(Width w = Bool) : expr(0), width(w) {}
  CreateArg(ref<Expr> e) : expr(e), width(Expr::InvalidWidth) {}
  
  bool isExpr() { return !isWidth(); }
  bool isWidth() { return width != Expr::InvalidWidth; }
};

// Comparison operators

inline bool operator==(const Expr &lhs, const Expr &rhs) {
  return lhs.compare(rhs) == 0;
}

inline bool operator<(const Expr &lhs, const Expr &rhs) {
  return lhs.compare(rhs) < 0;
}

inline bool operator!=(const Expr &lhs, const Expr &rhs) {
  return !(lhs == rhs);
}

inline bool operator>(const Expr &lhs, const Expr &rhs) {
  return rhs < lhs;
}

inline bool operator<=(const Expr &lhs, const Expr &rhs) {
  return !(lhs > rhs);
}

inline bool operator>=(const Expr &lhs, const Expr &rhs) {
  return !(lhs < rhs);
}

// Printing operators

inline llvm::raw_ostream &operator<<(llvm::raw_ostream &os, const Expr &e) {
  e.print(os);
  return os;
}

// XXX the following macro is to work around the ExprTest unit test compile error
#ifndef LLVM_29_UNITTEST
inline llvm::raw_ostream &operator<<(llvm::raw_ostream &os, const Expr::Kind kind) {
  Expr::printKind(os, kind);
  return os;
}
#endif

inline std::stringstream &operator<<(std::stringstream &os, const Expr &e) {
  std::string str;
  llvm::raw_string_ostream TmpStr(str);
  e.print(TmpStr);
  os << TmpStr.str();
  return os;
}

inline std::stringstream &operator<<(std::stringstream &os, const Expr::Kind kind) {
  std::string str;
  llvm::raw_string_ostream TmpStr(str);
  Expr::printKind(TmpStr, kind);
  os << TmpStr.str();
  return os;
}

// Terminal Exprs

class ConstantExpr : public Expr {
public:
  static const Kind kind = Constant;
  static const unsigned numKids = 0;
private:
  std::string taintName;
  llvm::APInt value;

  ConstantExpr(const llvm::APInt &v, bool isConsiderTaint = true) :taintName(""), value(v) {
	  if(isConsiderTaint){
		  initialTaint();
		  propagateTaint();
	  }
  }

protected:
  // Propagate tainted value
  // Default, no taint
  void propagateTaint(){
	  for (unsigned i = 0; i < getWidth(); i++){
		  markTaint(i, ConstantExpr::alloc(0, Expr::Int16, false));
	  }
  }


public:
  ~ConstantExpr() {}

  virtual void initialTaint(){
	  if(taintsDetails == 0){
		  taintsDetails = new ref<Expr>[getWidth()];
		  for(unsigned i = 0; i < getWidth(); i++){
			  taintsDetails[i] = ConstantExpr::alloc(0, Expr::Int16, false);
		  }
	  }
  }

  virtual ref<Expr> readTaintDetails(unsigned offset){
  	  if(taintsDetails == 0 || offset >= getWidth())
  		  return ConstantExpr::alloc(0, Expr::Int16, false);

  	  return taintsDetails[offset];
  }

  void setTaintName (std::string taintName){
	  this->taintName = taintName;
  }

  std::string getTaintName (){
	  return this->taintName;
  }

  Width getWidth() const { return value.getBitWidth(); }
  Kind getKind() const { return Constant; }

  unsigned getNumKids() const { return 0; }
  ref<Expr> getKid(unsigned i) const { return 0; }

  /// getAPValue - Return the arbitrary precision value directly.
  ///
  /// Clients should generally not use the APInt value directly and instead use
  /// native ConstantExpr APIs.
  const llvm::APInt &getAPValue() const { return value; }

  /// getZExtValue - Returns the constant value zero extended to the
  /// return type of this method.
  ///
  ///\param bits - optional parameter that can be used to check that the
  /// number of bits used by this constant is <= to the parameter
  /// value. This is useful for checking that type casts won't truncate
  /// useful bits.
  ///
  /// Example: unit8_t byte= (unit8_t) constant->getZExtValue(8);
  uint64_t getZExtValue(unsigned bits = 64) const {
    assert(getWidth() <= bits && "Value may be out of range!");
    return value.getZExtValue();
  }

  /// getLimitedValue - If this value is smaller than the specified limit,
  /// return it, otherwise return the limit value.
  uint64_t getLimitedValue(uint64_t Limit = ~0ULL) const {
    return value.getLimitedValue(Limit);
  }

  /// toString - Return the constant value as a string
  /// \param Res specifies the string for the result to be placed in
  /// \param radix specifies the base (e.g. 2,10,16). The default is base 10
  void toString(std::string &Res, unsigned radix = 10) const;

  int compareContents(const Expr &b) const {
    const ConstantExpr &cb = static_cast<const ConstantExpr &>(b);
    if (getWidth() != cb.getWidth())
      return getWidth() < cb.getWidth() ? -1 : 1;
    if (value == cb.value)
      return 0;
    return value.ult(cb.value) ? -1 : 1;
  }

  virtual ref<Expr> rebuild(ref<Expr> kids[]) const {
    assert(0 && "rebuild() on ConstantExpr");
    return const_cast<ConstantExpr *>(this);
  }

  virtual unsigned computeHash();

  static ref<Expr> fromMemory(void *address, Width w);
  void toMemory(void *address);

  static ref<ConstantExpr> alloc(const llvm::APInt &v, bool isConsiderTaint = true) {
    ref<ConstantExpr> r(new ConstantExpr(v, isConsiderTaint));
    r->computeHash();
    return r;
  }

  static ref<ConstantExpr> alloc(const llvm::APFloat &f, bool isConsiderTaint = true) {
    return alloc(f.bitcastToAPInt(),isConsiderTaint);
  }

  static ref<ConstantExpr> alloc(uint64_t v, Width w, bool isConsiderTaint = true) {
    return alloc(llvm::APInt(w, v), isConsiderTaint);
  }

  static ref<ConstantExpr> create(uint64_t v, Width w) {
    assert(v == bits64::truncateToNBits(v, w) && "invalid constant");
    return alloc(v, w);
  }

  static bool classof(const Expr *E) { return E->getKind() == Expr::Constant; }
  static bool classof(const ConstantExpr *) { return true; }

  /* Utility Functions */

  /// isZero - Is this a constant zero.
  bool isZero() const { return getAPValue().isMinValue(); }

  /// isOne - Is this a constant one.
  bool isOne() const { return getLimitedValue() == 1; }

  /// isTrue - Is this the true expression.
  bool isTrue() const {
    return (getWidth() == Expr::Bool && value.getBoolValue() == true);
  }

  /// isFalse - Is this the false expression.
  bool isFalse() const {
    return (getWidth() == Expr::Bool && value.getBoolValue() == false);
  }

  /// isAllOnes - Is this constant all ones.
  bool isAllOnes() const { return getAPValue().isAllOnesValue(); }

  /* Constant Operations */

  ref<ConstantExpr> Concat(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> Extract(unsigned offset, Width W);
  ref<ConstantExpr> ZExt(Width W);
  ref<ConstantExpr> SExt(Width W);
  ref<ConstantExpr> Add(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> Sub(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> Mul(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> UDiv(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> SDiv(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> URem(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> SRem(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> And(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> Or(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> Xor(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> Shl(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> LShr(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> AShr(const ref<ConstantExpr> &RHS);

  // Comparisons return a constant expression of width 1.

  ref<ConstantExpr> Eq(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> Ne(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> Ult(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> Ule(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> Ugt(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> Uge(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> Slt(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> Sle(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> Sgt(const ref<ConstantExpr> &RHS);
  ref<ConstantExpr> Sge(const ref<ConstantExpr> &RHS);

  ref<ConstantExpr> Neg();
  ref<ConstantExpr> Not();
};

  
// Utility classes

class NonConstantExpr : public Expr {
public:
  static bool classof(const Expr *E) {
    return E->getKind() != Expr::Constant;
  }
  static bool classof(const NonConstantExpr *) { return true; }

protected:
  // Propagate tainted value
  virtual void propagateTaint() {};
public:

  virtual void initialTaint(){
	  if(taintsDetails == 0){
		  taintsDetails = new ref<Expr>[getWidth()];
		  for(unsigned i = 0; i < getWidth(); i++){
			  taintsDetails[i] = ConstantExpr::alloc(0, Expr::Int16,false);
		  }
	  }
  }

  virtual ref<Expr> readTaintDetails(unsigned offset){
    	  if(taintsDetails == 0 || offset >= getWidth())
    		  return ConstantExpr::alloc(0, Expr::Int16, false);
    	  return taintsDetails[offset];
  }
};

class BinaryExpr : public NonConstantExpr {
public:
  ref<Expr> left, right;

public:
  unsigned getNumKids() const { return 2; }
  ref<Expr> getKid(unsigned i) const { 
    if(i == 0)
      return left;
    if(i == 1)
      return right;
    return 0;
  }
 
protected:
  BinaryExpr(const ref<Expr> &l, const ref<Expr> &r) : left(l), right(r) {}

  // Extract bits of n to arrays of bit, for Bitwise operator
  int *extract_bits(long n, int bitswanted){
    int *bits = (int*)malloc(sizeof(int) * bitswanted);
    int k;
    for(k=0; k<bitswanted; k++){
      int mask =  1 << k;
      int masked_n = n & mask;
      int thebit = masked_n >> k;
      bits[k] = thebit;
    }
    return bits;
  }

  int preCalculatePosition(int index){
	  //return index;
	  return getWidth() - 8 * ( index / 8 + 1) + (index % 8);
	  //return 8 * ( index / 8 + 1) - (index % 8) + 1;
  }

public:
  static bool classof(const Expr *E) {
    Kind k = E->getKind();
    return Expr::BinaryKindFirst <= k && k <= Expr::BinaryKindLast;
  }
  static bool classof(const BinaryExpr *) { return true; }

};

class CmpExpr : public BinaryExpr {

protected:
  CmpExpr(ref<Expr> l, ref<Expr> r) : BinaryExpr(l,r) {
	  initialTaint();
	  propagateTaint();
  }
  
  // Propagate tainted value
  // Tainted value will not be propagated via Compare Expression
  void propagateTaint(){
	  for (unsigned i = 0; i < getWidth(); i++){
	  		  markTaint(i, ConstantExpr::alloc(0, Expr::Int16, false));
	  }

	  // Tainted propagating between children
	  /*for(unsigned i = 0; i < left.get()->getWidth(); i++){
		  ref<Expr> taintedValueLeft = left.get()->readTaintDetails(i);
		  ref<Expr> taintedValueRight = right.get()->readTaintDetails(i);


	  }*/
  };


public:                                                       
  Width getWidth() const { return Bool; }

  static bool classof(const Expr *E) {
    Kind k = E->getKind();
    return Expr::CmpKindFirst <= k && k <= Expr::CmpKindLast;
  }
  static bool classof(const CmpExpr *) { return true; }
};



class ExistsExpr : public NonConstantExpr {
public:
  std::set<const Array *> variables;
  ref<Expr> body;

  static ref<Expr> alloc(std::set<const Array *> variables, ref<Expr> body) {
    ref<Expr> r(new ExistsExpr(variables, body));
    r->computeHash();
    return r;
  }

  static ref<Expr> create(std::set<const Array *> variables, ref<Expr> body);

  Width getWidth() const { return Bool; }

  Kind getKind() const { return Exists; }

  unsigned getNumKids() const { return 1; }

  ref<Expr> getKid(unsigned i) const {
    assert(i == 0);
    return body;
  }

  ref<Expr> rebuild(ref<Expr> kids[]) const {
    return create(variables, kids[0]);
  }

  unsigned computeHash();

  static bool classof(const Expr *E) { return E->getKind() == Expr::Exists; }

  static bool classof(const ExistsExpr *E) { return true; }
protected:
  // Propagate tainted value
  // Tainted value will not be propagated via Exists Expression
  void propagateTaint(){
	  for (unsigned i = 0; i < getWidth(); i++){
		  markTaint(i, ConstantExpr::alloc(0, Expr::Int16, false));
	  }
  };
private:
  ExistsExpr(std::set<const Array *> variables, ref<Expr> body)
      : variables(variables), body(body) {}
};

// Special
class NotOptimizedExpr : public NonConstantExpr {

protected:
  // Propagate tainted value
  // Default, inherit tainted value from source
  void propagateTaint(){
	  for (unsigned i = 0; i < getWidth(); i++)
	  {
		  markTaint(i, src.get()->readTaintDetails(i));
	  }
   }
public:
  static const Kind kind = NotOptimized;
  static const unsigned numKids = 1;
  ref<Expr> src;

  static ref<Expr> alloc(const ref<Expr> &src) {
    ref<Expr> r(new NotOptimizedExpr(src));
    r->computeHash();
    return r;
  }
  
  static ref<Expr> create(ref<Expr> src);
  
  Width getWidth() const { return src->getWidth(); }
  Kind getKind() const { return NotOptimized; }



  unsigned getNumKids() const { return 1; }
  ref<Expr> getKid(unsigned i) const { return src; }

  virtual ref<Expr> rebuild(ref<Expr> kids[]) const { return create(kids[0]); }

private:
  NotOptimizedExpr(const ref<Expr> &_src) : src(_src){
	  initialTaint();
	  propagateTaint();
  }

public:
  static bool classof(const Expr *E) {
    return E->getKind() == Expr::NotOptimized;
  }
  static bool classof(const NotOptimizedExpr *) { return true; }
};

/// Class representing a byte update of an array.
class UpdateNode {
  friend class UpdateList;  

  mutable unsigned refCount;
  // cache instead of recalc
  unsigned hashValue;

public:
  const UpdateNode *next;
  ref<Expr> index, value;
  
private:
  /// size of this update sequence, including this update
  unsigned size;
  
public:
  UpdateNode(const UpdateNode *_next, 
             const ref<Expr> &_index, 
             const ref<Expr> &_value);

  unsigned getSize() const { return size; }

  int compare(const UpdateNode &b) const;  
  unsigned hash() const { return hashValue; }

private:
  UpdateNode() : refCount(0) {}
  ~UpdateNode();

  unsigned computeHash();
};

class Array {
public:
  // Name of the array
  const std::string name;

  // FIXME: Not 64-bit clean.
  const unsigned size;

  /// Domain is how many bits can be used to access the array [32 bits]
  /// Range is the size (in bits) of the number stored there (array of bytes -> 8)
  const Expr::Width domain, range;

  /// constantValues - The constant initial values for this array, or empty for
  /// a symbolic array. If non-empty, this size of this array is equivalent to
  /// the array size.
  const std::vector<ref<ConstantExpr> > constantValues;

private:
  unsigned hashValue;

  // FIXME: Make =delete when we switch to C++11
  Array(const Array& array);

  // FIXME: Make =delete when we switch to C++11
  Array& operator =(const Array& array);

  ~Array();

  /// Array - Construct a new array object.
  ///
  /// \param _name - The name for this array. Names should generally be unique
  /// across an application, but this is not necessary for correctness, except
  /// when printing expressions. When expressions are printed the output will
  /// not parse correctly since two arrays with the same name cannot be
  /// distinguished once printed.
  Array(const std::string &_name, uint64_t _size,
	const ref<ConstantExpr> *constantValuesBegin = 0,
	const ref<ConstantExpr> *constantValuesEnd = 0,
	Expr::Width _domain = Expr::Int32, Expr::Width _range = Expr::Int8)
    : name(_name), size(_size), domain(_domain), range(_range),
      constantValues(constantValuesBegin, constantValuesEnd) {
    
    assert((isSymbolicArray() || constantValues.size() == size) &&
           "Invalid size for constant array!");
    computeHash();
#ifndef NDEBUG
    for (const ref<ConstantExpr> *it = constantValuesBegin;
         it != constantValuesEnd; ++it)
      assert((*it)->getWidth() == getRange() &&
             "Invalid initial constant value!");
#endif //NDEBUG
  }

public:
  bool isSymbolicArray() const { return constantValues.empty(); }
  bool isConstantArray() const { return !isSymbolicArray(); }

  const std::string getName() const { return name; }
  unsigned getSize() const { return size; }
  Expr::Width getDomain() const { return domain; }
  Expr::Width getRange() const { return range; }

  /// ComputeHash must take into account the name, the size, the domain, and the range
  unsigned computeHash();
  unsigned hash() const { return hashValue; }
  friend class ArrayCache;
};

/// Class representing a complete list of updates into an array.
class UpdateList { 
  friend class ReadExpr; // for default constructor

public:
  const Array *root;
  
  /// pointer to the most recent update node
  const UpdateNode *head;
  
public:
  UpdateList(const Array *_root, const UpdateNode *_head);
  UpdateList(const UpdateList &b);
  ~UpdateList();
  
  UpdateList &operator=(const UpdateList &b);

  /// size of this update list
  unsigned getSize() const { return (head ? head->getSize() : 0); }
  
  void extend(const ref<Expr> &index, const ref<Expr> &value);

  int compare(const UpdateList &b) const;
  unsigned hash() const;
private:
  void tryFreeNodes();
};

/// Class representing a one byte read from an array. 
class ReadExpr : public NonConstantExpr {
public:
  static const Kind kind = Read;
  static const unsigned numKids = 1;
  
public:
  UpdateList updates;
  ref<Expr> index;

public:
  static ref<Expr> alloc(const UpdateList &updates, const ref<Expr> &index) {
    ref<Expr> r(new ReadExpr(updates, index));
    r->computeHash();
    return r;
  }
  
  static ref<Expr> create(const UpdateList &updates, ref<Expr> i);
  
  Width getWidth() const { assert(updates.root); return updates.root->getRange(); }
  Kind getKind() const { return Read; }
  
  unsigned getNumKids() const { return numKids; }
  ref<Expr> getKid(unsigned i) const { return !i ? index : 0; }
  
  int compareContents(const Expr &b) const;

  virtual ref<Expr> rebuild(ref<Expr> kids[]) const {
    return create(updates, kids[0]);
  }

  virtual unsigned computeHash();

protected:
  // Propagate tainted value
  // Default, clean tainted value, special case. Tainted value will be propagated later at ObjectState::prepareRead within Memory.cpp
  void propagateTaint(){
	for (unsigned i = 0; i < getWidth(); i++)
	{
		markTaint(i, ConstantExpr::alloc(0,Expr::Int16,false));
	}
  }
private:
  ReadExpr(const UpdateList &_updates, const ref<Expr> &_index) : 
    updates(_updates), index(_index) {
	  assert(updates.root);
	  initialTaint();
	  propagateTaint();
  }

public:
  static bool classof(const Expr *E) {
    return E->getKind() == Expr::Read;
  }
  static bool classof(const ReadExpr *) { return true; }
};


/// Class representing an if-then-else expression.
class SelectExpr : public NonConstantExpr {
public:
  static const Kind kind = Select;
  static const unsigned numKids = 3;
  
public:
  ref<Expr> cond, trueExpr, falseExpr;

public:
  static ref<Expr> alloc(const ref<Expr> &c, const ref<Expr> &t, 
                         const ref<Expr> &f) {
    ref<Expr> r(new SelectExpr(c, t, f));
    r->computeHash();
    return r;
  }
  
  static ref<Expr> create(ref<Expr> c, ref<Expr> t, ref<Expr> f);

  Width getWidth() const { return trueExpr->getWidth(); }
  Kind getKind() const { return Select; }

  unsigned getNumKids() const { return numKids; }
  ref<Expr> getKid(unsigned i) const { 
        switch(i) {
        case 0: return cond;
        case 1: return trueExpr;
        case 2: return falseExpr;
        default: return 0;
        }
   }

  static bool isValidKidWidth(unsigned kid, Width w) {
    if (kid == 0)
      return w == Bool;
    else
      return true;
  }
    
  virtual ref<Expr> rebuild(ref<Expr> kids[]) const { 
    return create(kids[0], kids[1], kids[2]);
  }

protected:
  // Propagate tainted value
  // Default, clean tainted value. For its kids, they have their own tainted value.
  void propagateTaint(){
	for (unsigned i = 0; i < getWidth(); i++)
	{
		markTaint(i, ConstantExpr::alloc(0,Expr::Int16, false));
	}
  }
private:
  SelectExpr(const ref<Expr> &c, const ref<Expr> &t, const ref<Expr> &f) 
    : cond(c), trueExpr(t), falseExpr(f) {
	  initialTaint();
	  propagateTaint();
  }

public:
  static bool classof(const Expr *E) {
    return E->getKind() == Expr::Select;
  }
  static bool classof(const SelectExpr *) { return true; }
};


/** Children of a concat expression can have arbitrary widths.  
    Kid 0 is the left kid, kid 1 is the right kid.
*/
class ConcatExpr : public NonConstantExpr { 
public: 
  static const Kind kind = Concat;
  static const unsigned numKids = 2;

private:
  Width width;
  ref<Expr> left, right;  

public:
  static ref<Expr> alloc(const ref<Expr> &l, const ref<Expr> &r) {
    ref<Expr> c(new ConcatExpr(l, r));
    c->computeHash();
    return c;
  }
  
  static ref<Expr> create(const ref<Expr> &l, const ref<Expr> &r);

  Width getWidth() const { return width; }
  Kind getKind() const { return kind; }
  ref<Expr> getLeft() const { return left; }
  ref<Expr> getRight() const { return right; }

  unsigned getNumKids() const { return numKids; }
  ref<Expr> getKid(unsigned i) const { 
    if (i == 0) return left; 
    else if (i == 1) return right;
    else return NULL;
  }

  /// Shortcuts to create larger concats.  The chain returned is unbalanced to the right
  static ref<Expr> createN(unsigned nKids, const ref<Expr> kids[]);
  static ref<Expr> create4(const ref<Expr> &kid1, const ref<Expr> &kid2,
			   const ref<Expr> &kid3, const ref<Expr> &kid4);
  static ref<Expr> create8(const ref<Expr> &kid1, const ref<Expr> &kid2,
			   const ref<Expr> &kid3, const ref<Expr> &kid4,
			   const ref<Expr> &kid5, const ref<Expr> &kid6,
			   const ref<Expr> &kid7, const ref<Expr> &kid8);
  
  virtual ref<Expr> rebuild(ref<Expr> kids[]) const { return create(kids[0], kids[1]); }
  
protected:
  // Propagate tainted value
  // Default, combine tainted value from both left and right expression. Kid 0 is the left kid....
  void propagateTaint(){
	  for (unsigned i = 0; i < getWidth(); i++)
	  {
		  if(i < left.get()->getWidth())
			  markTaint(i, left.get()->readTaintDetails(i));
		  else markTaint(i, right.get()->readTaintDetails(i - left.get()->getWidth()));
	  }
  }

private:
  ConcatExpr(const ref<Expr> &l, const ref<Expr> &r) : left(l), right(r) {
    width = l->getWidth() + r->getWidth();
    initialTaint();
    propagateTaint();
  }

public:
  static bool classof(const Expr *E) {
    return E->getKind() == Expr::Concat;
  }
  static bool classof(const ConcatExpr *) { return true; }
};


/** This class represents an extract from expression {\tt expr}, at
    bit offset {\tt offset} of width {\tt width}.  Bit 0 is the right most 
    bit of the expression.
 */
class ExtractExpr : public NonConstantExpr { 
public:
  static const Kind kind = Extract;
  static const unsigned numKids = 1;
  
public:
  ref<Expr> expr;
  unsigned offset;
  Width width;

public:  
  static ref<Expr> alloc(const ref<Expr> &e, unsigned o, Width w, bool isConsiderTaint = true) {
    ref<Expr> r(new ExtractExpr(e, o, w, isConsiderTaint));
    r->computeHash();
    return r;
  }
  
  /// Creates an ExtractExpr with the given bit offset and width
  static ref<Expr> create(ref<Expr> e, unsigned bitOff, Width w);

  Width getWidth() const { return width; }
  Kind getKind() const { return Extract; }

  unsigned getNumKids() const { return numKids; }
  ref<Expr> getKid(unsigned i) const { return expr; }

  int compareContents(const Expr &b) const {
    const ExtractExpr &eb = static_cast<const ExtractExpr&>(b);
    if (offset != eb.offset) return offset < eb.offset ? -1 : 1;
    if (width != eb.width) return width < eb.width ? -1 : 1;
    return 0;
  }

  virtual ref<Expr> rebuild(ref<Expr> kids[]) const { 
    return create(kids[0], offset, width);
  }

  virtual unsigned computeHash();

protected:
  // Propagate tainted value
  // Default, extract tainted value from offset and width
  // Need review : assume that result of this expression will keep the original expression's direction
  void propagateTaint(){
	  for (unsigned i = 0; i < getWidth(); i++)
	  {
		  //markTaint(i, expr.get()->readTaintDetails(offset + getWidth() - i - 1));
		  markTaint(i, expr.get()->readTaintDetails(offset + i));
	  }
  }


private:
  ExtractExpr(const ref<Expr> &e, unsigned b, Width w, bool isConsiderTaint = true)
    : expr(e),offset(b),width(w) {
	  if(isConsiderTaint){
	  		  initialTaint();
	  		  propagateTaint();
	  	  }

  }

public:
  static bool classof(const Expr *E) {
    return E->getKind() == Expr::Extract;
  }
  static bool classof(const ExtractExpr *) { return true; }
};


/** 
    Bitwise Not 
*/
class NotExpr : public NonConstantExpr { 
public:
  static const Kind kind = Not;
  static const unsigned numKids = 1;
  
  ref<Expr> expr;

public:  
  static ref<Expr> alloc(const ref<Expr> &e, bool isConsiderTaint = true) {
    ref<Expr> r(new NotExpr(e, isConsiderTaint));
    r->computeHash();
    return r;
  }
  
  static ref<Expr> create(const ref<Expr> &e);

  Width getWidth() const { return expr->getWidth(); }
  Kind getKind() const { return Not; }

  unsigned getNumKids() const { return numKids; }
  ref<Expr> getKid(unsigned i) const { return expr; }

  int compareContents(const Expr &b) const {
    const NotExpr &eb = static_cast<const NotExpr&>(b);
    if (expr != eb.expr) return expr < eb.expr ? -1 : 1;
    return 0;
  }

  virtual ref<Expr> rebuild(ref<Expr> kids[]) const { 
    return create(kids[0]);
  }

  virtual unsigned computeHash();

protected:
  // Propagate tainted value
  // Default, apply Not to expr's tainted value
  // Need review
  void propagateTaint(){
 	  for (unsigned i = 0; i < getWidth(); i++){
 		  markTaint(i, NotExpr::alloc(expr->readTaintDetails(i), false));
 	  }
  }

public:
  static bool classof(const Expr *E) {
    return E->getKind() == Expr::Not;
  }
  static bool classof(const NotExpr *) { return true; }

private:
  NotExpr(const ref<Expr> &e, bool isConsiderTaint = true) : expr(e) {
	  if(isConsiderTaint){
		  initialTaint();
		  propagateTaint();
	  }

  }
};



// Casting

class CastExpr : public NonConstantExpr {
public:
  ref<Expr> src;
  Width width;

public:
  CastExpr(const ref<Expr> &e, Width w) : src(e), width(w) {
	  initialTaint();
	  propagateTaint();
  }

  Width getWidth() const { return width; }

  unsigned getNumKids() const { return 1; }
  ref<Expr> getKid(unsigned i) const { return (i==0) ? src : 0; }
  
  static bool needsResultType() { return true; }
  
  int compareContents(const Expr &b) const {
    const CastExpr &eb = static_cast<const CastExpr&>(b);
    if (width != eb.width) return width < eb.width ? -1 : 1;
    return 0;
  }

  virtual unsigned computeHash();

  static bool classof(const Expr *E) {
    Expr::Kind k = E->getKind();
    return Expr::CastKindFirst <= k && k <= Expr::CastKindLast;
  }
  static bool classof(const CastExpr *) { return true; }

protected:
  // Propagate tainted value
  // Default, extract from source's tainted value
  // Need review
  void propagateTaint(){
	  for (unsigned i = 0; i < getWidth(); i++)
	  {
		  if(i < src.get()->getWidth())
		  {
			  markTaint(i, src.get()->readTaintDetails(i));
		  }
		  else markTaint(i, ConstantExpr::alloc(0,Expr::Int16, false));

	  }
  }
};

#define CAST_EXPR_CLASS(_class_kind)                             \
class _class_kind ## Expr : public CastExpr {                    \
public:                                                          \
  static const Kind kind = _class_kind;                          \
  static const unsigned numKids = 1;                             \
public:                                                          \
    _class_kind ## Expr(ref<Expr> e, Width w) : CastExpr(e,w) {} \
    static ref<Expr> alloc(const ref<Expr> &e, Width w) {        \
      ref<Expr> r(new _class_kind ## Expr(e, w));                \
      r->computeHash();                                          \
      return r;                                                  \
    }                                                            \
    static ref<Expr> create(const ref<Expr> &e, Width w);        \
    Kind getKind() const { return _class_kind; }                 \
    virtual ref<Expr> rebuild(ref<Expr> kids[]) const {          \
      return create(kids[0], width);                             \
    }                                                            \
                                                                 \
    static bool classof(const Expr *E) {                         \
      return E->getKind() == Expr::_class_kind;                  \
    }                                                            \
    static bool classof(const  _class_kind ## Expr *) {          \
      return true;                                               \
    }                                                            \
};                                                               \

CAST_EXPR_CLASS(SExt)
CAST_EXPR_CLASS(ZExt)

// Comparison Exprs

#define COMPARISON_EXPR_CLASS(_class_kind)                           \
class _class_kind ## Expr : public CmpExpr {                         \
public:                                                              \
  static const Kind kind = _class_kind;                              \
  static const unsigned numKids = 2;                                 \
public:                                                              \
    _class_kind ## Expr(const ref<Expr> &l,                          \
                        const ref<Expr> &r) : CmpExpr(l,r) {}        \
    static ref<Expr> alloc(const ref<Expr> &l, const ref<Expr> &r) { \
      ref<Expr> res(new _class_kind ## Expr (l, r));                 \
      res->computeHash();                                            \
      return res;                                                    \
    }                                                                \
    static ref<Expr> create(const ref<Expr> &l, const ref<Expr> &r); \
    Kind getKind() const { return _class_kind; }                     \
    virtual ref<Expr> rebuild(ref<Expr> kids[]) const {              \
      return create(kids[0], kids[1]);                               \
    }                                                                \
                                                                     \
    static bool classof(const Expr *E) {                             \
      return E->getKind() == Expr::_class_kind;                      \
    }                                                                \
    static bool classof(const  _class_kind ## Expr *) {              \
      return true;                                                   \
    }                                                                \
};                                                                   \

COMPARISON_EXPR_CLASS(Eq)
COMPARISON_EXPR_CLASS(Ne)
COMPARISON_EXPR_CLASS(Ult)
COMPARISON_EXPR_CLASS(Ule)
COMPARISON_EXPR_CLASS(Ugt)
COMPARISON_EXPR_CLASS(Uge)
COMPARISON_EXPR_CLASS(Slt)
COMPARISON_EXPR_CLASS(Sle)
COMPARISON_EXPR_CLASS(Sgt)
COMPARISON_EXPR_CLASS(Sge)




// Arithmetic/Bit Exprs
class AddExpr : public BinaryExpr {
public:
  static const Kind kind = Expr::Add;
  static const unsigned numKids = 2;
public:
    AddExpr(const ref<Expr> &l,
                        const ref<Expr> &r, bool isConsiderTaint = true) : BinaryExpr(l,r) {
    	if(isConsiderTaint){
    			  initialTaint();
    			  propagateTaint();
    		  }
    }
    static ref<Expr> alloc(const ref<Expr> &l, const ref<Expr> &r, bool isConsiderTaint = true) {
      ref<Expr> res(new AddExpr (l, r, isConsiderTaint));
      res->computeHash();
      return res;
    }
    static ref<Expr> create(const ref<Expr> &l, const ref<Expr> &r);


    Width getWidth() const { return left->getWidth(); }
    Kind getKind() const { return Expr::Add; }
    virtual ref<Expr> rebuild(ref<Expr> kids[]) const {
      return create(kids[0], kids[1]);
    }

    static bool classof(const Expr *E) {
      return E->getKind() == Expr::Add;
    }
    static bool classof(const  AddExpr *) {
      return true;
    }
protected:
    void propagateTaint()
    {
    	if(left.get()->getKind() == Expr::Constant){
			  if(right.get()->getKind() == Expr::Constant){
				  for (unsigned i = 0; i < getWidth(); i++)
					markTaint(i, ConstantExpr::alloc(0,Expr::Int16,false));
			  }
			  else{
				klee::ConstantExpr * leftConst = dyn_cast<klee::ConstantExpr>(left);
				long leftValue = leftConst->getZExtValue();
				int *bits = extract_bits(leftValue, sizeof(leftValue)*8);
				propagateTaintAdd(bits,sizeof(leftValue)*8, right);
			  }
		}
	   else {
		  if(right.get()->getKind() == Expr::Constant){
				klee::ConstantExpr * rightConst = dyn_cast<klee::ConstantExpr>(right);
				long rightValue = rightConst->getZExtValue();
				int *bits = extract_bits(rightValue, sizeof(rightValue)*8);
				propagateTaintAdd(bits,sizeof(rightValue)*8, left);
		  }
		  else {
		  for (unsigned i = 0; i < getWidth(); i++)
			  markTaint(i, ExtractExpr::alloc(this,i,1,false));
		  }
	   }
    }

    void propagateTaintAdd(int *bits, unsigned int length, ref<Expr> nonConstantExpr){
    	bool mayCarry = false;
    	for (unsigned i = 0; i < getWidth(); i++){
    		//Need Review
			//unsigned idx = Expr::IsLittleIndian ? i : (getWidth() - i - 1);
			unsigned idx = nonConstantExpr.get()->getKind() == Expr::Concat ? preCalculatePosition(i) : i;

    		if(i < length){
				 if(bits[i] == 0){
					 if(mayCarry){
						 markTaint(i , determineTaintValue(i, nonConstantExpr));
						 mayCarry = true;
					 }
					 else{
						 markTaint(i, nonConstantExpr.get()->readTaintDetails(idx));
						 // For better explanation
						 mayCarry = false;
					 }
				 }
				 else {
					 markTaint(i, determineTaintValue(i, nonConstantExpr));
					 mayCarry = true;
				 }
    		}
			else markTaint(i, nonConstantExpr.get()->readTaintDetails(idx));
		 }
	}

    ref<Expr> determineTaintValue(int index, ref<Expr> source){
    	unsigned idx = preCalculatePosition(index);
    	std::vector<ref<Expr> > kids;

    	switch(Expr::tLevel){
			case Expr::NormalTaint:
				return ExtractExpr::alloc(this,index,1,false);
				break;
			case Expr::UnderTaint:
				return source.get()->readTaintDetails(idx);
				break;
			case Expr::OverTaint:
				for (int i = index; i >= 0; i--) {
					idx = source.get()->getKind() == Expr::Concat ? preCalculatePosition(i) : i;
					kids.push_back(source.get()->readTaintDetails(idx));
				}
				return ConcatExpr::createN(kids.size(), kids.data());
				break;
			default:
				return 0;
    	}
	}
};


class SubExpr : public BinaryExpr {
public:
  static const Kind kind = Expr::Sub;
  static const unsigned numKids = 2;
public:
  SubExpr(const ref<Expr> &l,
                        const ref<Expr> &r, bool isConsiderTaint = true) : BinaryExpr(l,r) {
	  if(isConsiderTaint){
	  		  initialTaint();
	  		  propagateTaint();
	  	  }

    }
    static ref<Expr> alloc(const ref<Expr> &l, const ref<Expr> &r, bool isConsiderTaint = true) {
      ref<Expr> res(new SubExpr (l, r, isConsiderTaint));
      res->computeHash();
      return res;
    }
    static ref<Expr> create(const ref<Expr> &l, const ref<Expr> &r);


    Width getWidth() const { return left->getWidth(); }
    Kind getKind() const { return Expr::Sub; }
    virtual ref<Expr> rebuild(ref<Expr> kids[]) const {
      return create(kids[0], kids[1]);
    }

    static bool classof(const Expr *E) {
      return E->getKind() == Expr::Sub;
    }
    static bool classof(const  SubExpr *) {
      return true;
    }
protected:
    void propagateTaint()
        {
        	if(left.get()->getKind() == Expr::Constant){
    			  if(right.get()->getKind() == Expr::Constant){
    				  for (unsigned i = 0; i < getWidth(); i++)
    					markTaint(i, ConstantExpr::alloc(0,Expr::Int16,false));
    			  }
    			  else{
    				klee::ConstantExpr * leftConst = dyn_cast<klee::ConstantExpr>(left);
    				long leftValue = leftConst->getZExtValue();
    				int *bits = extract_bits(leftValue, sizeof(leftValue)*8);
    				propagateTaintSubtract(bits,sizeof(leftValue)*8, right);

    			  }
    		}
    	   else {
    		  if(right.get()->getKind() == Expr::Constant){
    				klee::ConstantExpr * rightConst = dyn_cast<klee::ConstantExpr>(right);
    				long rightValue = rightConst->getZExtValue();
    				int *bits = extract_bits(rightValue, sizeof(rightValue)*8);
    				propagateTaintSubtract(bits,sizeof(rightValue)*8, left);
    		  }
    		  else {
    		  for (unsigned i = 0; i < getWidth(); i++)
    			  markTaint(i, ExtractExpr::alloc(this,i,1,false));
    		  }
    	   }
        }

        void propagateTaintSubtract(int *bits, unsigned int length, ref<Expr> nonConstantExpr){
        	bool mayCarry = false;
        	for (unsigned i = 0; i < getWidth(); i++){
        		//Need Review
        		//unsigned idx = Expr::IsLittleIndian ? i : (getWidth() - i - 1);
        		unsigned idx = nonConstantExpr.get()->getKind() == Expr::Concat ? preCalculatePosition(i) : i;

        		if(i < length){
    				 if(bits[idx] == 0){
    					 if(mayCarry){
    						 markTaint(i, ExtractExpr::alloc(this,i,1,false));
    						 mayCarry = true;
    					 }
    					 else{
    						 markTaint(i, nonConstantExpr.get()->readTaintDetails(idx));
    						 // For better explanation
    						 mayCarry = false;
    					 }
    				 }
    				 else {
    					 markTaint(i, ExtractExpr::alloc(this,i,1,false));
    					 mayCarry = true;
    				 }
        		}
    			else markTaint(i, nonConstantExpr.get()->readTaintDetails(idx));
    		 }
    	}

};

class MulExpr : public BinaryExpr {
public:
  static const Kind kind = Expr::Mul;
  static const unsigned numKids = 2;
public:
  MulExpr(const ref<Expr> &l,
                        const ref<Expr> &r, bool isConsiderTaint = true) : BinaryExpr(l,r) {
	  if(isConsiderTaint){
	  		  initialTaint();
	  		  propagateTaint();
	  	  }

    }
    static ref<Expr> alloc(const ref<Expr> &l, const ref<Expr> &r, bool isConsiderTaint = true) {
      ref<Expr> res(new MulExpr (l, r, isConsiderTaint));
      res->computeHash();
      return res;
    }
    static ref<Expr> create(const ref<Expr> &l, const ref<Expr> &r);


    Width getWidth() const { return left->getWidth(); }
    Kind getKind() const { return Expr::Mul; }
    virtual ref<Expr> rebuild(ref<Expr> kids[]) const {
      return create(kids[0], kids[1]);
    }

    static bool classof(const Expr *E) {
      return E->getKind() == Expr::Mul;
    }
    static bool classof(const  MulExpr *) {
      return true;
    }
protected:
    void propagateTaint()
	{
		if(left.get()->getKind() == Expr::Constant){
			  if(right.get()->getKind() == Expr::Constant){
				  for (unsigned i = 0; i < getWidth(); i++)
					markTaint(i, ConstantExpr::alloc(0,Expr::Int16,false));
			  }
			  else{
				klee::ConstantExpr * leftConst = dyn_cast<klee::ConstantExpr>(left);
				long leftValue = leftConst->getZExtValue();

				if(IsPowerOfTwo(leftValue)){
					int *bits = extract_bits(leftValue, sizeof(leftValue)*8);
					unsigned int shift = 0;
					while (bits[shift] != 1 && shift < sizeof(leftValue)*8) shift ++;
					propagateTaintLShr(right, shift);
				}

			  }
		}
	   else {
		  if(right.get()->getKind() == Expr::Constant){
				klee::ConstantExpr * rightConst = dyn_cast<klee::ConstantExpr>(right);
				long rightValue = rightConst->getZExtValue();
				if(IsPowerOfTwo(rightValue)){
					int *bits = extract_bits(rightValue, sizeof(rightValue)*8);
					unsigned int shift = 0;
					while (bits[shift] != 1 && shift < sizeof(rightValue)*8) shift ++;
					propagateTaintLShr(left, shift);
				}
		  }
		  else {
			  for (unsigned i = 0; i < getWidth(); i++)
				  markTaint(i, ExtractExpr::alloc(this,i,1,false));
			  }
	   	   }
	}

    bool IsPowerOfTwo(ulong x)
    {
        return (x != 0) && ((x & (x - 1)) == 0);
    }

    void propagateTaintLShr(ref<Expr> expr, unsigned int shift)
	{
	  bool isConcatExpr = expr.get()->getKind() == Expr::Concat;

	  for (unsigned i = 0; i < getWidth(); i++)
	  {
		  if(i + shift < getWidth()){
			  unsigned sIdx = isConcatExpr ? preCalculatePosition(i + shift) : i + shift;
			  markTaint(i, expr.get()->readTaintDetails(sIdx));
		  }
		  else markTaint(i, ConstantExpr::alloc(0,Expr::Int16, false));
	  }
	}
};


class UDivExpr : public BinaryExpr {
public:
  static const Kind kind = Expr::UDiv;
  static const unsigned numKids = 2;
public:
  UDivExpr(const ref<Expr> &l,
                        const ref<Expr> &r, bool isConsiderTaint = true) : BinaryExpr(l,r) {
	  if(isConsiderTaint){
	  		  initialTaint();
	  		  propagateTaint();
	  	  }

    }
    static ref<Expr> alloc(const ref<Expr> &l, const ref<Expr> &r, bool isConsiderTaint = true) {
      ref<Expr> res(new UDivExpr (l, r, isConsiderTaint));
      res->computeHash();
      return res;
    }
    static ref<Expr> create(const ref<Expr> &l, const ref<Expr> &r);


    Width getWidth() const { return left->getWidth(); }
    Kind getKind() const { return Expr::UDiv; }
    virtual ref<Expr> rebuild(ref<Expr> kids[]) const {
      return create(kids[0], kids[1]);
    }

    static bool classof(const Expr *E) {
      return E->getKind() == Expr::UDiv;
    }
    static bool classof(const  UDivExpr *) {
      return true;
    }
protected:
    void propagateTaint()
	{
		if(left.get()->getKind() == Expr::Constant){
			  if(right.get()->getKind() == Expr::Constant){
				  for (unsigned i = 0; i < getWidth(); i++)
					markTaint(i, ConstantExpr::alloc(0,Expr::Int16,false));
			  }
			  else{
				klee::ConstantExpr * leftConst = dyn_cast<klee::ConstantExpr>(left);
				long leftValue = leftConst->getZExtValue();

				if(IsPowerOfTwo(leftValue)){
					int *bits = extract_bits(leftValue, sizeof(leftValue)*8);
					unsigned int shift = 0;
					while (bits[shift] != 1 && shift < sizeof(leftValue)*8) shift ++;
					propagateTaintShr(right, shift);
				}

			  }
		}
	   else {
		  if(right.get()->getKind() == Expr::Constant){
				klee::ConstantExpr * rightConst = dyn_cast<klee::ConstantExpr>(right);
				long rightValue = rightConst->getZExtValue();
				if(IsPowerOfTwo(rightValue)){
					int *bits = extract_bits(rightValue, sizeof(rightValue)*8);
					unsigned int shift = 0;
					while (bits[shift] != 1 && shift < sizeof(rightValue)*8) shift ++;
					propagateTaintShr(left, shift);
				}
		  }
		  else {
		  for (unsigned i = 0; i < getWidth(); i++)
			  markTaint(i, ExtractExpr::alloc(this,i,1,false));
		  }
	   }
	}

	bool IsPowerOfTwo(ulong x)
	{
		return (x != 0) && ((x & (x - 1)) == 0);
	}

	void propagateTaintShr(ref<Expr> expr, int shift)
	  {
		  bool isConcatExpr = expr.get()->getKind() == Expr::Concat;
		  for (unsigned i = 0; i < getWidth(); i++)
		  {
			  if((int)i - shift >= 0){
				  unsigned sIdx = isConcatExpr ? preCalculatePosition(i - shift) : i - shift;
				  markTaint(i, expr.get()->readTaintDetails(sIdx));
			  }
			  else markTaint(i, ConstantExpr::alloc(0, Expr::Int16,false));
		  }
	  }

};


class SDivExpr : public BinaryExpr {
public:
  static const Kind kind = Expr::SDiv;
  static const unsigned numKids = 2;
public:
  SDivExpr(const ref<Expr> &l,
                        const ref<Expr> &r, bool isConsiderTaint = true) : BinaryExpr(l,r) {
	  if(isConsiderTaint){
	  		  initialTaint();
	  		  propagateTaint();
	  	  }

    }
    static ref<Expr> alloc(const ref<Expr> &l, const ref<Expr> &r, bool isConsiderTaint = true) {
      ref<Expr> res(new SDivExpr (l, r, isConsiderTaint));
      res->computeHash();
      return res;
    }
    static ref<Expr> create(const ref<Expr> &l, const ref<Expr> &r);


    Width getWidth() const { return left->getWidth(); }
    Kind getKind() const { return Expr::SDiv; }
    virtual ref<Expr> rebuild(ref<Expr> kids[]) const {
      return create(kids[0], kids[1]);
    }

    static bool classof(const Expr *E) {
      return E->getKind() == Expr::SDiv;
    }
    static bool classof(const  SDivExpr *) {
      return true;
    }
protected:
    void propagateTaint()
	{
		if(left.get()->getKind() == Expr::Constant){
			  if(right.get()->getKind() == Expr::Constant){
				  for (unsigned i = 0; i < getWidth(); i++)
					markTaint(i, ConstantExpr::alloc(0,Expr::Int16,false));
			  }
			  else{
				klee::ConstantExpr * leftConst = dyn_cast<klee::ConstantExpr>(left);
				long leftValue = leftConst->getZExtValue();

				if(IsPowerOfTwo(leftValue)){
					int *bits = extract_bits(leftValue, sizeof(leftValue)*8);
					unsigned int shift = 0;
					while (bits[shift] != 1 && shift < sizeof(leftValue)*8) shift ++;
					propagateTaintShr(right, shift);
				}

			  }
		}
	   else {
		  if(right.get()->getKind() == Expr::Constant){
				klee::ConstantExpr * rightConst = dyn_cast<klee::ConstantExpr>(right);
				long rightValue = rightConst->getZExtValue();
				if(IsPowerOfTwo(rightValue)){
					int *bits = extract_bits(rightValue, sizeof(rightValue)*8);
					unsigned int shift = 0;
					while (bits[shift] != 1 && shift < sizeof(rightValue)*8) shift ++;
					propagateTaintShr(left, shift);
				}
		  }
		  else {
		  for (unsigned i = 0; i < getWidth(); i++)
			  markTaint(i, ExtractExpr::alloc(this,i,1,false));
		  }
	   }
	}
	bool IsPowerOfTwo(ulong x)
	{
		return (x != 0) && ((x & (x - 1)) == 0);
	}
	void propagateTaintShr(ref<Expr> expr, int shift)
		  {
			  bool isConcatExpr = expr.get()->getKind() == Expr::Concat;
			  for (unsigned i = 0; i < getWidth(); i++)
			  {
				  if((int)i - shift >= 0){
					  unsigned sIdx = isConcatExpr ? preCalculatePosition(i - shift) : i - shift;
					  markTaint(i, expr.get()->readTaintDetails(sIdx));
				  }
				  else markTaint(i, ConstantExpr::alloc(0, Expr::Int16,false));
			  }
		  }

};



class URemExpr : public BinaryExpr {
public:
  static const Kind kind = Expr::URem;
  static const unsigned numKids = 2;
public:
  URemExpr(const ref<Expr> &l,
                        const ref<Expr> &r, bool isConsiderTaint = true) : BinaryExpr(l,r) {
	  if(isConsiderTaint){
	  		  initialTaint();
	  		  propagateTaint();
	  	  }

    }
    static ref<Expr> alloc(const ref<Expr> &l, const ref<Expr> &r, bool isConsiderTaint = true) {
      ref<Expr> res(new URemExpr (l, r, isConsiderTaint));
      res->computeHash();
      return res;
    }
    static ref<Expr> create(const ref<Expr> &l, const ref<Expr> &r);


    Width getWidth() const { return left->getWidth(); }
    Kind getKind() const { return Expr::URem; }
    virtual ref<Expr> rebuild(ref<Expr> kids[]) const {
      return create(kids[0], kids[1]);
    }

    static bool classof(const Expr *E) {
      return E->getKind() == Expr::URem;
    }
    static bool classof(const  URemExpr *) {
      return true;
    }
protected:
    void propagateTaint()
    	{
    		if(left.get()->getKind() == Expr::Constant){
    			  if(right.get()->getKind() == Expr::Constant){
    				  for (unsigned i = 0; i < getWidth(); i++)
    					markTaint(i, ConstantExpr::alloc(0,Expr::Int16,false));
    			  }
    			  else{

    				  for (unsigned i = 0; i < getWidth(); i++){

						  markTaint(i, ExtractExpr::alloc(this,i,1,false));
					  }
    			  }
    		}
    	   else {
    		   for (unsigned i = 0; i < getWidth(); i++){
				  markTaint(i, ExtractExpr::alloc(this,i,1,false));
			  }
    	   }
    	}
};


class SRemExpr : public BinaryExpr {
public:
  static const Kind kind = Expr::SRem;
  static const unsigned numKids = 2;
public:
  SRemExpr(const ref<Expr> &l,
                        const ref<Expr> &r, bool isConsiderTaint = true) : BinaryExpr(l,r) {
	  if(isConsiderTaint){
	  		  initialTaint();
	  		  propagateTaint();
	  	  }

    }
    static ref<Expr> alloc(const ref<Expr> &l, const ref<Expr> &r, bool isConsiderTaint = true) {
      ref<Expr> res(new SRemExpr (l, r, isConsiderTaint));
      res->computeHash();
      return res;
    }
    static ref<Expr> create(const ref<Expr> &l, const ref<Expr> &r);


    Width getWidth() const { return left->getWidth(); }
    Kind getKind() const { return Expr::SRem; }
    virtual ref<Expr> rebuild(ref<Expr> kids[]) const {
      return create(kids[0], kids[1]);
    }

    static bool classof(const Expr *E) {
      return E->getKind() == Expr::SRem;
    }
    static bool classof(const  SRemExpr *) {
      return true;
    }
protected:
    void propagateTaint()
	{
		if(left.get()->getKind() == Expr::Constant){
			  if(right.get()->getKind() == Expr::Constant){
				  for (unsigned i = 0; i < getWidth(); i++)
					markTaint(i, ConstantExpr::alloc(0,Expr::Int16,false));
			  }
			  else{

				  for (unsigned i = 0; i < getWidth(); i++){

					  markTaint(i, ExtractExpr::alloc(this,i,1,false));
				  }
			  }
		}
	   else {
		   for (unsigned i = 0; i < getWidth(); i++){
			  markTaint(i, ExtractExpr::alloc(this,i,1,false));
		  }
	   }
	}
};


class AndExpr : public BinaryExpr {
public:
  static const Kind kind = Expr::And;
  static const unsigned numKids = 2;
public:
  AndExpr(const ref<Expr> &l,
                        const ref<Expr> &r, bool isConsiderTaint = true) : BinaryExpr(l,r) {
	  if(isConsiderTaint){
	  		  initialTaint();
	  		  propagateTaint();
	  	  }

    }
    static ref<Expr> alloc(const ref<Expr> &l, const ref<Expr> &r, bool isConsiderTaint = true) {
      ref<Expr> res(new AndExpr (l, r, isConsiderTaint));
      res->computeHash();
      return res;
    }
    static ref<Expr> create(const ref<Expr> &l, const ref<Expr> &r);


    Width getWidth() const { return left->getWidth(); }
    Kind getKind() const { return Expr::And; }
    virtual ref<Expr> rebuild(ref<Expr> kids[]) const {
      return create(kids[0], kids[1]);
    }

    static bool classof(const Expr *E) {
      return E->getKind() == Expr::And;
    }
    static bool classof(const  AndExpr *) {
      return true;
    }
protected:
    void propagateTaint(){
    	if(left.get()->getKind() == Expr::Constant){
			  if(right.get()->getKind() == Expr::Constant){
				  for (unsigned i = 0; i < getWidth(); i++)
				    markTaint(i, ConstantExpr::alloc(0,Expr::Int16,false));
			  }
			  else{
				klee::ConstantExpr * leftConst = dyn_cast<klee::ConstantExpr>(left);
				long leftValue = leftConst->getZExtValue();
				int *bits = extract_bits(leftValue, sizeof(leftValue)*8);
				propagateTaintAnd(bits,sizeof(leftValue)*8, right);

			  }
    	}
	   else {
		  if(right.get()->getKind() == Expr::Constant){
				klee::ConstantExpr * rightConst = dyn_cast<klee::ConstantExpr>(right);
				long rightValue = rightConst->getZExtValue();
				int *bits = extract_bits(rightValue, sizeof(rightValue)*8);
				propagateTaintAnd(bits,sizeof(rightValue)*8, left);
		  }
		  else {
			  bool isConcatExpr = (right.get()->getKind() == Expr::Concat) || (left.get()->getKind() == Expr::Concat);
			  for (unsigned i = 0; i < getWidth(); i++){
				  unsigned idx = isConcatExpr ? preCalculatePosition(i) : i;
				  markTaint(i, AndExpr::alloc(left.get()->readTaintDetails(idx),right.get()->readTaintDetails(idx),false));
			  }
		  }
	  }
    }

    void propagateTaintAnd(int *bits, unsigned int length, ref<Expr> nonConstantExpr)
      {
    	  bool isConcatExpr = nonConstantExpr.get()->getKind() == Expr::Concat;
    	  for (unsigned i = 0; i < getWidth(); i++)
    	  {
    		  unsigned idx = isConcatExpr ? preCalculatePosition(i) : i;
    		  if(i < length)
    			  if(bits[i] == 0)
    				  markTaint(i, ConstantExpr::alloc(0,Expr::Int16, false));
    			  else{
    				  	  markTaint(i, nonConstantExpr.get()->readTaintDetails(idx));
    				  }
    		  else markTaint(i, nonConstantExpr.get()->readTaintDetails(idx));
    	  }
      }
};


class OrExpr : public BinaryExpr {
public:
  static const Kind kind = Expr::Or;
  static const unsigned numKids = 2;
public:
  OrExpr(const ref<Expr> &l,
                        const ref<Expr> &r, bool isConsiderTaint = true) : BinaryExpr(l,r) {
	  if(isConsiderTaint){
	  		  initialTaint();
	  		  propagateTaint();
	  	  }

    }
    static ref<Expr> alloc(const ref<Expr> &l, const ref<Expr> &r, bool isConsiderTaint = true) {
      ref<Expr> res(new OrExpr (l, r, isConsiderTaint));
      res->computeHash();
      return res;
    }
    static ref<Expr> create(const ref<Expr> &l, const ref<Expr> &r);


    Width getWidth() const { return left->getWidth(); }
    Kind getKind() const { return Expr::Or; }
    virtual ref<Expr> rebuild(ref<Expr> kids[]) const {
      return create(kids[0], kids[1]);
    }

    static bool classof(const Expr *E) {
      return E->getKind() == Expr::Or;
    }
    static bool classof(const  OrExpr *) {
      return true;
    }
protected:
    void propagateTaint(){
    	if(left.get()->getKind() == Expr::Constant){
			  if(right.get()->getKind() == Expr::Constant){
				  for (unsigned i = 0; i < getWidth(); i++)
				    markTaint(i, ConstantExpr::alloc(0,Expr::Int16,false));
			  }
			  else{
				klee::ConstantExpr * leftConst = dyn_cast<klee::ConstantExpr>(left);
				long leftValue = leftConst->getZExtValue();
				int *bits = extract_bits(leftValue, sizeof(leftValue)*8);
				propagateTaintOr(bits,sizeof(leftValue)*8, right);

			  }
    	}
	   else {
		  if(right.get()->getKind() == Expr::Constant){
				klee::ConstantExpr * rightConst = dyn_cast<klee::ConstantExpr>(right);
				long rightValue = rightConst->getZExtValue();
				int *bits = extract_bits(rightValue, sizeof(rightValue)*8);
				propagateTaintOr(bits,sizeof(rightValue)*8, left);
		  }
		  else {
			  bool isConcatExpr = (right.get()->getKind() == Expr::Concat) || (left.get()->getKind() == Expr::Concat);
			  for (unsigned i = 0; i < getWidth(); i++){
				  unsigned idx = isConcatExpr ? preCalculatePosition(i) : i;
				  markTaint(i, OrExpr::alloc(left.get()->readTaintDetails(idx),right.get()->readTaintDetails(idx),false));
			  }
		  }
	  }
    }

    void propagateTaintOr(int *bits, int length, ref<Expr> nonConstantExpr)
      {
    	bool isConcatExpr = nonConstantExpr.get()->getKind() == Expr::Concat;
    	  for (unsigned i = 0; i < getWidth(); i++)
    	  {
    		  unsigned idx = isConcatExpr ? preCalculatePosition(i) : i;
    		  if(i < sizeof(length))
    			  if(bits[i] == 1)
    				  markTaint(i, ConstantExpr::alloc(0,Expr::Int16, false));
    			  else markTaint(i, nonConstantExpr.get()->readTaintDetails(idx));
    		  else markTaint(i, nonConstantExpr.get()->readTaintDetails(idx));
    	  }
      }
};


class XorExpr : public BinaryExpr {
public:
  static const Kind kind = Expr::Xor;
  static const unsigned numKids = 2;
public:
  XorExpr(const ref<Expr> &l,
                        const ref<Expr> &r, bool isConsiderTaint = true) : BinaryExpr(l,r) {
	  if(isConsiderTaint){
	  		  initialTaint();
	  		  propagateTaint();
	  	  }

    }
    static ref<Expr> alloc(const ref<Expr> &l, const ref<Expr> &r, bool isConsiderTaint = true) {
      ref<Expr> res(new XorExpr (l, r, isConsiderTaint));
      res->computeHash();
      return res;
    }
    static ref<Expr> create(const ref<Expr> &l, const ref<Expr> &r);


    Width getWidth() const { return left->getWidth(); }
    Kind getKind() const { return Expr::Xor; }
    virtual ref<Expr> rebuild(ref<Expr> kids[]) const {
      return create(kids[0], kids[1]);
    }

    static bool classof(const Expr *E) {
      return E->getKind() == Expr::Xor;
    }
    static bool classof(const  XorExpr *) {
      return true;
    }
protected:
    void propagateTaint(){
    	for (unsigned i = 0; i < getWidth(); i++)
		{
    		markTaint(i, ExtractExpr::alloc(this,i,1,false));
		}
    }
};



class ShlExpr : public BinaryExpr {
public:
  static const Kind kind = Expr::Shl;
  static const unsigned numKids = 2;
public:
  ShlExpr(const ref<Expr> &l,
                        const ref<Expr> &r, bool isConsiderTaint = true) : BinaryExpr(l,r) {
	  if(isConsiderTaint){
	  		  initialTaint();
	  		  propagateTaint();
	  	  }

    }
    static ref<Expr> alloc(const ref<Expr> &l, const ref<Expr> &r, bool isConsiderTaint = true) {
      ref<Expr> res(new ShlExpr (l, r, isConsiderTaint));
      res->computeHash();
      return res;
    }
    static ref<Expr> create(const ref<Expr> &l, const ref<Expr> &r);


    Width getWidth() const { return left->getWidth(); }
    Kind getKind() const { return Expr::Shl; }
    virtual ref<Expr> rebuild(ref<Expr> kids[]) const {
      return create(kids[0], kids[1]);
    }

    static bool classof(const Expr *E) {
      return E->getKind() == Expr::Shl;
    }
    static bool classof(const  ShlExpr *) {
      return true;
    }
protected:
    void propagateTaint(){
    	if(left.get()->getKind() == Expr::Constant){
			  if(right.get()->getKind() == Expr::Constant){
				  for (unsigned i = 0; i < getWidth(); i++)
				    markTaint(i, ConstantExpr::alloc(0,Expr::Int16,false));
			  }
			  else{

				  for (unsigned i = 0; i < getWidth(); i++)
					{

						  markTaint(i, ExtractExpr::alloc(this,i,1,false));
					}

			  }
    	}
	   else {
		  if(right.get()->getKind() == Expr::Constant){
			  klee::ConstantExpr * rightConst = dyn_cast<klee::ConstantExpr>(right);
			  unsigned int rightValue = rightConst->getZExtValue();
			  propagateTaintLShr(left, rightValue);
		  }
		  else {
		  for (unsigned i = 0; i < getWidth(); i++)
			  markTaint(i, ExtractExpr::alloc(this,i,1,false));
		  }
	  }
    }

    void propagateTaintLShr(ref<Expr> expr, unsigned int shift)
    	{
    	  bool isConcatExpr = expr.get()->getKind() == Expr::Concat;

    	  for (unsigned i = 0; i < getWidth(); i++)
    	  {
    		  if(i + shift < getWidth()){
    			  unsigned sIdx = isConcatExpr ? preCalculatePosition(i + shift) : i + shift;
    			  markTaint(i, expr.get()->readTaintDetails(sIdx));
    		  }
    		  else markTaint(i, ConstantExpr::alloc(0,Expr::Int16, false));
    	  }
    	}
};


class LShrExpr : public BinaryExpr {
public:
  static const Kind kind = Expr::LShr;
  static const unsigned numKids = 2;
public:
  LShrExpr(const ref<Expr> &l,
                        const ref<Expr> &r, bool isConsiderTaint = true) : BinaryExpr(l,r) {
	  if(isConsiderTaint){
	  		  initialTaint();
	  		  propagateTaint();
	  	  }
    }
    static ref<Expr> alloc(const ref<Expr> &l, const ref<Expr> &r, bool isConsiderTaint = true) {
      ref<Expr> res(new LShrExpr (l, r, isConsiderTaint));
      res->computeHash();
      return res;
    }
    static ref<Expr> create(const ref<Expr> &l, const ref<Expr> &r);


    Width getWidth() const { return left->getWidth(); }
    Kind getKind() const { return Expr::LShr; }
    virtual ref<Expr> rebuild(ref<Expr> kids[]) const {
      return create(kids[0], kids[1]);
    }

    static bool classof(const Expr *E) {
      return E->getKind() == Expr::LShr;
    }
    static bool classof(const  LShrExpr *) {
      return true;
    }
protected:
    void propagateTaint(){
    	if(left.get()->getKind() == Expr::Constant){
			  if(right.get()->getKind() == Expr::Constant){
				  for (unsigned i = 0; i < getWidth(); i++)
				    markTaint(i, ConstantExpr::alloc(0,Expr::Int16,false));
			  }
			  else{

				  for (unsigned i = 0; i < getWidth(); i++)
					{

						  markTaint(i, ExtractExpr::alloc(this,i,1,false));
					}

			  }
    	}
	   else {
		  if(right.get()->getKind() == Expr::Constant){
			  klee::ConstantExpr * rightConst = dyn_cast<klee::ConstantExpr>(right);
			  unsigned int rightValue = rightConst->getZExtValue();
			  propagateTaintShr(left, rightValue);
		  }
		  else {
		  for (unsigned i = 0; i < getWidth(); i++)
			  markTaint(i, ExtractExpr::alloc(this,i,1,false));
		  }
	  }
    }



    void propagateTaintShr(ref<Expr> expr, int shift)
    		  {
    			  bool isConcatExpr = expr.get()->getKind() == Expr::Concat;
    			  for (unsigned i = 0; i < getWidth(); i++)
    			  {
    				  if((int)i - shift >= 0){
    					  unsigned sIdx = isConcatExpr ? preCalculatePosition(i - shift) : i - shift;
    					  markTaint(i, expr.get()->readTaintDetails(sIdx));
    				  }
    				  else markTaint(i, ConstantExpr::alloc(0, Expr::Int16,false));
    			  }
    		  }

};


class AShrExpr : public BinaryExpr {
public:
  static const Kind kind = Expr::AShr;
  static const unsigned numKids = 2;
public:
  AShrExpr(const ref<Expr> &l,
                        const ref<Expr> &r, bool isConsiderTaint = true) : BinaryExpr(l,r) {
	  if(isConsiderTaint){
	  		  initialTaint();
	  		  propagateTaint();
	  	  }

    }
    static ref<Expr> alloc(const ref<Expr> &l, const ref<Expr> &r, bool isConsiderTaint = true) {
      ref<Expr> res(new AShrExpr (l, r, isConsiderTaint));
      res->computeHash();
      return res;
    }
    static ref<Expr> create(const ref<Expr> &l, const ref<Expr> &r);


    Width getWidth() const { return left->getWidth(); }
    Kind getKind() const { return Expr::AShr; }
    virtual ref<Expr> rebuild(ref<Expr> kids[]) const {
      return create(kids[0], kids[1]);
    }

    static bool classof(const Expr *E) {
      return E->getKind() == Expr::AShr;
    }
    static bool classof(const  AShrExpr *) {
      return true;
    }
protected:
    void propagateTaint(){
    	if(left.get()->getKind() == Expr::Constant){
			  if(right.get()->getKind() == Expr::Constant){
				  for (unsigned i = 0; i < getWidth(); i++)
				    markTaint(i, ConstantExpr::alloc(0,Expr::Int16,false));
			  }
			  else{

				  for (unsigned i = 0; i < getWidth(); i++)
					{

						  markTaint(i, ExtractExpr::alloc(this,i,1,false));
					}

			  }
    	}
	   else {
		  if(right.get()->getKind() == Expr::Constant){
			  klee::ConstantExpr * rightConst = dyn_cast<klee::ConstantExpr>(right);
			  unsigned int rightValue = rightConst->getZExtValue();
			  propagateTaintShr(left, rightValue);
		  }
		  else {
		  for (unsigned i = 0; i < getWidth(); i++)
			  markTaint(i, ExtractExpr::alloc(this,i,1,false));
		  }
	  }
    }

    void propagateTaintShr(ref<Expr> expr, int shift)
    		  {
    			  bool isConcatExpr = expr.get()->getKind() == Expr::Concat;
    			  for (unsigned i = 0; i < getWidth(); i++)
    			  {

    				  if((int)i - shift >= 0){
    					  unsigned sIdx = isConcatExpr ? preCalculatePosition(i - shift) : i - shift;
    					  markTaint(i, expr.get()->readTaintDetails(sIdx));
    				  }
    				  else markTaint(i, ConstantExpr::alloc(0, Expr::Int16,false));
    			  }
    		  }

};


// Implementations

inline bool Expr::isZero() const {
  if (const ConstantExpr *CE = dyn_cast<ConstantExpr>(this))
    return CE->isZero();
  return false;
}
  
inline bool Expr::isTrue() const {
  assert(getWidth() == Expr::Bool && "Invalid isTrue() call!");
  if (const ConstantExpr *CE = dyn_cast<ConstantExpr>(this))
    return CE->isTrue();
  return false;
}
  
inline bool Expr::isFalse() const {
  assert(getWidth() == Expr::Bool && "Invalid isFalse() call!");
  if (const ConstantExpr *CE = dyn_cast<ConstantExpr>(this))
    return CE->isFalse();
  return false;
}

} // End klee namespace

#endif
