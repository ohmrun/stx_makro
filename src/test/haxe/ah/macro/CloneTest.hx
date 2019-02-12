package ah.macro;

import utest.Assert.*;
import ah.macro.Clone;

class CloneTest{
  public function new(){}
  /*
  public function testCloneValidate(){
    var ref0 = 1;
    var ref1 = {};
    var ref2 = [];
  }*/
  /*
  public function _testCloneValue(){
    var cloner  = Clone.apply(1);
    var val     = cloner(1);
    equals(1,val);

    var cloner  = Clone.apply("hello");
    var val     = cloner("hello");
    equals("hello",val);

    var cloner  = Clone.apply(1.1);
    var val     = cloner(1.1);
    equals(1.1,val);

    var ref     = 1;
    var cloner  = Clone.apply(ref);
    var val     = cloner(ref);
    equals(1,val);

    var ref     = 1.1;
    var cloner  = Clone.apply(ref);
    var val     = cloner(1.1);
    equals(1.1,val);

    var ref     = "hello";
    var cloner  = Clone.apply(ref);
    var val     = cloner(ref);
    equals("hello",val);

    var ref     = true;
    var cloner  = Clone.apply(ref);
    var val     = cloner(true);
    isTrue(val);
  }
  public function testArray(){
    var ref     = [1,2,3,4];
    var cloner  = Clone.apply(ref);
    var val     = cloner([1,2,3,4]);
    same([1,2,3,4],val);
  }
  public function testList(){
    var list    = new List();
        list.add(1);
    var cloner  = Clone.apply(list);
    var val     = cloner(list);
    equals(1,val.first());
  }
  public function testAnonymous(){
    var a = {
      "test" : 1
    };
    var cloner  = Clone.apply(a);
    var val     = cloner(a);
  }*/
  public function testIntermediateRepresentation(){
    var a = {
      "test" : 1,
      boolean : true,
      deep : {
        other : {
          named : 6
        }
      }
    };
    var cloner = Clone.build(a);
    trace(cloner);
  }
  /*
  public function testClonePrimitive(){

  }
  public function testCloneTypedef(){

  }
  public function testCloneClass(){

  }*/
}
