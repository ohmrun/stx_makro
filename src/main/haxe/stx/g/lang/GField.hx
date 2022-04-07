package stx.g.lang;

class GFieldCtr extends Clazz{
  static public function unit(){
    return new GFieldCtr();
  }
  private function lift(self:GFieldDef):GField{
    return GField.lift(self);
  }
  public function Make(name:String,kind:GFieldTypeCtr->GFieldType,?access:GAccessCtr->Cluster<GAccess>,?meta:GMetadataEntryCtr->GMetadata,?doc){
    return GField.make(
      name,
      kind(GFieldType.__),
      __.option(access).map(f -> f(GAccess.__)).defv(null),
      __.option(meta).map(f -> f(GMetadataEntry.__)).defv(null),
      doc
    );
  }
}
typedef GFieldDef = {
	final name     : String;
  final kind     : GFieldType;
	final ?access  : Cluster<GAccess>;
	final ?meta    : GMetadata;
  final ?doc     : Null<String>;
}
@:forward abstract GField(GFieldDef) from GFieldDef to GFieldDef{
  static public var __(default,never) = new GFieldCtr();
  public function new(self) this = self;
  static public function lift(self:GFieldDef):GField return new GField(self);
  @:noUsing static public function make(name:String,kind:GFieldType,?access,?meta,?doc){
    return lift({
      name    : name,
      kind    : kind,
      access  : access,
      meta    : meta,
      doc     : doc
    });
  }
  public function prj():GFieldDef return this;
  private var self(get,never):GField;
  private function get_self():GField return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printField(this);
	}
}