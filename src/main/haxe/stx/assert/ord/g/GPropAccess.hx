package stx.assert.ord.g;

import stx.g.lang.expr.GPropAccess as GPropAccessT;

class GPropAccess extends OrdCls<GPropAccessT>{
  public function new(){}
  public function comply(lhs:GPropAccessT,rhs:GPropAccessT){
    return Ord.EnumValue().comply(lhs,rhs);
  }
}