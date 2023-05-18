package stx.assert.makro.expr.eq;

import stx.makro.expr.HCatch as THCatch;

class HCatch extends stx.assert.eq.term.Base<THCatch> {
  public function comply(lhs:THCatch,rhs:THCatch):Equaled{
    var eq = Eq.String().comply(lhs.name,rhs.name);
    return if(eq.is_ok()){
      eq = new stx.assert.makro.expr.eq.Expr().comply(lhs.expr,rhs.expr);
      if(eq.is_ok()){
        eq = Eq.NullOr(new HComplexType()).comply(lhs.type,rhs.type);
      }
      eq;
    }else{
      eq;
    }
  }
}