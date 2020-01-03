package stx.makro.expr.head.data;

import stx.makro.core.pack.MethodRef in MethodRefA;

typedef MethodCall = {
  var data : MethodRefA;
  var args : Array<Expr>;
}