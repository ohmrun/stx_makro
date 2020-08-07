package stx.makro.expr.body;

import stx.makro.head.data.CaseState;

class Cases{
  static public function foldKeys<T>(m:Monoid<T>,c:Case):Continuation<T,Expr>{
    return function(constructor){
      var values = c.values.fold(
        (next,memo) -> m.plus(constructor(next),memo),
        m.unit()
      );
      var guard  = c.guard == null ? m.unit() : constructor(c.guard);

      var expr   = c.expr == null ? m.unit() : constructor(c.expr);

      return m.plus(m.plus(values,guard),expr);
    } 
  }
}