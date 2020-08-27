package stx.macro.type.test;

class EnumTypesTest extends Clazz{
  static public function tests():Array<Block>{
    var val = new EnumTypesTest();
    return [
      val.test
    ];
  }
  static macro function _(e){
    var pos = __.here();
    var expr = e.stx();
    var type = expr.getType();
    switch(type){
      case TEnum(t,_):
        var e = t.get().stx().getSimpleSwitch(
          (_) -> Some(Constants.CString("Cheese").expr(pos)),
          pos
        );
        trace(e);
      default : 
    }
    return macro {};
  }
  public function test(){
    trace('test');
    _(multiple_values());
  }
  static public function multiple_values(){
    return types.EnumMultipleValues.EMV("jell",true,2);
  }
  static public function base_enum(){
    return types.BaseEnum.BaseEnumThing;
  }
}