package stx.assert.makro.expr.ord;

import stx.makro.expr.HComplexType as HComplexTypeT;

class HComplexType extends OrdCls<HComplexTypeT>{
  public function new(){}
  public function comply(lhs:HComplexTypeT,rhs:HComplexTypeT){
    return switch([lhs,rhs]){
      // case [TPath(pI),TPath(pII)]                           : 
      //   new stx.assert.makro.expr.ord.HTypePath().comply(pI,pII);
      // case [TFunction(argsI,retI),TFunction(argsII,retII)]  : 
      //   var ord = Ord.Array(this).comply(argsI,argsII);
      //   if(ord.is_not_less_than()){
      //     ord = comply(retI,retII);
      //   }
      //   ord;
      // case [TAnonymous(fieldsI),TAnonymous(fieldsII)]       : 
      //   Ord.Cluster(new HField()).comply(fieldsI,fieldsII);
      // case [TParent(tI),TParent(tII)]                       : 
      //   comply(tI,tII);
      // case [TExtend(pI,fieldsI) ,TExtend(pII,fieldsII)]     : 
      //   var lset = RedBlackSet.make(Comparable.Anon(new stx.assert.makro.expr.eq.HTypePath(),new HTypePath()));
      //       lset = lset.concat(pI);
      //   var rset = RedBlackSet.make(Comparable.Anon(new stx.assert.makro.expr.eq.HTypePath(),new HTypePath()));
      //       rset = rset.concat(pII);
      //   var ord  = lset.less_than(rset);
      //   if(ord.is_not_less_than()){
      //     var lset = RedBlackSet.make(Comparable.Anon(new stx.assert.makro.expr.eq.HField(),new HField()));
      //       lset = lset.concat(fieldsI);
      //     var rset = RedBlackSet.make(Comparable.Anon(new stx.assert.makro.expr.eq.HField(),new HField()));
      //       rset = rset.concat(fieldsII);
      //     ord = lset.less_than(rset);
      //   }
      //   ord;
      // case [TOptional(tI),TOptional(tII)]                   : 
      //   comply(tI,tII);
      // case [TNamed(nI,tI),TNamed(nII,tII)]                  : 
      //   var ord = Ord.String().comply(nI,nII);
      //   if(ord.is_not_less_than()){
      //     ord = comply(tI,tII);
      //   }
      //   ord;
      // case [TIntersection(tlI),TIntersection(tlII)]         : 
      //   var lset = RedBlackSet.make(Comparable.Anon(new stx.assert.makro.expr.eq.HComplexType(),new HComplexType()));
      //       lset = lset.concat(tlI);
      //   var rset = RedBlackSet.make(Comparable.Anon(new stx.assert.makro.expr.eq.HComplexType(),new HComplexType()));
      //       rset = rset.concat(tlII);
      //   lset.less_than(rset);
      case [l,r]                                              : 
        Ord.EnumValueIndex().comply(l,r);
    }
  }
}