package stx.makro.type;

import haxe.macro.Type.ClassField in ClassFieldT;

@:forward abstract ClassField(ClassFieldT) from ClassFieldT to ClassFieldT{
  public function new(self){
    this = self;
  }
}