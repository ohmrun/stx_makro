package stx.makro.core;

typedef ModuleDef = IdentDef & {
  var module : Option<haxe.io.Path>;
}