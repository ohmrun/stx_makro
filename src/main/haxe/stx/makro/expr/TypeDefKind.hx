package stx.makro.expr;

import stx.makro.alias.StdTypeDefKind in TypeDefKindT;

abstract TypeDefKind(TypeDefKindT) from TypeDefKindT to TypeDefKindT{
  public function new(self) this = self;
  static public function lift(self:TypeDefKindT):TypeDefKind return new TypeDefKind(self);
  

  

  public function prj():TypeDefKindT return this;
  private var self(get,never):TypeDefKind;
  private function get_self():TypeDefKind return lift(this);
}