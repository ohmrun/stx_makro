package stx.makro.expr;

//@:using(stx.makro.expr.Constant.ConstantLift)
abstract Constant(StdConstant) from StdConstant to StdConstant{
  static public var _(default,never) = ConstantLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:StdConstant) return new Constant(self);

  @:noUsing static public function CString(str:String):Constant{
    return lift(StdConstant.CString(str));
  }
  @:noUsing static public function CIdent(str:String):Constant{
    return lift(StdConstant.CIdent(str));
  }
}
class ConstantLift{
  
}