package stx.makro.expr;
@:using(stx.makro.expr.HExprDef.HExprDefLift)
abstract HExprDef(StdExprDef) from StdExprDef to StdExprDef{
  static public var _(default,never) = HExprDefLift;
  static public var MARK(default,null) = mark();
  static public var ZERO(default,null) = unit();
  
  static public function lift(self:StdExprDef):HExprDef{
    return new HExprDef(self);
  }

  static public function unit():HExprDef{
    return lift(StdExprDef.EConst(CIdent('null')));
  }
  static public function mark():HExprDef{
    return lift(StdExprDef.EConst(CIdent('$')));
  }
  @:noUsing static public function EConst(v):HExprDef{
    return HExprDef.lift(StdExprDef.EConst(v));
  }
  @:noUsing static public function ESwitch(e:HExpr,cases:Array<Case>,def:HExpr):HExprDef{
    return HExprDef.lift(StdExprDef.ESwitch(e.toExpr(),cases.prj(),def.toExpr()));
  }
  @:noUsing static public function EArrayDecl(vals:HExprArray):HExprDef{
    return HExprDef.lift(StdExprDef.EArrayDecl(vals.toExprArray()));
  }
  @:noUsing static public function ECall(self:HExpr,with:HExprArray):HExprDef{
    return HExprDef.lift(StdExprDef.ECall(self.toExpr(),with.toExprArray()));
  }
  @:noUsing static public function EField(e:HExpr,f:String):HExprDef{
    return HExprDef.lift(StdExprDef.EField(e.toExpr(),f));
  }
  @:noUsing static public function EBlock(arr:HExprArray):HExprDef{
    return HExprDef.lift(StdExprDef.EBlock(arr.toExprArray()));
  }
  public function new(self) this = self;
  public function toHExpr(pos:Pos):HExpr{
    return HExpr.lift(
      { 
        tl : 
          {
            pos   : pos,
            expr  : this
          }
      }
    );
  }
  public function expr(pos){
    return toHExpr(pos);
  }
}
class HExprDefLift{

}