@:forward abstract TestMacroFrom(String) from Dynamic{
  public function new(self){
    this = self;
  }
  /*
  @:from static public function fromStrung(str:Dynamic){
    return new TestMacroFrom(str);
  }*/
  @:from static public macro function fromStringExpr(str:haxe.macro.Expr):haxe.macro.Expr{
    return switch(str.expr){
      case EConst(CString(str)) : macro $v{str};
      default                   : haxe.macro.Context.error("oops",haxe.macro.Context.currentPos()); macro str;
    }
    trace(str);
    return macro "Nothing";
  }
}
