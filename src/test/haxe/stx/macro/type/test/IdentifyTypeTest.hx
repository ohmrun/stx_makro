package stx.macro.type;

using stx.core.Lift;
using stx.ds.Lift;

import types.*;

class IdentifyTypeTest {
	public function new() {}

	public function test() {
		var simple = 3;
		// f(simple);
		var fiendish:FT<String, String> = function(ft:FT<String, String>):String->String {
			return function(s) return s + "?";
		}
    var fn = function(x:String,y:Int,z:Array<Int>) return true;
    var next = new RecursiveInnerBoundParametricClassType();
    f({ f: fn, a : "helk", b : [].ds() });
		f({ f: fn, a : "h", b : [].ds() });
	}

	static macro function f(e) {
		var expr = e.stx();
		var t = expr.getType();
    var ident = t.getIdentity().toUniquePath();
    //{a:String,b:stx.core.Array<?>,f:function(x:String,y:Int,z:stx.core.Array<Int>):Bool}
    //trace(ident);
		trace(ident);
		trace(stx.Macro.anons);
		return macro {};
	}
}