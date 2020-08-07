package stx.makro.type.pack;

import stx.makro.alias.StdClassType;
import stx.makro.type.body.ClassTypes;

@:forward abstract ClassType(StdClassType) from StdClassType to StdClassType{
  public function new(self){
    this = self;
  }
  public function interfaces(?ancestors){
    return ClassTypes.interfaces(this,ancestors);
  }
  public function prj():StdClassType{
    return this;
  }
  @:to public function toBaseType():BaseType{
    return this;
  }
}