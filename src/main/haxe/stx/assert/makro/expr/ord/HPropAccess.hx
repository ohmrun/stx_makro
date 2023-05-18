package stx.assert.makro.expr.ord;

import stx.makro.expr.HPropAccess as HPropAccessT;

class HPropAccess extends OrdCls<HPropAccessT>{
  public function new(){}
  public function comply(lhs:HPropAccessT,rhs:HPropAccessT){
    return Ord.String().comply(lhs,rhs);
  }
}