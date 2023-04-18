package stx.assert.g.eq;

import stx.g.lang.expr.GTypeParam as GTypeParamT;

class GTypeParam extends stx.assert.eq.term.Base<GTypeParamT> {
  public function comply(lhs:GTypeParamT,rhs:GTypeParamT){
    return switch([lhs,rhs]){
	    case [GTPType(tI),GTPType(tII)]   : new GComplexType().comply(tI,tII);
	    case [GTPExpr(eI),GTPExpr(eII)]   : new GExpr().comply(eI,eII);
      default : Eq.EnumValueIndex().comply(lhs,rhs);
    }
  }
}