package stx.assert.ord.g;

import stx.g.lang.expr.GEFieldKind as GEFieldKindT;

class GEFieldKind extends OrdCls<GEFieldKindT>{
  public function new(){}
  public function comply(lhs:GEFieldKindT,rhs:GEFieldKindT){
    return Ord.EnumValue().comply(lhs,rhs);
  }
}