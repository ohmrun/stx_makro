package stx.makro.expr.lift;

class LiftConstantToExpr{
  static public function toExpr(self:Constant,?pos:Pos):Expr{
    return new stx.makro.expr.ExprDef(EConst(self)).expr(pos);
  }
}