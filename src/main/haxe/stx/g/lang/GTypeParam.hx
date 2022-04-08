package stx.g.lang;

class GTypeParamCtr extends Clazz{
  static public function unit(){
    return new GTypeParamCtr();
  }
  private function lift(self:GTypeParamSum){
    return GTypeParam.lift(self);
  }
  public function CType(type:GComplexType){
    return lift(GTPType(type));
  }
  public function ComplexType(type:GComplexType){
    return lift(GTPType(type));
  }
  public function Expr(expr:GExpr){
    return lift(GTPExpr(expr));
  }
}
enum GTypeParamSum {
	GTPType( t : GComplexType );
	GTPExpr( e : GExpr );
}
@:using(stx.g.lang.GTypeParam.GTypeParamLift)
abstract GTypeParam(GTypeParamSum) from GTypeParamSum to GTypeParamSum{
  public function new(self) this = self;
  static public function lift(self:GTypeParamSum):GTypeParam return new GTypeParam(self);

  public function prj():GTypeParamSum return this;
  private var self(get,never):GTypeParam;
  private function get_self():GTypeParam return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printTypeParam(this);
	}
}
class GTypeParamLift{
  #if macro
  static public function to_macro_at(self:GTypeParam,pos:Position):TypeParam{
    return switch(self){
      case GTPType( t ) : TPType(t.to_macro_at(pos));
	    case GTPExpr( e ) : TPExpr(e.to_macro_at(pos));
    }
  }
  #end
}