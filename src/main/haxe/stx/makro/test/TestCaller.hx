package stx.makro.test;

#if (test=="stx_makro")
  @:stx.makro.test.TestCall.ok(true,__)
#end
class TestCallerPackage{
  public function new(){
    trace("CONS");
  }
}
class TestCaller{
  
}