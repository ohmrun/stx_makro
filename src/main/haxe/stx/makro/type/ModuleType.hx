package stx.makro.type;

@:using(stx.makro.type.ModuleType.ModuleTypeLift)
abstract ModuleType(StdModuleType) from StdModuleType{
  static public var _(default,never) = ModuleTypeLift;
  public function new(self) this = self;
  
  public function getIdentity(){
    return Identity._.getModuleIdentity(this);
  }
}
class ModuleTypeLift{
  static public function getMeta(type:ModuleType){
    return getBaseType(type).meta.get();
  }
  static public function getBaseType(type:ModuleType):BaseType{
    return switch(type){
      case TClassDecl(c)  : c.get();
      case TEnumDecl(e)   : e.get();
      case TTypeDecl(t)   : t.get();
	    case TAbstract(a)   : a.get();
    }
  }
}