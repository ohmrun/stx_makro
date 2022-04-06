package stx.g.lang;

class GTypeDefKindCtr extends Clazz{
  static public function unit(){
    return new GTypeDefKindCtr();
  }
  private function lift(self:GTypeDefKindSum):GTypeDefKind{
    return GTypeDefKind.lift(self);
  }
  public function Enum(){
    return lift(GTDEnum);
  }
  public function Structure(){
    return lift(GTDStructure);
  }
  public function Class(?superClass : GTypePathCtr -> GTypePath, ?interfaces : GTypePathCtr -> Cluster<GTypePath>, ?isInterface, ?isFinal){
    return lift(GTDClass(
      __.option(superClass).map(f -> f(GTypePath.__)).defv(null),
      __.option(interfaces).map(f -> f(GTypePath.__)).defv(null),
      isInterface,
      isFinal
    ));
  }
  public function Alias(t){
    return lift(GTDAlias(t(GComplexType.__)));
  }
  public function Abstract(tthis,?from,?to){
    return lift(GTDAbstract(
      __.option(tthis).map(f -> f(GComplexType.__)).defv(null),
      __.option(from).map(f -> f(GComplexType.__)).defv(null),
      __.option(to).map(f -> f(GComplexType.__)).defv(null)
    ));
  }
}
enum GTypeDefKindSum {
	GTDEnum;
	GTDStructure;
	GTDClass( ?superClass : GTypePath, ?interfaces : Cluster<GTypePath>, ?isInterface : Bool, ?isFinal : Bool );
	GTDAlias( t : GComplexType ); // ignore TypeDefinition.fields
	GTDAbstract( tthis : Null<GComplexType>, ?from : Cluster<GComplexType>, ?to: Cluster<GComplexType> );
}
abstract GTypeDefKind(GTypeDefKindSum) from GTypeDefKindSum to GTypeDefKindSum{
  static public var __(default,never) = new GTypeDefKindCtr();
  public function new(self) this = self;
  static public function lift(self:GTypeDefKindSum):GTypeDefKind return new GTypeDefKind(self);

  public function prj():GTypeDefKindSum return this;
  private var self(get,never):GTypeDefKind;
  private function get_self():GTypeDefKind return lift(this);
}