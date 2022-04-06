package stx.g.lang;

class GTypePathCtr extends Clazz{
  static public function unit(){
    return new GTypePathCtr();
  }
  private function lift(self:GTypePathDef):GTypePath{
    return GTypePath.lift(self);
  }
  public function Make(name:String,?pack,?sub:String,?params:GTypeParamCtr->Cluster<GTypeParam>){
    return GTypePath.make(
      name,
      __.option(pack).defv([].imm()),
      __.option(params).map(f -> f(GTypeParamCtr.unit())).defv(null),
      sub
    );
  }
}
typedef GTypePathDef = {
  final name      : String;
	final pack      : Cluster<String>;
  final ?params   : Cluster<GTypeParam>;
	final ?sub      : Null<String>;
}
@:forward abstract GTypePath(GTypePathDef) from GTypePathDef to GTypePathDef{
  static public var __(default,never) = new GTypePathCtr();
  public function new(self) this = self;
  static public function lift(self:GTypePathDef):GTypePath return new GTypePath(self);
  @:noUsing static public function make(name,?pack,?params,?sub){
    return lift({
      name      : name,
      pack      : pack,
      params    : params,
      sub       : sub
    });
  }
  public function prj():GTypePathDef return this;
  private var self(get,never):GTypePath;
  private function get_self():GTypePath return lift(this);
}
