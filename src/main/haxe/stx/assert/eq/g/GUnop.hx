package stx.assert.eq.g;

import stx.g.lang.expr.GUnop as GUnopT;

class GUnop implements EqApi<GUnopT> extends Clazz{
  public function comply(lhs:GUnopT,rhs:GUnopT){
    return Eq.EnumValue().comply(lhs,rhs);
  }
}