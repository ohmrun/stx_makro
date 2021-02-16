package stx.makro.expr.lift;

class LiftConstantToHExpr{
  static public function toHExpr(self:Constant,?pos:Pos):HExpr{
    return new stx.makro.expr.HExprDef(EConst(self)).expr(pos);
  }
}