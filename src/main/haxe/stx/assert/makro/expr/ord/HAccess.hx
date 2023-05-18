package stx.assert.makro.expr.ord;

import stx.makro.expr.HAccess as HAccessT;

class HAccess extends OrdCls<HAccessT>{
  public function new(){}
  public function comply(lhs:HAccessT,rhs:HAccessT){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}