package stx.assert.g.eq;

import stx.g.lang.expr.GStringLiteralKind as GStringLiteralKindT;

class GStringLiteralKind extends stx.assert.eq.term.Base<GStringLiteralKindT> {
  public function comply(lhs:GStringLiteralKindT,rhs:GStringLiteralKindT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}