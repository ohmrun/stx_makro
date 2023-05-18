package stx.makro.expr;

typedef HVarDef = haxe.macro.Expr.Var;

@:using(stx.makro.expr.HVar.HVarLift)
@:forward abstract HVar(HVarDef) from HVarDef to HVarDef{
  static public var _(default,never) = HVarLift;
  public inline function new(self:HVarDef) this = self;
  @:noUsing static inline public function lift(self:HVarDef):HVar return new HVar(self);

  public function prj():HVarDef return this;
  private var self(get,never):HVar;
  private function get_self():HVar return lift(this);
}
class HVarLift{
  static public inline function lift(self:HVarDef):HVar{
    return HVar.lift(self);
  }
}