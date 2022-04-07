package stx.g.lang;

class GFunctionArgCtr extends Clazz{
  static public function unit(){
    return new GFunctionArgCtr();
  }
  private function lift(self:GFunctionArgDef):GFunctionArg{
    return GFunctionArg.lift(self);
  }
  public function Make(name:String,type:GComplexTypeCtr->GComplexType,?opt:Bool,?value:GExprCtr->GExpr,?meta:GMetadataEntryCtr->GMetadata){
    return lift({
      name  : name,
      type  : type(GComplexType.__),
      opt   : opt,
      value : __.option(value).map(f -> f(GExpr.__)).defv(null),
      meta  : __.option(meta).map(f -> f(GMetadataEntry.__)).defv(null)
    });
  }
}
typedef GFunctionArgDef = {
	final name    : String;
  final type    : Null<GComplexType>;
	final ?opt    : Bool;
	final ?value  : Null<GExpr>;
	final ?meta   : GMetadata;
}
@:forward abstract GFunctionArg(GFunctionArgDef) from GFunctionArgDef to GFunctionArgDef{
  public function new(self) this = self;
  static public function lift(self:GFunctionArgDef):GFunctionArg return new GFunctionArg(self);
  static public function make(name:String,type:GComplexType,?opt:Bool,?value:GExpr,?meta:GMetadata){
    return lift({
      name    : name,
      type    : type,
      opt     : opt,
      value   :value,
      meta  : meta
    });
  }
  public function prj():GFunctionArgDef return this;
  private var self(get,never):GFunctionArg;
  private function get_self():GFunctionArg return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printFunctionArg(this);
	}
}