package stx.makro.feat.module_type_cleverness;

class Plugin{
  static public macro function use(){
    haxe.macro.Context.onTypeNotFound(onTypeNotFound);
    return macro {};
  }
  #if macro
  static public function onTypeNotFound(name:String){
    if((name:Chars).starts_with('stx.makro.feat')){
      trace(name);
    }
    return null;
  }
  #end
}