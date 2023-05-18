package stx.assert.makro.expr.eq;

import stx.makro.expr.HTypeParam as HTypeParamT;

class HTypeParam extends stx.assert.eq.term.Base<HTypeParamT> {
  public function comply(lhs:HTypeParamT,rhs:HTypeParamT){
    return switch([lhs,rhs]){
	    case [TPType(tI),TPType(tII)]     : new HComplexType().comply(tI,tII);
	    case [TPExpr(eI),TPExpr(eII)]     : new stx.assert.makro.expr.eq.Expr().comply(eI,eII);
      default                           : Eq.EnumValueIndex().comply(lhs,rhs);
    }
  }
}