package ;

import haxe.macro.Expr;

class Metah{
  /**
    Creates an accessor function for type at `e` at path `path`. Can use array access.
  */
  @:noUsing static public inline macro function dive(e:Expr,path:Expr){
    return ah.macro.Dive.macro_apply(e,path);
  }
  /*
    Creates a function Dynamic -> T for input ECheckType($type);
  */
  @:noUsing static public inline macro function entype<T>(expr:Expr):ExprOf<Dynamic->T>{
    return ah.macro.Entype.apply(expr);
  }
  /*
    Selects values for type on reference `from`  for type `def`.
  */
  @:noUsing macro static inline public function select(def:Expr,from:Expr){
    return ah.macro.Select.apply(def,from);
  }
}
