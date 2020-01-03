package stx.makro.expr.pack;

abstract Constant(StdConstant) from StdConstant{
  public function expr(pos):stx.makro.pack.Expr{
    return new stx.makro.expr.pack.ExprDef(EConst(this)).expr(pos);
  }
}