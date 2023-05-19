package stx.assert.makro.expr.ord;

import stx.makro.expr.HExprDef as THExprDef;
import stx.makro.expr.HExpr as THExpr;

final Ord = __.assert().Ord();

class HExpr extends OrdCls<THExpr>{

  public function new(){}

  public function comply(a:THExpr,b:THExpr):Ordered{
    return Ord.Makro().Expr().HExprDef.comply(THExprDef.lift(a.expr),THExprDef.lift(b.expr));
  }
}