package ah.macro;

import Metah.dive;

using thx.Strings;
#if macro
using tink.MacroApi;
#end


using thx.Arrays;
using thx.ReadonlyArray;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Printer;

class DiveTest{
  public function new(){}
  function get(){
    return [{
      a : {
        b : {
          c : [
            {
              test : "thing"
            },
            {
              test : "other_thing"
            }
            ]
          },
        d : "HI",
        e : {
          f : "WOOT"
        }
      }
    }];
  }
  public function test(){
    /*
    var val = get();
    var f = Dive.apply(val,[0].a.e.f);
    var out = f(val);
    trace(out);*/
    var dtf : DiveTypedef = {
      c : 3,
      d : [[1]]
    }
    var val   = get();
    var f0    = dive(val,[0].a.b.c);
    var f1    = dive(val,[0].a.d);

    var s = f0(val);
    var t = f1(val);

    trace('$s $t');
  }
}
typedef DiveTypedef = {
  c : Int,
  d : Array<Array<Int>>
}
class DiveClass{
  public function new(){
    c = "W==T";
  }
  public var c : String;
}
