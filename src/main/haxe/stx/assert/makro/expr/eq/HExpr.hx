package stx.assert.makro.expr.eq;

import stx.makro.expr.HExprDef as THExprDef;
import stx.makro.expr.HExpr as THExpr;

class HExpr extends EqCls<THExpr>{

  public function new(){}

  public function comply(a:THExpr,b:THExpr):Equaled{
    return new HExprDef().comply(THExprDef.lift(a.expr),THExprDef.lift(b.expr));
  }
}