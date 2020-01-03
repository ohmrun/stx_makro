package stx;

using stx.core.Lift;
import haxe.ds.StringMap;

class Macro{
  static public var build(default,null) : stx.makro.core.pack.Build;
  static public var anons(default,null) : AnonsMap = new AnonsMap();
}
abstract AnonsMap(StringMap<String>){
  public function new(){
    this = new StringMap();
  }
  public function get(str:String){
    return if(!this.exists(str)){
      var unique  = __.uuid("xxxxx");
      var anon    = 'Type_$unique';
      this.set(str,anon);
      anon;
    }else{
      this.get(str);
    }
  }
}