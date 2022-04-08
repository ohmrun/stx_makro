package stx.makro.pack;

import haxe.macro.Context;
import stx.makro.Package;
import stx.makro.expr.Package;
import stx.makro.expr.Constant;
import stx.makro.expr.HExprDef;


class Api{
  public function new(){}
  public function ref(name,pos){
    return stx.makro.pack.HExpr.ref(name,pos);
  }
  public function def(){
    return new ApiHExprDef();
  }
  public function const(){
    return new ApiConst();
  }
  public function lits(){
    return new ApiLiterals();
  }
}
class ApiHExprDef{
  public function new(){}
  public function econst(v):HExprDef{
    return EConst(v);
  }
  public function ecall(self,with):HExprDef{
    return ECall(self,with);
  }
  public function eswitch(e,cases,def):HExprDef{
    return ESwitch(e,cases,def);
  }
  public function earraydecl(vals):HExprDef{
    return EArrayDecl(vals);
  }
  public function ebinop(op,l,r):HExprDef{
    return EBinop(op,l,r);
  }
  public function efield(e,f):HExprDef{
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
  public function bool(b:Bool,pos):HExpr{
    return new ApiConst().ident(b ? 'true' : 'false').to_macro_at(pos);
  }
}