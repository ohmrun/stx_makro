package stx.g.lang;

@:forward abstract GMetadata(Cluster<GMetadataEntry>) from Cluster<GMetadataEntry> to Cluster<GMetadataEntry>{
  public function new(self) this = self;
  static public function lift(self:Cluster<GMetadataEntry>):GMetadata return new GMetadata(self);

  public function prj():Cluster<GMetadataEntry> return this;
  private var self(get,never):GMetadata;
  private function get_self():GMetadata return lift(this);

  public function toSource(){
    return this.map(x -> x.toSource()).join(' ');
  }
}