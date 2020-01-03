package stx.macro.expr.pack;

import haxe.macro.ExprTools;

import stx.macro.alias.StdMetadataEntry;

abstract MetadataEntry(StdMetadataEntry) from StdMetadataEntry{
  public function new(self){
    this = self;
  }
  public function toObject():Any{
    return {
      name    : this.name,
      params  : this.params.ds().map(ExprTools.getValue)
    };
  }
}