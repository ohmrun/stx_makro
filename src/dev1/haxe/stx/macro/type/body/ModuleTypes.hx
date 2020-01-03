package stx.macro.type.body;

class ModuleTypes{
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