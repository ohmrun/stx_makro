package stx.assert.makro.expr.eq;

#if (haxe_ver > 4.205)
import haxe.macro.Expr.EFieldKind as EFieldKindT;

class EFieldKind extends stx.assert.eq.term.Base<EFieldKindT> {
  public function comply(lhs:EFieldKindT,rhs:EFieldKindT){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}
#end