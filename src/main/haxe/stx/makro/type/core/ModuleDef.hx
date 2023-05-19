package stx.makro.type.core;

typedef ModuleDef = IdentDef & {
  @:optional var module : Option<haxe.io.Path>;
}