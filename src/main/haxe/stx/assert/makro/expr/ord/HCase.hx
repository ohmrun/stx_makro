package stx.assert.makro.expr.ord;

import stx.makro.expr.HCase as HCaseT;

class HCase extends OrdCls<HCaseT>{
  final HExpr : Eq<stx.makro.expr.HExpr>;
  public function new(HExpr){
    this.HExpr = HExpr;
  }
  public function comply(lhs:HCaseT,rhs:HCaseT){
    var r = Ord.Cluster(new stx.assert.makro.expr.ord.Expr()).comply(lhs.values,rhs.values);
    if(r.is_not_less_than()){
      r =  Ord.NullOr(new stx.assert.makro.expr.ord.Expr()).comply(lhs.guard,rhs.guard);
      if(r.is_not_less_than()){
        r =  Ord.NullOr(new stx.assert.makro.expr.ord.Expr()).comply(lhs.expr,rhs.expr);
      }
      r;
    }
    return r;
  }
}