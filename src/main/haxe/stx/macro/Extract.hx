package stx.macro;

using stx.Options;
using stx.Upshot;

#if macro
  import tink.macro.Types;
  import haxe.macro.Type;
  import haxe.macro.Expr;
  import haxe.macro.Context;
#end

class Extract{
  static public macro function apply(source:Expr,target:Expr):Expr{
    var tp0,flds;
    switch (target.expr) {
      case EConst(CIdent(str)):
        tp0   = Context.getType(str);
        flds  = (Types.getFields(tp0):Upshot<Array<ClassField>>).toOption().release();
        //trace(flds);
      default :
    }
    var type0 = Types.toComplex(Context.typeof(source));
    var type1 = Types.toComplex(tp0);

    trace(type0);
    trace(type1);
    switch (source.expr) {
      //case EObjec
      default :
    }
    var exp = flds.map;
    var fnc = macro function(x:$type0):$type1{

    }
    trace(fnc);
    //
    //var fields = (Types.getFields(Context.typeof(fields)):Upshot<Array<ClassField>>).toOption().release();
    //trace(fields);
    return { expr : EBlock([]), pos : Context.currentPos()};
  }
  #if macro

  #end
}