package stx.makro;

#if macro
typedef HExpr              = stx.makro.expr.HExpr;
typedef LiftHExpr          = stx.makro.expr.HExpr.LiftHExpr;

typedef HExprArray         = stx.makro.expr.HExprArray;
typedef HExprArrayDef      = stx.makro.expr.HExprArray.HExprArrayDef;
typedef MethodCall         = stx.makro.expr.MethodCall; 
typedef HExprDef           = stx.makro.expr.HExprDef;

typedef Constant          = stx.makro.expr.Constant;

typedef TypeDefKind       = stx.makro.expr.TypeDefKind;
typedef ClassTypeDefKind  = stx.makro.expr.ClassTypeDefKind;
typedef TypeDefinition    = stx.makro.expr.TypeDefinition;

typedef MetadataEntry     = stx.makro.expr.MetadataEntry;




typedef LiftConstantToHExpr        = stx.makro.expr.lift.LiftConstantToHExpr;
typedef LiftMethodRefToHExpr       = stx.makro.expr.lift.LiftMethodRefToHExpr;
typedef LiftModuleToHExpr          = stx.makro.expr.lift.LiftModuleToHExpr;

class Cases{
  static public function foldKeys<T>(m:Monoid<T>,c:Case):Continuation<T,HExpr>{
    return function(constructor:HExpr->T):T{
      var values = c.values.fold(
        (next:stx.makro.alias.StdExpr,memo) -> m.plus(constructor(HExpr.fromExpr(next)),memo),
        m.unit()
      );
      var guard  = c.guard == null ? m.unit() : constructor(HExpr.fromExpr(c.guard));

      var expr   = c.expr == null ? m.unit() : constructor(HExpr.fromExpr(c.expr));

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
  #if macro
  static public function toEBlock(arr:Array<haxe.macro.Expr>):HExpr{
    return HExpr.fromExpr({
      expr  : StdExprDef.EBlock(arr.prj()),
      pos   : Context.currentPos()
    });
  }
  #end
}
#end