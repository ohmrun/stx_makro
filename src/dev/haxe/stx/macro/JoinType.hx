package stx.macro;

@:enum abstract JoinType(String) from String{
  var Left  = "Left";
  var Right = "Right";
  var Outer = "Outer";
  var Inner = "Inner";
}