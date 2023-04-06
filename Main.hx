using stx.Pico;
using stx.Nano;

using stx.Log;
using Bake;

import stx.makro.test.TestCaller.TestCallerPackage;
import stx.makro.test.TestCall;

import stx.Testify;

using stx.makro.Core;

class Main{
  #if macro
    static public function boot(){
      trace(PositionKind.unit());     
      #if !make
        __.log().trace('BOOT: ${Bake.pop()}');
        // __.test().run(
        //   new stx.makro.gen.Package.Test().deliver()
        // );
      #else
        __.log().trace('BOOT MAKE: ${Bake.pop()}');
      #end
    }
    static public function main(){}
  #elseif make
    static public function main(){
      __.log().trace('MAIN MAKE: ${Bake.pop()}');
    }
  #else
    static public function main(){
      __.log().trace('MAIN: ${Bake.pop()}');
      //var d : a.b.OH3 = {};
    }
  #end
}

// @:stx.Testify.apply(__,"TOOOOT")
// class TestMacroCallification{
//   public function new(){

//   }
// }