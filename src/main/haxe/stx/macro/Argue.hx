package stx.macro;

import stx.Errors;
import tink.core.Outcome;
using stx.Arrays;

#if macro
import tink.macro.Types;
import haxe.macro.Expr;
import haxe.macro.Context;
#end

/**
  Extracts the values of an object according to a type and calls a function in a typed way.

  UNKNOWN Default transform from primitive to Object?
*/
class Argue{
  public function new(){
    
  }
  static public macro function apply<T,U>(l:Expr,r:ExprOf<T->Void>){
    ArgueFunction.encode(r);
    return { expr : EBlock([]), pos : Context.currentPos()};
  }
  #if macro
    static function buildExtractor(){}
  #end
}
class ArgueFunction{
  #if macro
    static public function encode(v:Expr){
      switch (v.expr) {
        case EConst(CIdent(id)) : 
          switch (Context.typeof(v)) {
            case TFun(args,ret) :
              if(args.length > 1){
                Context.error('Argue supports only functions of arity 1.',Context.currentPos());
              }
              var arg = args[0];
              var fld = Types.getFields(arg.t).sure();
              
            default :
          }
        default :
      }
      return { expr : EBlock([]), pos : Context.currentPos()};
    }
  #end
}