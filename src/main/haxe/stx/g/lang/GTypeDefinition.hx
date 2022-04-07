package stx.g.lang;

class GTypeDefinitionCtr extends Clazz{
  static public function unit(){
    return new GTypeDefinitionCtr();
  }
  private function lift(self:GTypeDefinitionDef):GTypeDefinition{
    return GTypeDefinition.lift(self);
  }
  public function Make(name,pack,kind,fields,params,meta,isExtern,doc){
    return GTypeDefinition.make(
      name,
      pack,
      kind(GTypeDefKind.__),
      fields(GField.__),

      __.option(params).map(f -> f(GTypeParamDecl.__)).defv(null),
      __.option(meta).map(f -> f(GMetadataEntry.__)).defv(null),
      isExtern,
      doc
    );
  }
}
typedef GTypeDefinitionDef = {
  final name      : String;
	final pack      : Cluster<String>;
  final kind      : GTypeDefKind;
	final fields    : Cluster<GField>;

	final ?params   : Cluster<GTypeParamDecl>;
	final ?meta     : GMetadata;
	final ?isExtern : Bool;
  final ?doc      : Null<String>;
}
@:forward abstract GTypeDefinition(GTypeDefinitionDef) from GTypeDefinitionDef to GTypeDefinitionDef{
  static public var __(default,never) = new GTypeDefinitionCtr();
  public function new(self) this = self;
  static public function lift(self:GTypeDefinitionDef):GTypeDefinition return new GTypeDefinition(self);
  static public function make(name,pack,kind,fields,?params,?meta,?isExtern,?doc){
    return lift({
      name        : name,
      pack        : pack,
      kind        : kind,
      fields      : fields,
      params      : params,
      meta        : meta,
      isExtern    : isExtern,
      doc         : doc
    });
  }
  public function prj():GTypeDefinitionDef return this;
  private var self(get,never):GTypeDefinition;
  private function get_self():GTypeDefinition return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printTypeDefinition(this);
	}
}