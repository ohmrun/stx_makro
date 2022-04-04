package stx.makro.expr;

using stx.makro.Expr;

using stx.Test;

class Test{
  static function main(){
    final log       = __.log().global;
//          log.includes.push("**/*");    
          log.level = TRACE;
    #if boot
      boot();
    #else
      call();
    #end
  }
  static macro function boot(){
    final log         = __.log().global;
          log.includes.push("**/*");    
          log.level   = TRACE;
    __.test([],[]);
    return macro {};
  }
  static function call(){
    __.test(
      [
        //new WhatDoesReifiedFunctionDeclarationProduce(),
        new ShimTest()
      ],[]);
  }
}
class ShimTest extends TestCase{
  public function test(){
    var a = new SomethingSomething(); 
    makro(a);
  }
  private static macro function makro(e:Expr){
    var type    = Context.typeof(e);
    // trace(type);
    // switch(type){
    //   case TType(r,[]) : trace(r.get().type);
    //   default : null;
    // }
    //     type    = Context.follow(type);
    // switch(type){
    //   case TAnonymous(r) : 
    //     trace(r.get());
    //   default : null;
    // }
    final pos     = Context.currentPos();
    final fields  = HExpr._.shim(type,pos); 
    return macro {};
  }
}
class SomethingSomething{
  public function new(){}
  public var a                : String;
  public var b(get,null)      : Bool;
  public  function get_b(){
    return b;
  }
  public var c(default,null)  : Int;
  private var d               : Float;
  public function get_go(){}
}
class WhatDoesReifiedFunctionDeclarationProduce extends TestCase{
  public function test_thingle(){
    final method      = return_function();
  }
  private static macro function return_function(){
    //trace("a");
    final result      = macro function(){};
    final printer     = new Printer();
    // trace("jere");
    // trace(result);
    // trace("EIHJHIHUIOOHUIHIOU");
    return macro {};
  }
}