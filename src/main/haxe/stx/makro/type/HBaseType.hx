package stx.makro.type;

@:using(stx.makro.type.HBaseType.HBaseTypeLift)
@:forward abstract HBaseType(StdBaseType) from StdBaseType to StdBaseType{
  static public var _(default,never) = HBaseTypeLift;
  public function new(self){
    this = self;
  }
}
class HBaseTypeLift{
  static public function getParamTypes(b:BaseType):Array<Type>{
    return b.params.map((tp)->tp.t);
  }
  static public function getModule(b:BaseType):Module{
    return stx.makro.type.core.Module.lift({
      name    : b.name,
      pack    : Way.lift(b.pack),
      module  : None
    });
  }
  static public function hasPack(b:BaseType):Bool{
    return b.pack != null && b.pack.length > 0;
  }
  /**
    Returns false if the type is found in a module with a name different to the module.
  */
  static public function is_module_name_consistent(b:BaseType){
    var module_els = b.module.split(".");
    var out        = module_els[module_els.length-1] == b.name;
    return out;
  }
}