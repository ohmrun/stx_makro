package stx.makro.type.pack;

import haxe.macro.Type.BaseType in BaseTypeT;
import stx.makro.type.body.BaseTypes;

@:forward abstract BaseType(BaseTypeT) from BaseTypeT to BaseTypeT{
  public function new(self){
    this = self;
  }
  public function getParams():Array<Type>{
    return BaseTypes.getParamTypes(this);
  }
  public function hasPack():Bool{
    return BaseTypes.hasPack(this);
  }
  public function getModule(){
    return BaseTypes.getModule(this);
  }
}