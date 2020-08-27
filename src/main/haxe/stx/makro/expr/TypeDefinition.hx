package stx.makro.expr;

import haxe.macro.Expr.TypeDefinition in TypeDefinitionT;

@:forward abstract TypeDefinition(TypeDefinitionT) from TypeDefinitionT to TypeDefinitionT{
  public function new(self){
    this = __.option(self).force();
  }
  static public function create(path:Ident,?fields:Array<tink.macro.Member>,?kind:TypeDefKind,?pos:haxe.macro.Expr.Position):TypeDefinition{
    var out : TypeDefinitionT = {
      name    : path.name,
      pack    : (cast path.pack:StdArray<String>),
      fields  : __.option(fields).defv([]).prj(),
      kind    : __.option(kind).defv(TDStructure),
      pos     : __.option(pos).def(haxe.macro.Context.currentPos)
    }
    return new TypeDefinition(out);
  }
  var kind(get,set) : TypeDefKind;

  function set_kind(kind){
    return this.kind = kind;
  }
  function get_kind(){
    return this.kind;
  }
}