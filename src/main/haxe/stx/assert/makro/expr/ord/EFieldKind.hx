package stx.assert.makro.expr.ord;

#if (haxe_ver > 4.205)
import haxe.macro.Expr.EFieldKind as EFieldKindT;

class EFieldKind extends OrdCls<EFieldKindT>{
  public function new(){}
  public function comply(lhs:EFieldKindT,rhs:EFieldKindT){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}
#end