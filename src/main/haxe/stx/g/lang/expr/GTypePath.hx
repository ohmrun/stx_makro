package stx.g.lang.expr;

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
      sub,
      __.option(params).map(f -> f(GTypeParamCtr.unit())).defv(null)
    );
  }
  public function fromIdent(ident:Ident){
    return Make(ident.name,ident.pack);
  }
  public function fromString(str:String){
    var arr   = str.split(".");
    var name  = arr.pop();
    return Make(name,arr);
  }
}
typedef GTypePathDef = {
  final name      : String;
	final pack      : Cluster<String>;
	final ?sub      : Null<String>;
  final ?params   : Cluster<GTypeParam>;
}
@:using(stx.g.lang.expr.GTypePath.GTypePathLift)
@:forward abstract GTypePath(GTypePathDef) from GTypePathDef to GTypePathDef{
  static public var __(default,never) = new GTypePathCtr();
  public function new(self) this = self;
  static public function lift(self:GTypePathDef):GTypePath return new GTypePath(self);
  @:noUsing static public function make(name,?pack,?sub,?params){
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

  @:from static public function fromString(self){
    return GTypePath.__.fromString(self);
  }
  public function toSource():GSource{
		return Printer.ZERO.printTypePath(this);
	}
}
class GTypePathLift{
  static public function to_macro_at(self:GTypePath,pos:Position):TypePath{
    return {
      name    : self.name,
      pack    : __.option(self.pack).map(x -> x.prj()).defv([]),
      params  : __.option(self.params).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([]),
      sub     : self.sub
    }
  } 
}
