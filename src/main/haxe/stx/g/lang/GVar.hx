package stx.g.lang;


class GVarCtr extends Clazz{
	static public function unit(){
		return new GVarCtr();
	}
	private function lift(self:GVarDef):GVar{
		return GVar.lift(self);
	}
	public function Make(name:String,?type:GComplexTypeCtr->GComplexType,?expr:GExprCtr->GExpr,?meta:GMetadataEntryCtr->GMetadata,?isFinal,?isStatic){
		return GVar.make(
			name,
			__.option(type).map(f -> f(GComplexType.__)).defv(null),
			__.option(expr).map(f -> f(GExpr.__)).defv(null),
			__.option(meta).map(f -> f(GMetadataEntry.__)).defv(null),
			isFinal,
			isStatic
		);
	}
} 
typedef GVarDef = {
	final name:String;
	final ?type:GComplexType;
	final ?expr:GExpr;
	final ?meta:GMetadata;
	final ?isFinal:Bool;
	final ?isStatic:Bool;
}
@:forward abstract GVar(GVarDef) from GVarDef to GVarDef{
	static public var __(default,never) = new GVarCtr();
  public function new(self) this = self;
  static public function lift(self:GVarDef):GVar return new GVar(self);
	static public function make(name:String,?type:GComplexType,?expr,?meta:GMetadata,?isFinal = false,?isStatic = true){
		return lift({
			name 				: name,
			type 				: type,
			expr 				: expr,
			isFinal 		: isFinal,
			isStatic 		: isStatic,
			meta 				: meta
		});
	}
  public function prj():GVarDef return this;
  private var self(get,never):GVar;
  private function get_self():GVar return lift(this);
}
