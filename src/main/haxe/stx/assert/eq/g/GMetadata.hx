package stx.assert.eq.g;

import stx.g.lang.expr.GMetadata as GMetadataT;

class GMetadata implements EqApi<GMetadataT> extends Clazz{
  public function comply(lhs:GMetadataT,rhs:GMetadataT){
    return Eq.Cluster(new GMetadataEntry()).comply(lhs,rhs);
  }
}