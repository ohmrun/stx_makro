package stx.makro.type.body;

import stx.makro.core.pack.Module;//TODO why?

class BaseTypes{
  static public function getParamTypes(b:BaseType):Array<Type>{
    return b.params.map((tp)->tp.t);
  }
  static public function getModule(b:BaseType):Module{
    return {
      name : b.name,
      pack : b.pack,
      module : None
    };
  }
  static public function hasPack(b:BaseType):Bool{
    return b.pack != null && b.pack.length > 0;
  }
  /**
    Returns false if the type is found in a module with a name different to the module.
  */
  static public function isModuleNameConsistent(b:BaseType){
    var module_els = b.module.split(".");
    var out        = module_els[module_els.length-1] == b.name;
    return out;
  }
  
}