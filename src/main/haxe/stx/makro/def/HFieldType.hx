package stx.makro.def;

@:using(stx.makro.def.HFieldType.HFieldTypeLift)
abstract HFieldType(StdFieldType) from StdFieldType to StdFieldType{
  static public var _(default,never) = HFieldTypeLift;
  public inline function new(self:StdFieldType) this = self;
  static inline public function lift(self:StdFieldType):HFieldType return new HFieldType(self);

  public function prj():StdFieldType return this;
  private var self(get,never):HFieldType;
  private function get_self():HFieldType return lift(this);

  static public function FVar( t : Null<HComplexType>, ?e : Null<HExpr> ){
    return lift(StdFieldType.FVar(__.option(t).map((t:HComplexType) -> t.prj()).defv(null),__.option(e).map(e -> e.prj()).defv(null)));
}
	static public function FFun( f : HFunction ){
    return lift(StdFieldType.FFun(f.prj()));
  }
	static public function FProp( get : HPropAccess, set : HPropAccess, ?t : Null<HComplexType>, ?e : Null<HExpr> ){
    return lift(StdFieldType.FProp(get.getting(),set.setting(),__.option(t).map((t:HComplexType) -> t.prj()).defv(null),__.option(e).map(e -> e.prj()).defv(null)));
  }
}
class HFieldTypeLift{
  static public inline function lift(self:StdFieldType):HFieldType{
    return HFieldType.lift(self);
  }
}