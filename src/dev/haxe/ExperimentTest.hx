class ExperimentTest{
    public function new(){

    }
    public function test(){
      #if !macro
      trace(EnumeryThing.TestThing);
      trace(EnumeryThing.OtherThing);
      #end
    }
}
class Clone{
  /*
  static public macro function apply(e:haxe.macro.Expr){
    return _apply(e);
  }
  #if macro
  static public function apply(e:haxe.macro.Expr):haxe.macro.Expr{

  }
  #end*/
}
class Increment{

}

enum abstract EnumeryThing(Int){
  static public var index(get,null) : Int;
  public static inline function get_index(){
    if(index == null){index = 0;}
    var o = index;
    index = index + 1;
    return o;
  }
  public static inline macro function get_indexM(){
    return macro $v{index};
  }
  #if !macro
  var TestThing   = get_indexM();
  var OtherThing  = get_indexM();
  #end
}
