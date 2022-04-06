package stx.g.lang;

class GCatchCtr extends Clazz{
  static public function unit(){
    return new GCatchCtr();
  }
  private function lift(self:GCatchDef):GCatch{
    return GCatch.lift(self);
  }
  public function Make(name:String,expr:GExprCtr->GExpr,type:GComplexTypeCtr->GComplexType){
    return GCatch.make(
      name,
      expr(GExpr.__),
      __.option(type).map(f -> f(GComplexType.__)).defv(null)
    );
  }
}
typedef GCatchDef = {
	var name:String;
  var expr:GExpr;
	var ?type:GComplexType;
}
@:forward abstract GCatch(GCatchDef) from GCatchDef to GCatchDef{
  public function new(self) this = self;
  static public function lift(self:GCatchDef):GCatch return new GCatch(self);
  static public function make(name:String,expr:GExpr,?type:GComplexType){
    return lift({
      name  : name,
      expr  : expr,
      type  : type
    });
  }
  public function prj():GCatchDef return this;
  private var self(get,never):GCatch;
  private function get_self():GCatch return lift(this);
}

