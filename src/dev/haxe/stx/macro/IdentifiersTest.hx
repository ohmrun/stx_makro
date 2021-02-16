package stx.macro;

import haxe.macro.Context;

import types.*;
import stx.macro.Identifiers;

class IdentifiersTest{
  public function new(){}
  public function test(){
    var hm : StringTypedef = "hmm";
    var t : { a : String, c : Array<Int>} = { a : "b", c : [1,2,3] };
    var s = new GenericTwoClass(t,t);
    generic_simple(s);

  }
  static macro function generic_simple(e:HExpr){
    var type = Context.typeof(e);
    var out = Identifiers.safeName(type);
    trace(out);
    return macro {}
  }
}
