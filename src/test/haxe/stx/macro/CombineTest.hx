package stx.macro;

//import stx.macro.Exprs.type;

#if macro
  import tink.macro.Bouncer;
  import tink.macro.Types;
  import tink.macro.Exprs;
  import haxe.macro.Type;
  import haxe.macro.Expr;
  import haxe.macro.Context;
  import haxe.macro.Compiler;
#end

class CombineTest{
  public function new(){}
  public function testCombine(){
    var a = {
        a : "hello",
        b : "world",
        c : "combine works"
    }
    //var a = Combine.apply(CombineT2,CombineCompatible,a);
    var b = Combine.apply(CombineT2,CombineCompatible,
      {
          a : "hello",
          b : "world",
          c : "combine works"
      }
    );
  }
}