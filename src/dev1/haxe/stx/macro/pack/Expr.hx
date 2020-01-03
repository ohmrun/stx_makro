package stx.macro.pack;

import haxe.macro.Printer;

@:forward abstract Expr(haxe.macro.Expr) from haxe.macro.Expr to haxe.macro.Expr{
  static public var UNIT : Expr = { expr : EBlock([]), pos : null };
  
  public function new(self){
    this = self;
  }
  public function getType():stx.macro.pack.Type{
    return stx.macro.body.Types.getType(this);
  }
  static public function ref(str:String,pos){
    return {
      pos : pos,
      expr : EConst(CIdent(str))
    };
  }
  public function prj(){
    return this;
  }
  public function show(){
    var printer = new Printer();
    return printer.printExpr(this);
  }
}