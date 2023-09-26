package stx.makro;

using stx.Pico;
using stx.Nano;
using stx.Test;
using stx.Log;

using stx.Makro;
using stx.makro.Type;
using stx.makro.Expr;

import haxe.macro.Context;

class ToComplexTypeTest extends TestCase{
  static public function main(){
    boot();
    __.test().run(
      [
        new RuntimeTest(),
      ],[]
    );
  }
  static private macro function boot(){
    __.test().run(
      [
        new MacroTest(),
      ],[]
    );
    return macro {};
  }
}
class RuntimeTest extends TestCase{
  static macro function goGetTypeVars(e:haxe.macro.Expr){ 
    final type  = e.toHExpr().getType();
    trace(type.getTypeVars());
    final ctype = tink.macro.Sisyphus.toComplexType(type);
    trace(ctype);
    trace(__.makro().printer.printComplexType(ctype));
    return macro {}; 
  }
  function test<T>(){
    final v : InnerGeneric<T>       = from_above(STX);
    goGetTypeVars(v);
    final v : InnerGeneric<String>  = from_above(STX);
    goGetTypeVars(v);
  }
  function from_above<T>(v:STX<T>):InnerGeneric<T>{
    return ([]:InnerGeneric<T>);
  }
  #if macro
  public static function compare_to_complex_algorithms(t){
    trace
  }
  #end
}
class MacroTest extends TestCase{
  #if macro
  public function test_search_applied_type(){
    this.raises(
      () -> {
        trace(haxe.macro.Context.getType("InnerGeneric<Array<Option<T>>"));
      }
    );
  }
  #end
}
typedef InnerGeneric<T> = Array<Option<T>>;