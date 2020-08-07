package stx;

import haxe.ds.StringMap;

using stx.Nano;

@:allow(stx.makro)class Macro{
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