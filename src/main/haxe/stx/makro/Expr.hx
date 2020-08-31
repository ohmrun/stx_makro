package stx.makro;

typedef Expr              = stx.makro.expr.Expr;
typedef ExprArray         = stx.makro.expr.ExprArray;
typedef ExprArrayDef      = stx.makro.expr.ExprArray.ExprArrayDef;
typedef MethodCall        = stx.makro.expr.MethodCall; 
typedef ExprDef           = stx.makro.expr.ExprDef;

typedef Constant          = stx.makro.expr.Constant;

typedef TypeDefKind       = stx.makro.expr.TypeDefKind;
typedef ClassTypeDefKind  = stx.makro.expr.ClassTypeDefKind;
typedef TypeDefinition    = stx.makro.expr.TypeDefinition;

typedef MetadataEntry     = stx.makro.expr.MetadataEntry;




typedef LiftConstantToExpr        = stx.makro.expr.lift.LiftConstantToExpr;
typedef LiftMethodRefToExpr       = stx.makro.expr.lift.LiftMethodRefToExpr;
typedef LiftModuleToExpr          = stx.makro.expr.lift.LiftModuleToExpr;

class Cases{
  static public function foldKeys<T>(m:Monoid<T>,c:Case):Continuation<T,Expr>{
    return function(constructor:Expr->T):T{
      var values = c.values.fold(
        (next:stx.makro.alias.StdExpr,memo) -> m.plus(constructor(Expr.lift(next)),memo),
        m.unit()
      );
      var guard  = c.guard == null ? m.unit() : constructor(Expr.lift(c.guard));

      var expr   = c.expr == null ? m.unit() : constructor(Expr.lift(c.expr));

      return m.plus(m.plus(values,guard),expr);
    } 
  }
}
class LiftMetadataEntry{
  static public function makro(md:StdMetadataEntry):MetadataEntry{
    return md;
  }
}
class LiftEnumType{
  static public function makro(e:StdEnumType):EnumType{
    return new EnumType(e);
  }
}

class LiftEBlock {
  static public function toEBlock(arr:Array<haxe.macro.Expr>):Expr{
    return Expr.lift({
      expr  : StdExprDef.EBlock(arr.prj()),
      pos   : Context.currentPos()
    });
  }
}