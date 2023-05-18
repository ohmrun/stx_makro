package stx.assert.makro.expr.ord;

import stx.makro.expr.HMetadataEntry as HMetadataEntryT;

class HMetadataEntry extends OrdCls<HMetadataEntryT>{
  public function new(){}
  public function comply(lhs:HMetadataEntryT,rhs:HMetadataEntryT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Cluster(new stx.assert.makro.expr.ord.Expr())).comply(lhs.params,rhs.params);
    }
    return ord;
  }
}