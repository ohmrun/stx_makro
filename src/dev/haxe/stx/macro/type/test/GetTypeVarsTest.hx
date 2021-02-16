package stx.macro.type;

import types.*;
#if macro
import stx.macro.body.Types;
#end

class GetTypeVarsTest{ 
  public function new(){}
  public function test(){
    var gs = new GenericSimpleClass("hello"); 
    f(new GenericTwoClass(gs));
  }
  static macro function f(e){
    var expr : stx.macro.HExpr = e;
    var type : stx.macro.Type = Types.getType(e);
    var params = type.getTypeVars();
    trace(params);
    return macro {};
  }
}