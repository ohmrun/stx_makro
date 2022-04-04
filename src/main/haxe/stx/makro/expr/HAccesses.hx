package stx.makro.expr;

abstract HAccessess(Cluster<HAccess>) from Cluster<HAccess> to Cluster<HAccess>{
  public function new(self) this = self;
  static public function lift(self:Cluster<HAccess>):HAccessess return new HAccessess(self);

  static public function unit(){
    return lift(Cluster.lift(HAccess.Public()));
  }
  static public function with_static(){
    return lift(this.snoc(HAccess.Static()));
  }
  public function prj():Cluster<HAccess> return this;
  private var self(get,never):HAccessess;
  private function get_self():HAccessess return lift(this);
}