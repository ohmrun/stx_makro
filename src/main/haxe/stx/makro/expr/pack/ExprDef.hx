package stx.makro.expr.pack;

abstract ExprDef(StdExprDef) from StdExprDef to StdExprDef{
  public function new(self) this = self;
  public function toExpr(pos):stx.makro.pack.Expr{
    return new stx.makro.pack.Expr({
      pos : pos,
      expr : this
    });
  }
  public function expr(pos){
    return toExpr(pos);
  }
}