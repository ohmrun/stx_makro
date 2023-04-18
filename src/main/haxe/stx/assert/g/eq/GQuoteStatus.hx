package stx.assert.g.eq;

import stx.g.lang.expr.GQuoteStatus as GQuoteStatusT;

class GQuoteStatus extends stx.assert.eq.term.Base<GQuoteStatusT> {
  public function comply(lhs:GQuoteStatusT,rhs:GQuoteStatusT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}