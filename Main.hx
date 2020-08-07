using stx.Nano;
using stx.Pico;
using stx.Log;
using stx.Bake;
import stx.makro.test.TestCaller.TestCallerPackage;


import stx.Testify;

class Main{
  #if macro
    static public function boot(){
      
      #if !make
        __.log().trace("MACRO");
        __.test(
          new stx.makro.gen.Package.Test().deliver()
        );
      #else
        __.log().trace("MACRO MAKE");
        trace(__.bake());
      #end
    }
    static public function main(){}
  #elseif make
    static public function main(){
      __.log().trace("MAKE");  
    }
  #else
    static public function main(){
      __.log().trace("MAIN");  
      var d : a.b.OH3 = {};
    }
  #end
}

@:stx.Testify.apply(__,"TOOOOT")
class TestMacroCallification{
  public function new(){

  }
}