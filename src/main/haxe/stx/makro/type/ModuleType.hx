package stx.makro.type;

@:using(stx.makro.type.ModuleType.ModuleTypeLift)
@:forward abstract ModuleType(haxe.macro.Type.ModuleType) from haxe.macro.Type.ModuleType{
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