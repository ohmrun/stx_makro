package stx.macro;


using thx.Arrays;
using thx.Strings;

import stx.Macro;
import haxe.ds.Option;


import haxe.macro.Expr;

#if macro
  import tink.macro.Exprs in Tk;
  import Type in T;
  import haxe.macro.Expr;
  import tink.macro.Types;
  import haxe.macro.Type;
  import haxe.macro.Context;
#end

private enum Arity{
  AZero;
  AOne;
  ATwo;
  AThree;
}
class Exprs{
  #if macro
  static public function getType(e:Expr):Type{
    var type        = null;
    var path_maybe  = getEFieldPath(e);
    var path_name   = path_maybe.split(".").last();

    if(path_maybe!="" && path_name.substr(0,1).isUpperCase()){
      type = stx.macro.Types.findTypeByName(path_maybe);
    }else{
      type  = Context.typeof(e);
    }
    return type;
  }
  static public function toEFieldPath(str:String):Expr{
    var array = str.split(".");
    var head  = Tk.at(EConst(CIdent(array.first())));
    var rest  = array.dropLeft(1);
    return rest.foldLeft(head,
      function(memo,next){
        return Tk.at(EField(memo,next));
      }
    );
  }
  static public function getLastExprOfBlock(e:Expr):Null<Expr>{
    return switch e.expr {
      case EBlock(arr):
        arr[arr.length -1];
      default : e;
    }
  }
  static public function getEFieldPath(e:Expr){
    function rec(e:Expr,path:Array<String>){
      var next = path.copy();
      return switch (e.expr) {
        case EField(e,field)    :
          next.unshift(field);
          rec(e,next);
        case EConst(CIdent(s))  :
          next.unshift(s);
          next;
        default                 : [];
      }
    }
    return rec(e,[]).join(".");
  }
  #end
}
class Positions{
  #if macro
  static public inline function equals(l:Position,r:Position):Bool{
    return true;//(l.file == r.file) && (l.min == r.min) && (l.max == r.max);
  }
  #end
}
