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
    //Types.blum(a);
    var b : types.TypeNamedDifferentlyToPath.Fandango;
    //Types.blum(b);
    var c = [];
    fail();
  }
  public function testGetType(){
    var a = 1;
    var b = [];
    var c = {};
    getTypeTestWrapper(types.TypedefsInModule);
    getTypeTestWrapper(a);
    getTypeTestWrapper(Float);
  }
  static macro function getTypeTestWrapper(e:Expr):Expr{
    var a =  Exprs.getType(e);
    return macro {
      pass();
    };
  }
  public function testIsTerminal(){
    var a = 1;
    var b = [];
    var c = {};
    isTrue(getIsTerminalWrapper(a));
    isTrue(getIsTerminalWrapper(true));
    isTrue(getIsTerminalWrapper(0.3));
    isTrue(getIsTerminalWrapper(""));
    isFalse(getIsTerminalWrapper(b));
    isFalse(getIsTerminalWrapper(c));
    isFalse(getIsTerminalWrapper(new haxe.ds.StringMap()));
    isFalse(getIsTerminalWrapper(new RecursiveSimpleClassType()));
    isTrue(getIsTerminalWrapper(StringTypedef));
    isTrue(getIsTerminalWrapper((2:IntAbstract)));
  }
  static macro function getIsTerminalWrapper(e:Expr){
    var t     = Exprs.getType(e);
    var isT   = stx.macro.Types.isTerminal(t);
    return macro $v{isT};
  }
  public function equality(){
    var a = new SimpleClassType();
    var b = new SimpleClassType();
    //NominativeEquality.apply(a,b);
  }
}
