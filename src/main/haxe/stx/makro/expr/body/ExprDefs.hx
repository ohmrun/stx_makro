package stx.makro.expr.body;

class ExprDefs{
  static public var MARK = mark();
  static public var UNIT = unit();

  static function mark():ExprDef{
    return ExprDefs.EConst(CIdent('$'));
  }
  static function unit():ExprDef{
    return ExprDefs.EConst(CIdent('null'));
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
}