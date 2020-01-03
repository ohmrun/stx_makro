package stx.macro.expr.pack;

import stx.macro.Package;
import stx.macro.expr.Package;

using stx.macro.Lift;

import stx.macro.expr.head.data.MethodCall in MethodCallT;

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