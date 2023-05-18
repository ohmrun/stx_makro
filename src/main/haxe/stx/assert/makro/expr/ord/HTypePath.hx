package stx.assert.makro.expr.ord;

import stx.makro.expr.HTypePath as HTypePathT;

class HTypePath extends OrdCls<HTypePathT>{
  public function new(){}
  public function comply(lhs:HTypePathT,rhs:HTypePathT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = Ord.Cluster(Ord.String()).comply(lhs.pack,rhs.pack);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.String()).comply(lhs.sub,rhs.sub);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Cluster(new HTypeParam())).comply(lhs.params,rhs.params);
    }
    return ord;
  }
}