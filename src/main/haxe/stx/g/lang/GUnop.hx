package stx.g.lang;

enum GUnopSum{
  GOpIncrement;//`++`
  GOpDecrement;//`--`
  GOpNot;//`!`
  GOpNeg;//`-`
  GOpNegBits;//`~`
  GOpSpread;//`...`
}
abstract GUnop(GUnopSum) from GUnopSum to GUnopSum{
  public function new(self) this = self;
  static public function lift(self:GUnopSum):GUnop return new GUnop(self);

  public function prj():GUnopSum return this;
  private var self(get,never):GUnop;
  private function get_self():GUnop return lift(this);
}
