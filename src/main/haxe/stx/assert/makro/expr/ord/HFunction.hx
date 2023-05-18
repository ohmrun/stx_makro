package stx.assert.makro.expr.ord;

import stx.makro.expr.HFunction as HFunctionT;

class HFunction extends OrdCls<HFunctionT>{
  public function new(){}
  public function comply(lhs:HFunctionT,rhs:HFunctionT){
    var ord = Ord.Cluster(new HFunctionArg()).comply(lhs.args,rhs.args);
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new HComplexType()).comply(lhs.ret,rhs.ret);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new stx.assert.makro.expr.ord.Expr()).comply(lhs.expr,rhs.expr);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Cluster(new HTypeParamDecl())).comply(lhs.params,rhs.params);
    }
    return ord;
  }
}