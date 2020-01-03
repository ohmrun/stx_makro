package stx.macro.type.pack;

import haxe.macro.Type.ClassField in ClassFieldT;

abstract ClassField(ClassFieldT) from ClassFieldT to ClassFieldT{
  public function new(self){
    this = self;
  }
}