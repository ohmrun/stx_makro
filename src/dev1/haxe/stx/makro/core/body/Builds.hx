package stx.makro.core.body;

import haxe.macro.Compiler;

class Builds{
  @:access(stx.Macro) public static macro function build(){
    stx.Macro.build = new stx.makro.core.pack.Build(
      Sys.getCwd(),
      haxe.macro.Context.getClassPath()
    );      
    return macro {};
  }
}