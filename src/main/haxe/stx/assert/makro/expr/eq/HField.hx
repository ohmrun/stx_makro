package stx.assert.makro.expr.eq;

import stx.makro.expr.HField as THField;

class HField extends stx.assert.eq.term.Base<THField> {
  public function comply(lhs:THField,rhs:THField){
    var eq = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_ok()){
      eq = new HFieldType().comply(lhs.kind,rhs.kind);
    }
    if(eq.is_ok()){
      final ctr = () -> RedBlackSet.make(Comparable.Anon(new HAccess(),new stx.assert.makro.expr.ord.HAccess()));
      var lset = ctr();
          lset = lset.concat(__.option(lhs.access).defv([]));
      var rset = ctr();
          rset = rset.concat(__.option(rhs.access).defv([]));
      eq = lset.equals(rset);
    }
    if(eq.is_ok()){
      eq = new HFieldType().comply(lhs.kind,rhs.kind);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(new HMetadata()).comply(lhs.meta,rhs.meta);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.String()).comply(lhs.doc,rhs.doc);
    }
    return eq;
  }
}