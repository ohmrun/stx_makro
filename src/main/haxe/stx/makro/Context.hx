package stx.makro;

class Context{
  static public inline function here(wildcard:Wildcard){
    return haxe.macro.Context.currentPos();
  }
    /*
  static public macro function mtype(e:Expr):ExprOf<Type>{
    var val = Context.typeof(e);
    var out = macro ${val};
    trace(out);
    return out;
  }*/
}