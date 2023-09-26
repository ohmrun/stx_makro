package stx.makro.feat.std_type;

import haxe.macro.Expr;
import haxe.macro.Context;

using stx.Nano;
using stx.Test;
using stx.Log;
using stx.makro.Type;

import stx.makro.type.HStdType.ensure;

class Test extends TestCase{
  static public function main(){
    __.test().run(
      [
        new Test()
      ],[]
    );
  }
  public function test_types(){
    find("s");
    // find([]);
    // find(["a" => 1]);
    // find(true);
    // find(1);
    // find(1.2);
  }
  static macro function find(e:Expr){
    final t = Context.typeof(e);
    final v : HType = ensure(t);
    trace(v.pack);
    return macro {};
  }
}