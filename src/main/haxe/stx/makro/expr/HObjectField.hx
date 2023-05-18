package stx.makro.expr;

@:using(stx.makro.expr.HObjectField.HObjectFieldLift)
@:forward abstract HObjectField(haxe.macro.Expr.ObjectField) from haxe.macro.Expr.ObjectField to haxe.macro.Expr.ObjectField{
  static public var _(default,never) = HObjectFieldLift;
  public inline function new(self:haxe.macro.Expr.ObjectField) this = self;
  @:noUsing static inline public function lift(self:haxe.macro.Expr.ObjectField):HObjectField return new HObjectField(self);

  public function prj():haxe.macro.Expr.ObjectField return this;
  private var self(get,never):HObjectField;
  private function get_self():HObjectField return lift(this);
}
class HObjectFieldLift{
  static public inline function lift(self:haxe.macro.Expr.ObjectField):HObjectField{
    return HObjectField.lift(self);
  }
}