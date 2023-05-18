package stx.assert.makro.expr.ord;

import haxe.macro.Expr.Unop as UnopT;

class Unop extends OrdCls<UnopT>{
  public function new(){}
  public function comply(lhs:UnopT,rhs:UnopT){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}