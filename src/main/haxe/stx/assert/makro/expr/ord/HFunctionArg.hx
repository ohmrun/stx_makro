package stx.assert.makro.expr.ord;

import stx.makro.expr.HFunctionArg as HFunctionArgT;

class HFunctionArg extends OrdCls<HFunctionArgT>{
  public function new(){}
  public function comply(lhs:HFunctionArgT,rhs:HFunctionArgT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new HComplexType()).comply(lhs.type,rhs.type);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Bool()).comply(lhs.opt,rhs.opt);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new stx.assert.makro.expr.ord.Expr()).comply(lhs.value,rhs.value);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new HMetadata()).comply(lhs.meta,rhs.meta);
    }
    return ord;
  }
}