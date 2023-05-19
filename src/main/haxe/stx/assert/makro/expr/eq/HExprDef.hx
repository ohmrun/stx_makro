package stx.assert.makro.expr.eq;

import stx.makro.expr.HExprDef as THExprDef;
import stx.makro.expr.HExpr as THExpr;
import haxe.macro.Expr as TExpr;
import haxe.macro.Expr.ExprDef as TExprDef;
final Eq = __.assert().Eq();

class HExprDef extends stx.assert.eq.term.Base<THExprDef> {

  public function new(){
    super();
  }
  public function comply(lhs:THExprDef,rhs:THExprDef):Equaled{
    return switch([lhs.prj(),rhs.prj()]){
      case [TExprDef.EConst(cI),TExprDef.EConst(cII)] :
        Eq.Makro().Expr().HConstant.comply(cI,cII);
      case [TExprDef.EArray(e1I,e2I),TExprDef.EArray(e1II,e2II)] :
        var eq = Eq.Makro().Expr().Expr.comply(e1I,e1II);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(e2I,e2II);
        }
        eq;
      case [TExprDef.EBinop(opI,e1I,e2I),TExprDef.EBinop(opII,e1II,e2II)] :
        var eq = Eq.Makro().Expr().Binop.comply(opI,opII);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(e1I,e1II);
        }
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(e2I,e2II);
        }
        eq;
      #if (haxe_ver > 4.205)
      case [TExprDef.EField(eI,fieldI,kindI),TExprDef.EField(eII,fieldII,kindII)] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.String().comply(fieldI,fieldII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Makro().Expr().EFieldKind).comply(kindI,kindII);
        }
        eq;
      #else
      case [TExprDef.EField(eI,fieldI),TExprDef.EField(eII,fieldII)] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.String().comply(fieldI,fieldII);
        }
        eq;
      #end
      case [TExprDef.EParenthesis(eI),TExprDef.EParenthesis(eII)] :
        Eq.Makro().Expr().Expr.comply(eI,eII);
      case [TExprDef.EObjectDecl(fieldsI),TExprDef.EObjectDecl(fieldsII)] :
        final cons = () -> RedBlackSet.make(Comparable.Anon(Eq.Makro().Expr().HObjectField,new stx.assert.makro.expr.ord.HObjectField()));
        var lset = cons();
            lset = lset.concat(fieldsI);
        var rset = cons();     
            rset = rset.concat(fieldsII);
        lset.equals(rset);
      case [TExprDef.EArrayDecl(valuesI),TExprDef.EArrayDecl(valuesII)] :
        Eq.Array(Eq.Makro().Expr().Expr).comply(valuesI,valuesII);
      case [TExprDef.ECall(eI,paramsI),TExprDef.ECall(eII,paramsII)] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.Cluster(Eq.Makro().Expr().Expr).comply(paramsI,paramsII);
        }
        eq;
      case [TExprDef.ENew(tI,paramsI),TExprDef.ENew(tII,paramsII)] :
        var eq = Eq.Makro().Expr().HTypePath.comply(tI,tII);
        if(eq.is_ok()){
          eq = Eq.Cluster(Eq.Makro().Expr().Expr).comply(paramsI,paramsII);
        }
        eq;
      case [TExprDef.EUnop(opI,postFixI,eI),TExprDef.EUnop(opII,postFixII,eII)] :
        var eq = Eq.Makro().Expr().Unop.comply(opI,opII);
        if(eq.is_ok()){
          eq = Eq.Bool().comply(postFixI,postFixII);
        }
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        }
        eq;
      case [TExprDef.EVars(varsI),TExprDef.EVars(varsII)] :
        Eq.Cluster(Eq.Makro().Expr().HVar).comply(varsI,varsII);
      case [TExprDef.EFunction(kindI,fI),TExprDef.EFunction(kindII,fII)] :
        var eq = Eq.NullOr(Eq.Makro().Expr().HFunctionKind).comply(kindI,kindII);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().HFunction.comply(fI,fII);
        }
        eq;
      case [TExprDef.EBlock(exprsI),TExprDef.EBlock(exprsII)] :
        Eq.Cluster(Eq.Makro().Expr().Expr).comply(exprsI,exprsII);
      case [TExprDef.EFor(iI,eexprI),TExprDef.EFor(iII,eexprII)] :
        var eq = Eq.Makro().Expr().Expr.comply(iI,iII);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(eexprI,eexprII);
        }
        eq;
      case [TExprDef.EIf(econdI,eifI,eelseI),TExprDef.EIf(econdII,eifII,eelseII)] :
        var eq = Eq.Makro().Expr().Expr.comply(econdI,econdII);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(eifI,eifII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Makro().Expr().Expr).comply(eelseI,eelseII);
        }
        eq;
      case [TExprDef.EWhile(econdI,eI,normalWhileI),TExprDef.EWhile(econdII,eII,normalWhileII)] :
        var eq = Eq.Makro().Expr().Expr.comply(econdI,econdII);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        }
        if(eq.is_ok()){
          eq = Eq.Bool().comply(normalWhileI,normalWhileII);
        }
        eq;
      case [TExprDef.ESwitch(eI,casesI,edefI),TExprDef.ESwitch(eII,casesII,edefII) ] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.Cluster(Eq.Makro().Expr().HCase).comply(casesI,casesII);
        }
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Makro().Expr().Expr).comply(edefI,edefII);
        }
        eq;
      case [TExprDef.ETry(eI,catchesI),TExprDef.ETry(eII,catchesII)] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.Cluster(Eq.Makro().Expr().HCatch).comply(catchesI,catchesII);
        }
        eq;
      case [TExprDef.EReturn(eI),TExprDef.EReturn(eII)] :
        Eq.Makro().Expr().Expr.comply(eI,eII);
      case [TExprDef.EBreak,TExprDef.EBreak] :
        AreEqual;
      case [TExprDef.EContinue,TExprDef.EContinue] :
        AreEqual;
      case [TExprDef.EUntyped(eI),TExprDef.EUntyped(eII)] :
        Eq.Makro().Expr().Expr.comply(eI,eII);
      case [TExprDef.EThrow(eI),TExprDef.EThrow(eII)] :
        Eq.Makro().Expr().Expr.comply(eI,eII);
      case [TExprDef.ECast(eI,tI),TExprDef.ECast(eII,tII)] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Makro().Expr().HComplexType).comply(tI,tII);
        }
        eq;
      case [TExprDef.ETernary(econdI,eifI,eelseI),TExprDef.ETernary(econdII,eifII,eelseII)] :
        var eq = Eq.Makro().Expr().Expr.comply(econdI,econdII);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(eifI,eifII);
        }
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(eelseI,eelseII);
        }
        eq;
      case [TExprDef.ECheckType(eI,tI),TExprDef.ECheckType(eII,tII)] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Makro().Expr().HComplexType).comply(tI,tII);
        }
        eq;
      case [TExprDef.EMeta(sI,eI),TExprDef.EMeta(sII,eII)] :
        var eq = Eq.Makro().Expr().HMetadataEntry.comply(sI,sII);
        if(eq.is_ok()){
          eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        }
        eq;
      case [TExprDef.EIs(eI,tI),TExprDef.EIs(eII,tII)] :
        var eq = Eq.Makro().Expr().Expr.comply(eI,eII);
        if(eq.is_ok()){
          eq = Eq.NullOr(Eq.Makro().Expr().HComplexType).comply(tI,tII);
        }
        eq;
      default : 
        Eq.EnumValueIndex().comply(lhs.prj(),rhs.prj());
    }
  }
}