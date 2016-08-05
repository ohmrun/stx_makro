package ah.macro;

import utest.Assert.*;

class AccessTest{
  public function new(){

  }
  public function testAccess(){
    var tester = {
      a : {
        b : {
          c : "hello"
        }
      }
    }
    var fn  = Macro.acs(a.b.c);
    var o   = fn(tester);
    equals("hello",o);
  }
}