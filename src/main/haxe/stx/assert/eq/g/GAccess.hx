package stx.assert.eq.g;

import stx.g.lang.expr.GAccess as GAccessT;

class GAccess implements EqApi<GAccessT> extends Clazz{
  public function comply(lhs:GAccessT,rhs:GAccessT){
    return Eq.EnumValue().comply(lhs,rhs);
  }
}