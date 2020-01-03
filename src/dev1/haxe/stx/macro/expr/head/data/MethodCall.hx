package stx.macro.expr.head.data;

import stx.macro.core.pack.MethodRef in MethodRefA;

typedef MethodCall = {
  var data : MethodRefA;
  var args : Array<Expr>;
}