package stx.makro.pack;

import stx.makro.body.Types;

import haxe.macro.Type in TypeT;

@:forward abstract Type(TypeT) from TypeT to TypeT{
  public function new(self){
    this = self;
  }
  public function getModule():Option<Module>{
    return Types.getModule(this);
  }
  public function isAnonymous(){
    return Types.isAnonymous(this);
  }
  public function isInStdType(){
    return Types.isInStdType(this);
  }
  public function followWithAbstracts(){
    return Context.followWithAbstracts(this);
  }
  public function follow(){
    return Context.follow(this);
  }
  public function getTypeVars(){
    return Types.getTypeVars(this);
  }
  public function getIdentity(){
    return Identities.getTypeIdentity(this);
  }
  public function getMeta(){
    return Types.getMeta(this);
  }
  public function getBaseType(){
    return Types.getBaseType(this);
  }
}
