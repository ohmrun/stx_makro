package stx.fail;

enum MacroTypeFailureSum{
  E_MacroType_TDynamicNull;
}
abstract MacroTypeFailure(MacroTypeFailureSum) from MacroTypeFailureSum to MacroTypeFailureSum{
  public function new(self) this = self;
  static public function lift(self:MacroTypeFailureSum):MacroTypeFailure return new MacroTypeFailure(self);

  public function prj():MacroTypeFailureSum return this;
  private var self(get,never):MacroTypeFailure;
  private function get_self():MacroTypeFailure return lift(this);
}
