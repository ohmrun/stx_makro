package stx.macro.expr.body;

import stx.macro.head.data.CaseState;

class Cases{
  static public function foldKeys<T>(m:Monoid<T>,c:Case):Continuation<T,Expr>{
    return function(constructor){
      var values = c.values.fold(
        (next,memo) -> m.batch(constructor(next),memo),
        m.prior()
      );
      var guard  = c.guard == null ? m.prior() : constructor(c.guard);

      var expr   = c.expr == null ? m.prior() : constructor(c.expr);

      return m.batch(m.batch(values,guard),expr);
    } 
  }
}