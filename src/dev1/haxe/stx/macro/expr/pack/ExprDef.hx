package stx.macro.expr.pack;

abstract ExprDef(StdExprDef) from StdExprDef to StdExprDef{
  public function new(self) this = self;
  public function toExpr(pos):stx.macro.pack.Expr{
    return new stx.macro.pack.Expr({
      pos : pos,
      expr : this
    });
  }
  public function expr(pos){
    return toExpr(pos);
  }
}