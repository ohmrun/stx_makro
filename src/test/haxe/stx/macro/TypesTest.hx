package stx.macro;

import haxe.macro.Type;

import utest.Assert.*;

import stx.macro.Exprs;

import stx.macro.type.*;

class TypesTest{
  public function new(){}
  public function testBfs(){
    var val = {
      a : "3",
      b : [[true]],
      c : {
        d : {

        }
      }
    };
    pass();
  }
  public function testIdentify(){
    /*
    var a = new GenericSimpleClass();
    var type : haxe.macro.Type = Contexts.mtype(a);
    switch type {
      case TInst(v,params):
        trace(v);
    }*/

    //var out = Types.identify(a);
    //trace(out);
  }
  public function testModulePack(){
    var a : types.TypeNamedAsPath = {};
    Types.blum(a);
    var b : types.TypeNamedDifferentlyToPath.Fandango;
    Types.blum(b);
    var c = [];
    Types.blum(c);
  }
  public function equality(){
    var a = new SimpleClassType();
    var b = new SimpleClassType();
    //NominativeEquality.apply(a,b);
  }
}
