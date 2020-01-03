package stx.macro.expr.pack;

abstract Constant(StdConstant) from StdConstant{
  public function expr(pos):stx.macro.pack.Expr{
    return new stx.macro.expr.pack.ExprDef(EConst(this)).expr(pos);
  }
}