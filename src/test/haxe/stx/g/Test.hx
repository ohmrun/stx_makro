package stx.g;

using stx.Nano;
using stx.Show;
//using Bake;
using stx.g.Lang;
using stx.Test;

import stx.g.test.*;

class Test{
  static public function main(){
    #if boot
      boot();
    #else
    __.test().run(
      [
        //new GBuildTest(),
        new PublishEnumAbstractTest(),
      ],[]
    );
    #end
  }
  static public macro function boot(){
    __.test().run(
      [new EnumAbstractTest()],
      []
    );
    return macro {};
  }
}
class PublishEnumAbstractTest extends TestCase{
  #if !macro
  public function test(){
    macro_make();
    var a = EnumAbstractTestType.First;
    trace("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1");
    trace(a);
  }
  #end
  // static public function get_type(e){

  // }
  static public macro function macro_make(){
    trace("MACRO_MAKE");
    final tdef = try{
      EnumAbstractTest.types();
    }catch(e:haxe.Exception){
      null;
    }
    try{
      haxe.macro.Context.defineType(tdef.to_macro_at(haxe.macro.Context.currentPos()));
      haxe.macro.Compiler.include(tdef.ident().toIdentifier().toString());
      trace(__.show(tdef.ident().toIdentifier()));
    }catch(e:haxe.Exception){
      trace(e);
    }  
    //__.bake().publish(GTypeDefinition._.to_macro_at(tdef,haxe.macro.Context.currentPos()));
  
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