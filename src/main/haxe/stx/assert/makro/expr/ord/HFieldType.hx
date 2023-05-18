package stx.assert.makro.expr.ord;

import stx.makro.expr.HFieldType as HFieldTypeT;

class HFieldType extends OrdCls<HFieldTypeT>{
  public function new(){}
  public function comply(lhs:HFieldTypeT,rhs:HFieldTypeT){
    return switch([lhs,rhs]){
      // case [FVar(tI,eI),FVar(tII,eII)] : 
      //   var ord = Ord.NullOr(new HComplexType()).comply(tI,tII);
      //   if(ord.is_not_less_than()){
      //     ord = Ord.NullOr(new stx.assert.makro.expr.ord.Expr().comply(eI,eII);
      //   }
      //   ord;
      // case [FFun(fI),FFun(fII)] : 
      //   new HFunction().comply(fI,fII);
      // case [FProp(getI,setI,tI,eI),FProp(getII,setII,tII,eII)] : 
      //   var ord = new HPropAccess().comply(getI,getII);
      //   if(ord.is_not_less_than()){
      //     ord = new HPropAccess().comply(setI,setII);
      //   }
      //   if(ord.is_not_less_than()){
      //     ord = Ord.NullOr(new HComplexType()).comply(tI,tII);
      //   }
      //   if(ord.is_not_less_than()){
      //     ord = Ord.NullOr(new stx.assert.makro.expr.ord.Expr().comply(eI,eII);
      //   }
      //   ord;
      default : 
        Ord.EnumValueIndex().comply(lhs,rhs);
    }
  }
}