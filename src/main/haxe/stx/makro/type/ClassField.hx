package stx.makro.type;

import haxe.macro.Type.ClassField in ClassFieldT;

abstract ClassField(ClassFieldT) from ClassFieldT to ClassFieldT{
  public function new(self){
    this = self;
  }
}