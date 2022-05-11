package stx.assert.g.ord;

import stx.g.lang.expr.GEFieldKind as GEFieldKindT;

class GEFieldKind extends OrdCls<GEFieldKindT>{
  public function new(){}
  public function comply(lhs:GEFieldKindT,rhs:GEFieldKindT){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}