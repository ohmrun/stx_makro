package stx.g.lang;

class GMetadataEntryCtr extends Clazz{
  static public function unit(){
    return new GMetadataEntryCtr();
  }
  private function lift(self:GMetadataEntryDef):GMetadataEntry{
    return GMetadataEntry.lift(self);
  }
  public function Make(name:String,?params:GExprCtr -> Cluster<GExpr>){
    return lift({
      name    : name,
      params  : params(GExprCtr.unit())
    });
  }
}
typedef GMetadataEntryDef = {
	var name:String;
	var ?params:Cluster<GExpr>;
}
@:using(stx.g.lang.GMetadataEntry.GMetadataEntryLift)
@:forward abstract GMetadataEntry(GMetadataEntryDef) from GMetadataEntryDef to GMetadataEntryDef{
  static public var __(default,never) = new GMetadataEntryCtr();
  public function new(self) this = self;
  static public function lift(self:GMetadataEntryDef):GMetadataEntry return new GMetadataEntry(self);
  public function prj():GMetadataEntryDef return this;
  private var self(get,never):GMetadataEntry;
  private function get_self():GMetadataEntry return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printMetadata(this);
	}
}
class GMetadataEntryLift{
  #if macro
  static public function to_macro_at(self:GMetadataEntry,pos:Position):MetadataEntry{
    return {
      name    : self.name,
	    params  : __.option(self.params).map(x -> x.map(y -> y.to_macro_at(pos)).prj()).defv([]),
      pos     : pos
    };
  }
  #end
}