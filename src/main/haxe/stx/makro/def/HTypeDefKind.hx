package stx.makro.def;

@:forward abstract HTypeDefKind(StdTypeDefKind) from StdTypeDefKind to StdTypeDefKind{
  public function new(self) this = self;
  static public function lift(self:StdTypeDefKind):TypeDefKind return new HTypeDefKind(self);
  
  @:noUsing static public function Structure(){
    return lift(TDStructure);
  }
  @:noUsing static public function Enum(){
    return lift(TDEnum);
  }
  @:noUsing static public function Class(?super_class:HTypePath,?interfaces:Cluster<HTypePath>,?is_interface:Bool,?is_final:Bool,?is_abstract:Bool){
    return lift(TDClass(super_class.prj(),__.option(interfaces).defv([].imm()).prj(),is_interface,is_final,is_abstract));
  }
  @:noUsing static public function Alias(ct:HComplexType):HTypeDefKind{
    return lift(TDAlias(ct));
  }
  @:from static public function fromHComplexType(self:HComplexType):HTypeDefKind{
    return Alias(self);
  }
  static public function Abstract(?thiz:HComplexType,?from:Cluster<HComplexType>,?to:Cluster<HComplexType>):HTypeDefKind{
    return lift(TDAbstract(thiz,from.prj(),to.prj()));
  }

  public function prj():StdTypeDefKind return this;
  private var self(get,never):TypeDefKind;
  private function get_self():TypeDefKind return lift(this);
}