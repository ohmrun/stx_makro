package stx.makro.pack;

import haxe.macro.Context;
import stx.makro.Package;
import stx.makro.expr.Package;
import stx.makro.expr.pack.Constant;
import stx.makro.expr.pack.ExprDef;


class Api{
  public function new(){}
  public function ref(name,pos){
    return stx.makro.pack.Expr.ref(name,pos);
  }
  public function def(){
    return new ApiExprDef();
  }
  public function const(){
    return new ApiConst();
  }
  public function lits(){
    return new ApiLiterals();
  }
}
class ApiExprDef{
  public function new(){}
  public function econst(v):ExprDef{
    return EConst(v);
  }
  public function ecall(self,with):ExprDef{
    return ECall(self,with);
  }
  public function eswitch(e,cases,def):ExprDef{
    return ESwitch(e,cases,def);
  }
  public function earraydecl(vals):ExprDef{
    return EArrayDecl(vals);
  }
  public function ebinop(op,l,r):ExprDef{
    return EBinop(op,l,r);
  }
  public function efield(e,f):ExprDef{
    return EField(e,f);
  }
}
class ApiBinop{
  public function new(){}
  public function booland(){
    return OpBoolAnd;
  }
}
class ApiConst{
  public function new(){}
  public function string(str:String):Constant{
    return CString(str);
  }
  public function ident(str:String):Constant{
    return CIdent(str);
  }
}
class ApiLiterals{
  public function new(){}
  public function bool(b:Bool,pos):Expr{
    return new ApiConst().ident(b ? 'true' : 'false').expr(pos);
  }
}