package stx.makro.expr;

typedef HExprArrayDef = Array<HExpr>;

@:forward abstract HExprArray(HExprArrayDef) from HExprArrayDef{
  public function new(self) this = self;
  static public function lift(self:HExprArrayDef):HExprArray return new HExprArray(self);
  static public function unto(self:Array<StdExpr>):HExprArray{
    return lift(self.map(HExpr.fromExpr));
  }

  public function toExprArray():Array<haxe.macro.Expr>{
    return this.map(x -> x.toExpr());
  } 

  public function prj():HExprArrayDef return this;
  private var self(get,never):HExprArray;
  private function get_self():HExprArray return lift(this);
}