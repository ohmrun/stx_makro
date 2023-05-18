package stx.assert.makro.expr.eq;

import stx.makro.expr.HExprDef as THExprDef;
import haxe.macro.Expr as TExpr;

final Eq = __.assert().Eq();

class Expr extends EqCls<TExpr>{

  public function new(){}

  public function comply(a:TExpr,b:TExpr):Equaled{
    return new HExprDef().comply(THExprDef.lift(a.expr),THExprDef.lift(b.expr));
  }
}