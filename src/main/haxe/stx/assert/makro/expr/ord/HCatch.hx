package stx.assert.makro.expr.ord;

import stx.makro.expr.HCatch as HCatchT;

class HCatch extends OrdCls<HCatchT>{
  public function new(){}
  public function comply(lhs:HCatchT,rhs:HCatchT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    return if(ord.is_not_less_than()){
      ord = new stx.assert.makro.expr.ord.Expr().comply(lhs.expr,rhs.expr);
      if(ord.is_not_less_than()){
        ord = Ord.NullOr(new HComplexType()).comply(lhs.type,rhs.type);
      }
      ord;
    }else{
      ord;
    }
  }
}