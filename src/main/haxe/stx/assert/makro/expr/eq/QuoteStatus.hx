package stx.assert.makro.expr.eq;

import haxe.macro.Expr.QuoteStatus as TQuoteStatus;

class QuoteStatus extends EqCls<TQuoteStatus> {
  public function new(){}
  public function comply(lhs:TQuoteStatus,rhs:TQuoteStatus){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}