package stx.assert.g.eq;

import stx.g.lang.expr.GUnop as GUnopT;

class GUnop extends stx.assert.eq.term.Base<GUnopT> {
  public function comply(lhs:GUnopT,rhs:GUnopT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}