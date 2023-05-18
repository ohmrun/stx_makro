package stx.makro.expr;

typedef HCaseDef = haxe.macro.Expr.Case;

@:using(stx.makro.expr.HCase.HCaseLift)
@:forward abstract HCase(HCaseDef) from HCaseDef to HCaseDef{
  static public var _(default,never) = HCaseLift;
  public inline function new(self:HCaseDef) this = self;
  @:noUsing static inline public function lift(self:HCaseDef):HCase return new HCase(self);

  public function prj():HCaseDef return this;
  private var self(get,never):HCase;
  private function get_self():HCase return lift(this);
}
class HCaseLift{
  static public inline function lift(self:HCaseDef):HCase{
    return HCase.lift(self);
  }
} 