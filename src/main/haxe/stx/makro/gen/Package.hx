package stx.makro.gen;

class Package{


}
class Test extends Clazz{
  public function deliver(): Array<haxe.unit.TestCase>{
    return [ 
      new TDefToStringTest() 
    ];
  }  
}
class TDefToStringTest extends haxe.unit.TestCase{
  #if macro
  public function test(){
    __.log().trace('test');
  }    
  #end
}
