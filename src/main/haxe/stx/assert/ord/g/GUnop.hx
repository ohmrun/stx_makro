package stx.assert.ord.g;

import stx.g.lang.expr.GUnop as GUnopT;

class GUnop extends OrdCls<GUnopT>{
  public function new(){}
  public function comply(lhs:GUnopT,rhs:GUnopT){
    return Ord.EnumValue().comply(lhs,rhs);
  }
}