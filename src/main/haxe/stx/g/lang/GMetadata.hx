package stx.g.lang;

abstract GMetadata(Cluster<GMetadata>) from Cluster<GMetadata> to Cluster<GMetadata>{
  public function new(self) this = self;
  static public function lift(self:Cluster<GMetadata>):GMetadata return new GMetadata(self);

  public function prj():Cluster<GMetadata> return this;
  private var self(get,never):GMetadata;
  private function get_self():GMetadata return lift(this);
}