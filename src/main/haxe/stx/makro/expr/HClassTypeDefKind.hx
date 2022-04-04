package stx.makro.expr;

@:using(stx.makro.expr.HClassTypeDefKind.HClassTypeDefKindLift)
@:forward abstract HClassTypeDefKind(TypeDefKind) from TypeDefKind to TypeDefKind{
  static public function lift(self:TypeDefKind){
    return new HClassTypeDefKind(self);
  }
  public function new(self) this = self;
  
  static public function make(?super_class:TypePath,?interfaces,?is_interface=false,?is_final=false):HClassTypeDefKind{
    return lift(TDClass(super_class,__.option(interfaces).defv([]),is_interface,is_final));
  }
}
class HClassTypeDefKindLift{

}