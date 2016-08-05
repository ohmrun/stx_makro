package ah.macro;

import haxe.macro.Expr;
import haxe.macro.Context;

class PathAssurance{
  static public macro function assure(e:Expr):Expr{
    switch(e.expr){
      case EConst(CString(s)) :
        trace(s);
        //Context.
      default : null;
    }
    return macro {};
  }
}
abstract Path(String) from String to String{
  public function new(self){
    PathAssurance.assure(self);
    this = self;
  }
  static public macro function fromPathExpr(e:Expr){
    return macro new Path("");
  }
  /*
  public function getPathSty
  */
}
enum PathStyle{
  ModuleType;
  TypeVariable;
  ModuleTypeVariable;
  Local;
}
