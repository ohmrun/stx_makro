package stx;

import haxe.ds.StringMap;


typedef MakroFailure            = stx.fail.MakroFailure;

#if macro
  typedef Type                  = stx.makro.Type;
  typedef Expr                  = stx.makro.Expr;
#end

@:allow(stx.makro)class Makro{
  static public var anons(default,null) : AnonsMap = new AnonsMap();
  static public var printer(default,null):haxe.macro.Printer = new haxe.macro.Printer();
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