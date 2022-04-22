package stx.assert.eq.g;

import stx.g.lang.expr.GQuoteStatus as GQuoteStatusT;

class GQuoteStatus implements EqApi<GQuoteStatusT> extends Clazz{
  public function comply(lhs:GQuoteStatusT,rhs:GQuoteStatusT){
    return Eq.EnumValue().comply(lhs,rhs);
  }
}