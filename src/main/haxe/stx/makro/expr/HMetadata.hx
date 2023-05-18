package stx.makro.expr;

typedef HMetadataDef = haxe.macro.Expr.Metadata;

@:using(stx.makro.expr.HMetadata.HMetadataLift)
@:forward abstract HMetadata(HMetadataDef) from HMetadataDef to HMetadataDef{
  static public var _(default,never) = HMetadataLift;
  public inline function new(self:HMetadataDef) this = self;
  @:noUsing static inline public function lift(self:HMetadataDef):HMetadata return new HMetadata(self);

  public function prj():HMetadataDef return this;
  private var self(get,never):HMetadata;
  private function get_self():HMetadata return lift(this);
}
class HMetadataLift{
  static public inline function lift(self:HMetadataDef):HMetadata{
    return HMetadata.lift(self);
  }
}