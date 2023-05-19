package stx.assert.makro.expr.eq;

import stx.makro.expr.HExprDef as THExprDef;
import stx.makro.expr.HExpr as THExpr;

final Eq = __.assert().Eq();

class HExpr extends EqCls<THExpr>{

  public function new(){}

  public function comply(a:THExpr,b:THExpr):Equaled{
    return Eq.Makro().Expr().HExprDef.comply(THExprDef.lift(a.expr),THExprDef.lift(b.expr));
  }
}