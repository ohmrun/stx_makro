package stx.assert.makro.expr.ord;

import stx.makro.expr.HTypeParam as HTypeParamT;

class HTypeParam extends OrdCls<HTypeParamT>{
  public function new(){}
  public function comply(lhs:HTypeParamT,rhs:HTypeParamT){
    return switch([lhs,rhs]){
	    case [TPType(tI),TPType(tII)]   : new HComplexType().comply(tI,tII);
	    case [TPExpr(eI),TPExpr(eII)]   : new stx.assert.makro.expr.ord.Expr().comply(eI,eII);
      default : Ord.EnumValueIndex().comply(lhs,rhs);
    }
  }
}