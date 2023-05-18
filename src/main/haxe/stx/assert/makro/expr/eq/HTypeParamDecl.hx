package stx.assert.makro.expr.eq;

import stx.makro.expr.HTypeParamDecl as THTypeParamDecl;

class HTypeParamDecl extends stx.assert.eq.term.Base<THTypeParamDecl> {
  public function comply(lhs:THTypeParamDecl,rhs:THTypeParamDecl){
    var eq = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Cluster(new HComplexType())).comply(lhs.constraints,rhs.constraints);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Cluster(new HTypeParamDecl())).comply(lhs.params,rhs.params);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(new HMetadata()).comply(lhs.meta,rhs.meta);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(new HComplexType()).comply(lhs.defaultType,rhs.defaultType);
    }
    return eq;
  }
}