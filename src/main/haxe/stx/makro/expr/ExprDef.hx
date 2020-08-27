package stx.makro.expr;

abstract ExprDef(StdExprDef) from StdExprDef to StdExprDef{
  static public var MARK(default,null) = mark();
  static public var ZERO(default,null) = unit();
  
  static public function unit():ExprDef{
    return ExprDef.EConst(CIdent('null'));
  }
  static public function mark():ExprDef{
    return ExprDef.EConst(CIdent('$'));
  }
  @:noUsing static public function EConst(v):ExprDef{
    return StdExprDef.EConst(v);
  }
  @:noUsing static public function ESwitch(e:Expr,cases:Array<Case>,def:Expr):ExprDef{
    return StdExprDef.ESwitch(e,cases.prj(),def);
  }
  @:noUsing static public function EArrayDecl(vals:Array<Expr>):ExprDef{
    return StdExprDef.EArrayDecl(vals.prj());
  }
  @:noUsing static public function ECall(self:Expr,with:Array<Expr>):ExprDef{
    return StdExprDef.ECall(self,with.prj());
  }
  @:noUsing static public function EField(e:Expr,f:String):ExprDef{
    return StdExprDef.EField(e,f);
  }
  @:noUsing static public function EBlock(arr:Array<Expr>):ExprDef{
    return StdExprDef.EBlock(arr.prj());
  }

  static public var _(default,never) = ExprDefLift;
  public function new(self) this = self;
  public function toExpr(pos):stx.makro.Expr{
    return new stx.makro.Expr({
      pos : pos,
      expr : this
    });
  }
  public function expr(pos){
    return toExpr(pos);
  }
}
class ExprDefLift{

}