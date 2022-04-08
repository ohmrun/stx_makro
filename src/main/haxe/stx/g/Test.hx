package stx.g;

using stx.g.Lang;

using stx.Test;

class Test{
  static public function main(){
    #if boot
      boot();
    #else
    __.test([new GBuildTest()],[]);
    #end
  }
  static public macro function boot(){
    return macro {};
  }
}
class GBuildTest extends TestCase{
  function bool_ct(){
    return __.g().complex_type().Path(
      ct -> ct.fromString('std.Bool')
    );
  }
  function arg0(){
    return __.g().function_arg().Make(
      'arg0',
      _ -> bool_ct()
    );
  }
  public function test(){

    final fst_field = __.g().field().Make(
      'field_',
      type -> type.Fun(
        fun -> fun.Make(
          args -> [
            arg0()
          ],
          ret -> ret.Path(
            _ -> 'Void'
          ) 
        )       
      ),
      access -> [access.Private(),access.Final()]
    );
    final type = __.g().type().Make(
      'Test',
      [],
      type -> type.Class(),
      fields -> [
        fst_field   
      ]
    );
    trace('___________________');
    trace('${type.toSource()}');
  }
}