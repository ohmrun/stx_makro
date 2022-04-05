package stx.makro.def;

@:forward abstract HTypeDefinition(StdTypeDefinition) from StdTypeDefinition to StdTypeDefinition{
  public function new(self){
    this = __.option(self).force();
  }
  static public function make(path:IdentDef,?fields:Cluster<HField>,?kind:TypeDefKind,?pos:haxe.macro.Expr.Position):HTypeDefinition{
    var out : StdTypeDefinition = {
      name    : path.name,
      pack    : (cast path.pack:StdArray<String>),
      fields  : __.option(fields).defv([]).prj(),
      kind    : __.option(kind).defv(TDStructure),
      pos     : __.option(pos).def(haxe.macro.Context.currentPos)
    }
    return new HTypeDefinition(out);
  }
  var kind(get,set) : TypeDefKind;

  function set_kind(kind){
    return this.kind = kind;
  }
  function get_kind(){
    return this.kind;
  }
}