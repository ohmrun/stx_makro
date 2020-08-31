package stx.makro.expr;
@:using(stx.makro.expr.ExprDef.ExprDefLift)
abstract ExprDef(StdExprDef) from StdExprDef to StdExprDef{
  static public var _(default,never) = ExprDefLift;
  static public var MARK(default,null) = mark();
  static public var ZERO(default,null) = unit();
  
  static public function lift(self:StdExprDef):ExprDef{
    return new ExprDef(self);
  }

  static public function unit():ExprDef{
    return lift(StdExprDef.EConst(CIdent('null')));
  }
  static public function mark():ExprDef{
    return lift(StdExprDef.EConst(CIdent('$')));
  }
  @:noUsing static public function EConst(v):ExprDef{
    return ExprDef.lift(StdExprDef.EConst(v));
  }
  @:noUsing static public function ESwitch(e:Expr,cases:Array<Case>,def:Expr):ExprDef{
    return ExprDef.lift(StdExprDef.ESwitch(e,cases.prj(),def));
  }
  @:noUsing static public function EArrayDecl(vals:ExprArray):ExprDef{
    return ExprDef.lift(StdExprDef.EArrayDecl(vals.prj()));
  }
  @:noUsing static public function ECall(self:Expr,with:ExprArray):ExprDef{
    return ExprDef.lift(StdExprDef.ECall(self,with.prj()));
  }
  @:noUsing static public function EField(e:Expr,f:String):ExprDef{
    return ExprDef.lift(StdExprDef.EField(e,f));
  }
  @:noUsing static public function EBlock(arr:ExprArray):ExprDef{
    return ExprDef.lift(StdExprDef.EBlock(arr.prj()));
  }
  public function new(self) this = self;
  public function toExpr(pos:Pos):Expr{
    return new Expr({
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