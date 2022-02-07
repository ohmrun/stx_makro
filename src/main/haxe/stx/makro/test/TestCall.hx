package stx.makro.test;

@:keep
class TestCall{
  public function new(){}
  public function ok(b:Bool,self:Class<Dynamic>){
    trace("TESTCALL");
    __.log().trace(_ -> _.pure(self));
  }
}
