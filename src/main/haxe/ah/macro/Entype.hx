package ah.macro;

import ah.Exprs;
import haxe.macro.Expr;

@:keep class Entype{
  #if macro
  static public function apply(expr:Expr){
    return switch(expr.expr){
      case EParenthesis({ expr :  ECheckType({ expr : EConst(CIdent("_")), pos : _ }, ct ), pos : _ }) :
          macro function(x:Dynamic):$ct { return (x:$ct); }
      default : throw "entype requires form (_:$type), and produces a function Dynamic -> $type.";
    }
  }
  #end
}
