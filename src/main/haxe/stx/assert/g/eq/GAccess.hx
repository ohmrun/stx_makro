package stx.assert.g.eq;

import stx.g.lang.expr.GAccess as GAccessT;

class GAccess extends stx.assert.eq.term.Base<GAccessT> {
  public function comply(lhs:GAccessT,rhs:GAccessT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}