package ah.macro;

import Metah.entype;

import utest.Assert.*;
import stx.Compare.*;

import ah.Exprs;
import haxe.macro.Expr;

class EntypeTest{
  public function new(){}
  public function testEntype(){
    #if !macro
    var a = entype((_:WithAnnotation<String>));
    #end
    var b : Dynamic = new WithAnnotation("hello");
    var c = a(b);
    isTrue(eq("hello")(c.data));

    var d = entype((_:TypedefWithAnnotation<String>));
    var e = { data : "hello"};
    var f = d(e);
    isTrue(eq("hello")(f.data));

    var g = d(b);

    var h = entype((_:TypedefWithAnnotationAnd<String>));
    var i : Dynamic = { data : "hello "}; //totally removes type checking -__-
    var j = h(i);
    isTrue(eq("hello")(f.data));

    $type(j);
    trace(j);

    /*
    var k = Macro.entype((_:Unrelated));
    var l = { data : "hello "};
    var m = k(l); //: Unrelated
    $type(k);
    trace(m);
    var n = (l:Unrelated);
    */
  }
}
class WithAnnotation<T>{
  public var data : T;
  public function new(v:T){
    this.data = v;
  }
}
typedef TypedefWithAnnotation<T> = {
  var data : T;
}
typedef TypedefWithAnnotationAnd<T> = {
  >TypedefWithAnnotation<T>,
  var key : String;
}
typedef Unrelated = {
  var val : Int;
}
