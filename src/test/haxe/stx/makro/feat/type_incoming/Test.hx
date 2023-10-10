package stx.makro.feat.type_incoming;

import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Context;

using stx.Nano;
using stx.Test;
using stx.Log;

using stx.makro.Type;

class Test extends TestCase{
  static public function main(){
    __.test().run(
      [
        new Test()
      ],[]
    );
  }
  public function test(){
    final mis_match = new stx.makro.feat.type_incoming.ModuleMismatch.ClassName();
    what_does_the_name_pack_module_look_like_coming_in(mis_match);
    final match = new stx.makro.feat.type_incoming.ModuleMatch.ModuleMatch();
    what_does_the_name_pack_module_look_like_coming_in(match);
  }
  static public macro function what_does_the_name_pack_module_look_like_coming_in(e:Expr){
    final type = Context.typeof(e);
    switch(type){
      case TInst(t,_) : 
        trace(t.get().pack);
        trace(t.get().name);
        trace(t.get().module);
      default         : 
    }
    return macro {};
  }
}