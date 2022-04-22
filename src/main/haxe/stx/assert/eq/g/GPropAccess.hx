package stx.assert.eq.g;

import stx.g.lang.expr.GPropAccess as GPropAccessT;

class GPropAccess implements EqApi<GPropAccessT> extends Clazz{
  public function comply(lhs:GPropAccessT,rhs:GPropAccessT){
    return Eq.EnumValue().comply(lhs,rhs);
  }
}