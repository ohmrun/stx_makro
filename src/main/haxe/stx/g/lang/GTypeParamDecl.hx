package stx.g.lang;

class GTypeParamDeclCtr extends Clazz{
  static public function unit(){
    return new GTypeParamDeclCtr();
  }
  public function Make(name:String,?constraints:GComplexTypeCtr -> Cluster<GComplexType>,?params:GTypeParamDeclCtr -> Cluster<GTypeParamDecl>,meta:GMetadataEntryCtr -> GMetadata){
    return GTypeParamDecl.make(
      name,
      __.option(constraints).map(f -> f(GComplexType.__)).defv(null),
      __.option(params).map(f -> f(GTypeParamDecl.__)).defv(null),   
      __.option(meta).map(f -> f(GMetadataEntry.__)).defv(null)    
    );
  }
}
typedef GTypeParamDeclDef = {
	final name : String;
	final ?constraints : Cluster<GComplexType>;
	final ?params : Cluster<GTypeParamDecl>;
	final ?meta : GMetadata;
}
@:forward abstract GTypeParamDecl(GTypeParamDeclDef) from GTypeParamDeclDef to GTypeParamDeclDef{
  static public var __(default,never) = new GTypeParamDeclCtr();
  public function new(self) this = self;
  static public function lift(self:GTypeParamDeclDef):GTypeParamDecl return new GTypeParamDecl(self);
  static public function make(name:String,?constraints:Cluster<GComplexType>,?params:Cluster<GTypeParamDecl>,meta){
    return lift({
      name        : name,
      constraints : constraints,
      params      : params,
      meta        : meta
    });
  }
  public function prj():GTypeParamDeclDef return this;
  private var self(get,never):GTypeParamDecl;
  private function get_self():GTypeParamDecl return lift(this);
}
