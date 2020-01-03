package stx.macro.head.data;

enum abstract CaseState(String){
  var expr;
  var values;
  var guard;
}