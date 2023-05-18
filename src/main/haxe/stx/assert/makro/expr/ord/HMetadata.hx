package stx.assert.makro.expr.ord;

import stx.makro.expr.HMetadata as HMetadataT;

class HMetadata extends OrdCls<HMetadataT>{
  public function new(){}
  public function comply(lhs:HMetadataT,rhs:HMetadataT){
    return Ord.Cluster(new HMetadataEntry()).comply(lhs.prj(),rhs.prj());
  }
}