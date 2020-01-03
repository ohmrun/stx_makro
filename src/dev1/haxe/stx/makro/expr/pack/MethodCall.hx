package stx.makro.expr.pack;

import stx.makro.Package;
import stx.makro.expr.Package;

using stx.makro.Lift;

import stx.makro.expr.head.data.MethodCall in MethodCallT;

abstract MethodCall(MethodCallT) from MethodCallT{
  public function new(self){
    this = self;
  }
  static public function pure(def:MethodCallT){
    return new MethodCall(def);
  }
  static public function make(ref:MethodRef,args:Array<Expr>):MethodCall{
    return pure({
      data : ref,
      args : args
    });
  }
  public function prj(){
    return this;
  }
  public function expr(pos):Expr{
    return ExprDefs.ECall(
      this.data.expr(pos),
      this.args
    ).expr(pos);
  }
}