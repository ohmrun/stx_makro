package stx.makro.feat.materialize;

using stx.Nano;
using stx.Test;
using stx.Log;

using stx.makro.Type;

import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Context;

class Test{
  static public function main(){
    boot();
    __.test().run(
      [
        new MaterializeTest()
      ],[]
    );
  }
  static macro function boot(){
    return macro {};
  } 
}
class MaterializeTest extends TestCase{
  public function test(){
    _test(new HasT());
    final nt : HasT<String> = new HasT();
    _test(nt);
  }
  static public macro function _test(e:Expr){
    final t : HType = haxe.macro.Context.typeof(e);
    trace(t);
    trace(t.get_fields());
    return macro {};
  }
}
@:stx.makro.Make
class HasT<T>{
  var t : T;
  public function new(){}
}