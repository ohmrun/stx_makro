package stx.assert.makro.expr.eq;

import haxe.macro.Expr.Unop as UnopT;

class Unop extends EqCls<UnopT> {
  public function new(){}
  public function comply(lhs:UnopT,rhs:UnopT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}