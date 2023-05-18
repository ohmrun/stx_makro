package stx.assert.makro.expr.eq;

import stx.makro.expr.HMetadata as THMetadata;

class HMetadata extends stx.assert.eq.term.Base<THMetadata> {
  public function comply(lhs:THMetadata,rhs:THMetadata){
    return Eq.Array(new HMetadataEntry()).comply(lhs,rhs);
  }
}