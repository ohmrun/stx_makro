package stx.g.lang;

class GFunctionCtr extends Clazz{
  static public function unit(){
    return new GFunctionCtr();
  }
  private function lift(self:GFunctionDef):GFunction{
    return GFunction.lift(self);
  }
  public function Make(args:GFunctionArgCtr->Cluster<GFunctionArg>,?ret,?expr,?params){
    return GFunction.make(
      args(GFunctionArgCtr.unit()),
      __.option(ret).map(f -> f(GComplexTypeCtr.unit())).defv(null),
      __.option(expr).map(f -> f(GExprCtr.unit())).defv(null),
      __.option(params).map(f -> f(GTypeParamDeclCtr.unit())).defv(null)
    );
  }
}
typedef GFunctionDef = {
	final args    : Cluster<GFunctionArg>;
	final ret     : Null<GComplexType>;
	final expr    : Null<GExpr>;
	final ?params : Cluster<GTypeParamDecl>;
}
@:using(stx.g.lang.GFunction.GFunctionLift)
@:forward abstract GFunction(GFunctionDef) from GFunctionDef to GFunctionDef{
  static public var __(default,never) = new GFunctionCtr();
  static public var _(default,never) = GFunctionLift;
  public function new(self) this = self;
  static public function lift(self:GFunctionDef):GFunction return new GFunction(self);
  static public function make(args:Cluster<GFunctionArg>,?ret:GComplexType,?expr:GExpr,?params:Cluster<GTypeParamDecl>){
    return lift({
      args    : args,
      ret     : ret,
      expr    : expr,
      params  : params
    });
  }
  public function prj():GFunctionDef return this;
  private var self(get,never):GFunction;
  private function get_self():GFunction return lift(this);
  
  public function toSource():GSource{
		return Printer.ZERO.printFunction(this);
	}
}
class GFunctionLift{
  #if macro
  static public function to_macro_at(self:GFunction,pos:Position):Function{
    return {
      args    : self.args.map(arg -> arg.to_macro_at(pos)).prj(),
      ret     : __.option(self.ret).map(ret -> ret.to_macro_at(pos)).defv(null),
      expr    : __.option(self.expr).map(x -> x.to_macro_at(pos)).defv(null),
      params  : __.option(self.params).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([])
    }
  }
  #end 
}