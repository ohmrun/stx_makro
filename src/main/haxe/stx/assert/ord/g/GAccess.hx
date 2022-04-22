package stx.assert.ord.g;

import stx.g.lang.expr.GAccess as GAccessT;

class GAccess extends OrdCls<GAccessT>{
  public function new(){}
  public function comply(lhs:GAccessT,rhs:GAccessT){
    return Ord.EnumValue().comply(lhs,rhs);
  }
}