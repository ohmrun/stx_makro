package stx.makro.test;


class TestCall{
  static public function ok(b:Bool,self:Class<Dynamic>){
    trace("TESTCALL");
    __.log().trace(self);
  }
}
