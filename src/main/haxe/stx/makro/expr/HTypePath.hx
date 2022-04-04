package stx.makro.expr;

@:forward abstract HTypePath(StdTypePath) from StdTypePath to StdTypePath{
  public function new(self) this = self;
  static public function lift(self:StdTypePath):HTypePath return new HTypePath(self);

  public function prj():StdTypePath return this;
  private var self(get,never):TypePath;
  private function get_self():TypePath return lift(this);

  static public function make(name,pack,?params,?sub){
    return lift({
      name    : name,
      pack    : pack,
      params  : params,
      sub     : sub
    });
  }
}