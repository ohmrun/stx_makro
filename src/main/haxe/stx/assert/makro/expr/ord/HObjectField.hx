package stx.assert.makro.expr.ord;

import stx.makro.expr.HObjectField as HObjectFieldT;

class HObjectField extends OrdCls<HObjectFieldT>{
  public function new(){}
  public function comply(lhs:HObjectFieldT,rhs:HObjectFieldT){
    var ord = Ord.String().comply(lhs.field,rhs.field);
    if(ord.is_not_less_than()){
      ord = new stx.assert.makro.expr.ord.Expr().comply(lhs.expr,rhs.expr);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new stx.assert.makro.expr.ord.QuoteStatus()).comply(lhs.quotes,rhs.quotes);
    }
    return ord;
  }
}