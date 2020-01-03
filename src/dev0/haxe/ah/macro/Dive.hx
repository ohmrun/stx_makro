package ah.macro;


using thx.Strings;
#if macro
using tink.MacroApi;
#end


using thx.Arrays;
using thx.ReadonlyArray;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Printer;

/**
  Create an accessor function for the type of e at path `path`.
*/
class Dive{
  macro public static function apply(e:Expr,path:Expr):Expr{
    return macro_apply(e,path);
  }
  #if macro
  public static function macro_apply(e:Expr,path:Expr):Expr{
    //trace("macro_apply");
    var printer = new Printer();
    //trace(e);
    var o = tink.macro.Exprs.transform(path,
      function(e){
        var pos = e.pos;
        return switch(e.expr){
          case EConst(CIdent(ident)) :
            {
                expr : EField({expr : EConst(CIdent("x")), pos : pos },ident),
                pos : pos
            }
          case EArrayDecl(_.first() => { expr : EConst(CInt(int)) , pos : pos }) :
            {
              expr : EArray(macro x,{ expr : EConst(CInt(int)), pos : pos}),
              pos : pos
            };
          default : e;
        }
      }
    );
    //trace(printer.printExpr(o));

    var type        = null;
    var ctype       = null;
    var path_maybe  = ah.Exprs.getEFieldPath(e);
    var path_name   = path_maybe.split(".").last();

    if(path_maybe!="" && path_name.substr(0).isUpperCase()){
      ctype =  path_maybe.asComplexType();
    }else{
      type  = e.typeof().sure();
      ctype = tink.macro.Types.toComplex(type);
    }
    //trace(printer.printComplexType(ctype));

    var out = macro function(x : $ctype){
      return $o;
    }
    //trace(printer.printExpr(out));
    return out;
  }
  #end
}
