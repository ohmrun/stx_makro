package stx.makro.type.pack;


import stx.makro.type.body.Identities;
import stx.makro.type.body.ModuleTypes;

abstract ModuleType(StdModuleType) from StdModuleType{
  public function new(self) this = self;
  
  public function getBaseType(){
    return ModuleTypes.getBaseType(this);
  }
  public function getMeta(){
    return ModuleTypes.getMeta(this);
  }
  public function getIdentity(){
    return Identities.getModuleIdentity(this);
  }
}