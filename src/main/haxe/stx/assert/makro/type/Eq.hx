package stx.assert.makro.type;

import stx.assert.makro.type.eq.*;

class Eq extends Clazz{
  @:isVar public var HType(get,null):HType;
  private function get_HType():HType{
    return __.option(this.HType).def(() -> this.HType = new HType());
  }
  @:isVar public var HTypeParameter(get,null):HTypeParameter;
  private function get_HTypeParameter():HTypeParameter{
    return __.option(this.HTypeParameter).def(() -> this.HTypeParameter = new HTypeParameter());
  }
}