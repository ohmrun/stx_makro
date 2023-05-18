package stx.assert.makro.expr.eq;

import stx.makro.expr.HObjectField as THObjectField;

class HObjectField extends stx.assert.eq.term.Base<THObjectField> {
  public function comply(lhs:THObjectField,rhs:THObjectField){
    var eq = Eq.String().comply(lhs.field,rhs.field);
    if(eq.is_ok()){
      eq = new stx.assert.makro.expr.eq.Expr().comply(lhs.expr,rhs.expr);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(new stx.assert.makro.expr.eq.QuoteStatus()).comply(lhs.quotes,rhs.quotes);
    }
    return eq;
  }
} 