package stx.macro.core.body;

import haxe.PosInfos in Pos;

class Errors{
  static public function unexpected(f:Fault,?n:Pos){
    return f.because("unexpected condition");
  }
  static public function implementation_not_found(f:Fault,t:String,where:String){
    return f.because('implementation of "$t" in $where not found');
  } 
}