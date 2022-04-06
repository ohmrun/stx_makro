package stx.g.lang;

class GCaseCtr extends Clazz{
  static public function unit(){
    return new GCaseCtr();
  }
  private function lift(self:GCaseDef):GCase{
    return GCase.lift(self);
  }
  public function Make(values:GExprCtr->Cluster<GExpr>,?guard:GExprCtr->GExpr,?expr:GExprCtr->GExpr){
    final ctr = GExprCtr.unit();
    return GCase.make(
      values(ctr),
      __.option(guard).map(f -> f(ctr)).defv(null),
      __.option(expr).map(f -> f(ctr)).defv(null)
    );
  }
}
typedef GCaseDef = {
	final values:Cluster<GExpr>;
	final ?guard:GExpr;
	final ?expr:GExpr;
}
@:forward abstract GCase(GCaseDef) from GCaseDef to GCaseDef{
  static public var __(default,never) = new GCaseCtr();
  public function new(self) this = self;
  static public function lift(self:GCaseDef):GCase return new GCase(self);
  static public function make(values:Cluster<GExpr>,?guard:GExpr,?expr:GExpr){
    return lift({
      values  : values,
      guard   : guard,
      expr    : expr 
    });
  }
  public function prj():GCaseDef return this;
  private var self(get,never):GCase;
  private function get_self():GCase return lift(this);
}