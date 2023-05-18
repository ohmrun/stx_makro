package stx.assert.makro.expr.eq;

import stx.makro.expr.HFunction as THFunction;

class HFunction extends stx.assert.eq.term.Base<THFunction> {
  public function comply(lhs:THFunction,rhs:THFunction){
    var eq = Eq.Cluster(new HFunctionArg()).comply(lhs.args,rhs.args);
    if(eq.is_ok()){
      eq = Eq.NullOr(new HComplexType()).comply(lhs.ret,rhs.ret);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(new stx.assert.makro.expr.eq.Expr()).comply(lhs.expr,rhs.expr);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Cluster(new HTypeParamDecl())).comply(lhs.params,rhs.params);
    }
    return eq;
  }
}