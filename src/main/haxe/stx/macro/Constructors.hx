package stx.macro;

using stx.Arrays;
using stx.Options;
import stx.Macro;
import tink.core.Error;

using stx.Upshot;

#if macro
  import tink.macro.Exprs;
  import tink.macro.Types;
  import haxe.macro.Type;
  import haxe.macro.Expr;
  import haxe.macro.Context;
  import stx.macro.Exprs;
#end

class Constructors{
  #if macro
    static public function arity(e:Expr):Int{
      var path_arr  = Exprs.path(e);
      var path      = path_arr.ensure().foldLeft1(function(x,y) return '$x.$y');
      var type      = Context.getType(path);
      switch (type) {
        case TInst(ref,params) :
          var constructor_ref = ref.get().constructor;
          if(constructor_ref == null){
            return -1;
          }
          
          function unpack(t:Type){
            return switch (t) {
              case TLazy(t) : unpack(t());
              default       : t;
            }
          }
          var constructor = unpack(constructor_ref.get().type);
          return switch (constructor) {
            case TFun(args,_) : args.length;
            default : -1;
          }
        default :
          trace(type);
          return -1;
      }
      return -1;
    }      
  #end
}
class Typedefs{
  #if macro
    /*
      TODO: optional vars at the end?n
    */
    static public function constructor(e:Expr){
      Macro.unit();
    }      
  #end
}
