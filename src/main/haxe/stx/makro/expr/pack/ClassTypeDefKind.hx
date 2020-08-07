package stx.makro.expr.pack;

abstract ClassTypeDefKind(TypeDefKind) from TypeDefKind to TypeDefKind{
  static public function lift(self:TypeDefKind){
    return new ClassTypeDefKind(self);
  }
  public function new(self) this = self;
  
  static public function make(?super_class:TypePath,?interfaces,?is_interface=false,?is_final=false):ClassTypeDefKind{
    return lift(TDClass(super_class,__.option(interfaces).defv([]),is_interface,is_final));
  }
}