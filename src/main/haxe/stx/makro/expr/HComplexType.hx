package stx.makro.expr;

@:using(stx.makro.expr.HComplexType.HComplexTypeLift)
@:forward abstract HComplexType(StdComplexType) from StdComplexType to StdComplexType{
  public function new(self) this = self;
  static public function lift(self:StdComplexType):HComplexType return new HComplexType(self);

  public function prj():StdComplexType return this;
  private var self(get,never):HComplexType;
  private function get_self():HComplexType return lift(this);

  @:from static public function fromStdTypePath(self:StdTypePath):HComplexType{
    return lift(TPath(self));
  }
  @:from static public function fromHTypePath(self:HTypePath):HComplexType{
    return lift(TPath(self.prj()));
  }
}
class HComplexTypeLift{

}