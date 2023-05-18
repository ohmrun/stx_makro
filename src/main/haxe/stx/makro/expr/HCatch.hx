package stx.makro.expr;

typedef HCatchDef = haxe.macro.Expr.Catch;

@:using(stx.makro.expr.HCatch.HCatchLift)
@:forward abstract HCatch(HCatchDef) from HCatchDef to HCatchDef{
  static public var _(default,never) = HCatchLift;
  public inline function new(self:HCatchDef) this = self;
  @:noUsing static inline public function lift(self:HCatchDef):HCatch return new HCatch(self);

  public function prj():HCatchDef return this;
  private var self(get,never):HCatch;
  private function get_self():HCatch return lift(this);
}
class HCatchLift{
  static public inline function lift(self:HCatchDef):HCatch{
    return HCatch.lift(self);
  }
}