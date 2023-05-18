package stx.assert.makro.expr.ord;

import haxe.macro.Expr.StringLiteralKind as TStringLiteralKind;

class StringLiteralKind extends OrdCls<TStringLiteralKind>{
  public function new(){}
  public function comply(lhs:TStringLiteralKind,rhs:TStringLiteralKind){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}