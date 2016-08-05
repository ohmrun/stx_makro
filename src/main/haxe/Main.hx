package;

using Lambda;

import utest.Assert.*;
import utest.Runner;

#if macro
  import tink.macro.Types;
  import haxe.macro.Type;
  import haxe.macro.Expr;
  import haxe.macro.Context;
#end

//import stx.macro.Combine;
//import stx.macro.Combine;
//import stx.macro.AssignTest;
//import stx.macro.JoinTest;
//import stx.macro.ExtractTest;
//import stx.Macro;

class Main{
  static function main(){
    var a = new stx.macro.TupleTest();
  }
  public function new(){
    //stx.macro.Join.apply(TDef1,TDef2);
    /*var a : TDef2 = { a : 'hello', v : 3 }
    var b = ArgueTest.apply0;
    stx.macro.Argue.apply(a,b);
    stx.macro.Argue.apply(a,ArgueTest.apply0);
    stx.macro.Argue.apply(a,function(x) return x);

    //apply(ref,ref);
    //apply(anon,anon);
    stx.macro.Extract.apply(
      {
        ex : 1,
        a : "something",
      },
      ExFields
    );
    var v = {
      ex : 2,
      a : "other"
    }
    //stx.macro.Extract.apply(v,ExFields);
    */
  }
  static public macro function test(expr){
    var runner = new Runner();
    //utest.ui.Report.create(runner);
    var tests : Array<Dynamic> = [
      new stx.macro.TupleTest()
      //new stx.macro.ConstructorsTest(),
      //new stx.macro.CombineTest(),
      //new stx.macro.AssignTest()
      //new stx.macro.TupleTest()
    ];
    tests.iter(
      function(x) runner.addCase(x)
    );
    runner.run();
    haxe.macro.Context.onGenerate(
      function(x){
        //trace(x);
      }
    );
    trace('test phase');

    return expr;
  }
}
class ArgueTest{
  static public function apply0(obj : { v:Int } ):String{
    return 'there are ${obj.v} thingies';
  }
}
typedef TDef1 = {
  var a : String;
}
typedef TDef2 = {
  >TDef1,
  var v : Int;
}