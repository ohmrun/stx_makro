package stx.makro.expr;

typedef ExprArrayDef = Array<Expr>;

@:forward abstract ExprArray(ExprArrayDef) from ExprArrayDef to ExprArrayDef{
  public function new(self) this = self;
  static public function lift(self:ExprArrayDef):ExprArray return new ExprArray(self);
  static public function unto(self:Array<StdExpr>):ExprArray{
    return lift(self.map(Expr.lift));
  }

  

  public function prj():ExprArrayDef return this;
  private var self(get,never):ExprArray;
  private function get_self():ExprArray return lift(this);
}