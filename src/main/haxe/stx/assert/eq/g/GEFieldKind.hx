package stx.assert.eq.g;

import stx.g.lang.expr.GEFieldKind as GEFieldKindT;

class GEFieldKind implements EqApi<GEFieldKindT> extends Clazz{
  public function comply(lhs:GEFieldKindT,rhs:GEFieldKindT){
    return Eq.EnumValue().comply(lhs,rhs);
  }
}