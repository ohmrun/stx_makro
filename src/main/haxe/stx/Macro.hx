package stx;

#if macro
  import tink.macro.Types;
  import haxe.macro.Type;
  import haxe.macro.Expr;
  import haxe.macro.Context;
#end

class Macro{
  #if macro
    static public function unit(){
      return { expr : EBlock([]), pos : Context.currentPos()};
    }
    static public function isZero(e:Expr):Bool{
      return false;
    }
    static public function isPrimitive(e:Expr):Bool{
      return false;
    }
    /*
    static public function combine(typedef0:Expr,typedef1:Expr,values_or_reference:Expr){
      return stx.macro.Combine.apply(typedef0,typedef1,values_or_reference);
    }*/
  #end
}
