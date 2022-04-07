package stx.g.lang;

class GFieldTypeCtr extends Clazz{
  static public function unit(){
    return new GFieldTypeCtr();
  }
  private function lift(self:GFieldTypeSum):GFieldType{
    return GFieldType.lift(self);
  }
  public function Var(?t:GComplexTypeCtr->GComplexType, ?e:GExprCtr -> GExpr){
    return lift(
      GFVar(
        __.option(t).map(f -> f(GComplexTypeCtr.unit())).defv(null),
        __.option(e).map(f -> f(GExprCtr.unit())).defv(null)
      )
    );
  }
  public function Fun(f:GFunctionCtr-> GFunction){
    return lift(GFFun(f(GFunctionCtr.unit())));
  }
  public function Prop(get:GPropAccess,set:GPropAccess,?t:GComplexTypeCtr->GComplexType,?e:GExprCtr->GExpr){
    return lift(GFProp(get,set,
      __.option(t).map(f -> f(GComplexType.__)).defv(null),
      __.option(e).map(f -> f(GExpr.__)).defv(null)
    ));
  }
}
enum GFieldTypeSum {
	GFVar( t : Null<GComplexType>, ?e : Null<GExpr> );
	GFFun( f : GFunction );
	GFProp( get : GPropAccess, set : GPropAccess, ?t : Null<GComplexType>, ?e : Null<GExpr> );
}
abstract GFieldType(GFieldTypeSum) from GFieldTypeSum to GFieldTypeSum{
  static public var __(default,never) = new GFieldTypeCtr();
  public function new(self) this = self;
  static public function lift(self:GFieldTypeSum):GFieldType return new GFieldType(self);

  public function prj():GFieldTypeSum return this;
  private var self(get,never):GFieldType;
  private function get_self():GFieldType return lift(this);

  // public function toSource():GSource{
	// 	return Printer.ZERO.printFieldType(this);
	// }
}
