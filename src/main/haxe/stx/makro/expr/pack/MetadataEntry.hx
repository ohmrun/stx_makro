package stx.makro.expr.pack;

import haxe.macro.ExprTools;

import stx.makro.alias.StdMetadataEntry;

abstract MetadataEntry(StdMetadataEntry) from StdMetadataEntry{
  public function new(self){
    this = self;
  }
  public function toObject():Any{
    return {
      name    : this.name,
      params  : this.params.map(ExprTools.getValue)
    };
  }
}