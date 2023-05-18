package stx.assert.makro.expr.eq;

import stx.makro.expr.HExprDef as THExprDef;
import stx.makro.expr.HExpr as THExpr;
import haxe.macro.Expr as TExpr;

class HExprDef extends stx.assert.eq.term.Base<THExprDef> {
  final expr_eq : Eq<TExpr>;

  public function new(){
    super();
    this.expr_eq = new stx.assert.makro.expr.eq.Expr();
  }
  public function comply(lhs:THExprDef,rhs:THExprDef):Equaled{
    return switch([lhs,rhs]){
      // case [EConst(cI),EConst(cII)] :
      //   new HConstant().comply(cI,cII);
      // case [EArray(e1I,e2I),EArray(e1II,e2II)] :
      //   var eq = expr_eq.comply(e1I,e1II);
      //   if(eq.is_ok()){
      //     eq = expr_eq.comply(e2I,e2II);
      //   }
      //   eq;
      // case [EBinop(opI,e1I,e2I),EBinop(opII,e1II,e2II)] :
      //   var eq = new Binop().comply(opI,opII);
      //   if(eq.is_ok()){
      //     eq = expr_eq.comply(e1I,e1II);
      //   }
      //   if(eq.is_ok()){
      //     eq = expr_eq.comply(e2I,e2II);
      //   }
      //   eq;
      // #if (haxe_ver > 4.205)
      // case [EField(eI,fieldI,kindI),EField(eII,fieldII,kindII)] :
      //   var eq = expr_eq.comply(eI,eII);
      //   if(eq.is_ok()){
      //     eq = Eq.String().comply(fieldI,fieldII);
      //   }
      //   if(eq.is_ok()){
      //     eq = Eq.NullOr(new stx.assert.makro.expr.eq.EFieldKind()).comply(kindI,kindII);
      //   }
      //   eq;
      // #else
      // case [EField(eI,fieldI),EField(eII,fieldII)] :
      //   var eq = expr_eq.comply(eI,eII);
      //   if(eq.is_ok()){
      //     eq = Eq.String().comply(fieldI,fieldII);
      //   }
      //   eq;
      // #end
      // case [EParenthesis(eI),EParenthesis(eII)] :
      //   comply(eI,eII);
      // case [EObjectDecl(fieldsI),EObjectDecl(fieldsII)] :
      //   final cons = () -> RedBlackSet.make(Comparable.Anon(new HObjectField(),new stx.assert.makro.expr.ord.HObjectField()));
      //   var lset = cons();
      //       lset = lset.concat(fieldsI);
      //   var rset = cons();     
      //       rset = rset.concat(fieldsII);
      //   lset.equals(rset);
      // case [EArrayDecl(valuesI),EArrayDecl(valuesII)] :
      //   Eq.Array(this).comply(valuesI,valuesII);
      // case [ECall(eI,paramsI),ECall(eII,paramsII)] :
      //   var eq = expr_eq.comply(eI,eII);
      //   if(eq.is_ok()){
      //     eq = Eq.Cluster(this).comply(paramsI,paramsII);
      //   }
      //   eq;
      // case [ENew(tI,paramsI),ENew(tII,paramsII)] :
      //   var eq = new HTypePath().comply(tI,tII);
      //   if(eq.is_ok()){
      //     eq = Eq.Cluster(this).comply(paramsI,paramsII);
      //   }
      //   eq;
      // case [EUnop(opI,postFixI,eI),EUnop(opII,postFixII,eII)] :
      //   var eq = new stx.makro.expr.eq.Unop().comply(opI,opII);
      //   if(eq.is_ok()){
      //     eq = Eq.Bool().comply(postFixI,postFixII);
      //   }
      //   if(eq.is_ok()){
      //     eq = expr_eq.comply(eI,eII);
      //   }
      //   eq;
      // case [EVars(varsI),EVars(varsII)] :
      //   Eq.Cluster(new HVar()).comply(varsI,varsII);
      // case [EFunction(kindI,fI),EFunction(kindII,fII)] :
      //   var eq = Eq.NullOr(new HFunctionKind()).comply(kindI,kindII);
      //   if(eq.is_ok()){
      //     eq = new HFunction().comply(fI,fII);
      //   }
      //   eq;
      // case [EBlock(exprsI),EBlock(exprsII)] :
      //   Eq.Cluster(this).comply(exprsI,exprsII);
      // case [EFor(iI,eexprI),EFor(iII,eexprII)] :
      //   var eq = expr_eq.comply(iI,iII);
      //   if(eq.is_ok()){
      //     eq = expr_eq.comply(eexprI,eexprII);
      //   }
      //   eq;
      // case [EIf(econdI,eifI,eelseI),EIf(econdII,eifII,eelseII)] :
      //   var eq = expr_eq.comply(econdI,econdII);
      //   if(eq.is_ok()){
      //     eq = expr_eq.comply(eifI,eifII);
      //   }
      //   if(eq.is_ok()){
      //     eq = Eq.NullOr(this).comply(eelseI,eelseII);
      //   }
      //   eq;
      // case [EWhile(econdI,eI,normalWhileI),EWhile(econdII,eII,normalWhileII)] :
      //   var eq = expr_eq.comply(econdI,econdII);
      //   if(eq.is_ok()){
      //     eq = expr_eq.comply(eI,eII);
      //   }
      //   if(eq.is_ok()){
      //     eq = Eq.Bool().comply(normalWhileI,normalWhileII);
      //   }
      //   eq;
      // case [ESwitch(eI,casesI,edefI),ESwitch(eII,casesII,edefII) ] :
      //   var eq = expr_eq.comply(eI,eII);
      //   if(eq.is_ok()){
      //     eq = Eq.Cluster(new HCase()).comply(casesI,casesII);
      //   }
      //   if(eq.is_ok()){
      //     eq = Eq.NullOr(this).comply(edefI,edefII);
      //   }
      //   eq;
      // case [ETry(eI,catchesI),ETry(eII,catchesII)] :
      //   var eq = expr_eq.comply(eI,eII);
      //   if(eq.is_ok()){
      //     eq = Eq.Cluster(new HCatch()).comply(catchesI,catchesII);
      //   }
      //   eq;
      // case [EReturn(eI),EReturn(eII)] :
      //   comply(eI,eII);
      // case [EBreak,EBreak] :
      //   AreEqual;
      // case [EContinue,EContinue] :
      //   AreEqual;
      // case [EUntyped(eI),EUntyped(eII)] :
      //   expr_eq.comply(eI,eII);
      // case [EThrow(eI),EThrow(eII)] :
      //   expr_eq.comply(eI,eII);
      // case [ECast(eI,tI),ECast(eII,tII)] :
      //   var eq = expr_eq.comply(eI,eII);
      //   if(eq.is_ok()){
      //     eq = Eq.NullOr(new HComplexType()).comply(tI,tII);
      //   }
      //   eq;
      // case [ETernary(econdI,eifI,eelseI),ETernary(econdII,eifII,eelseII)] :
      //   var eq = expr_eq.comply(econdI,econdII);
      //   if(eq.is_ok()){
      //     eq = expr_eq.comply(eifI,eifII);
      //   }
      //   if(eq.is_ok()){
      //     eq = expr_eq.comply(eelseI,eelseII);
      //   }
      //   eq;
      // case [ECheckType(eI,tI),ECheckType(eII,tII)] :
      //   var eq = expr_eq.comply(eI,eII);
      //   if(eq.is_ok()){
      //     eq = Eq.NullOr(new HComplexType()).comply(tI,tII);
      //   }
      //   eq;
      // case [EMeta(sI,eI),EMeta(sII,eII)] :
      //   var eq = new HMetadataEntry().comply(sI,sII);
      //   if(eq.is_ok()){
      //     eq = expr_eq.comply(eI,eII);
      //   }
      //   eq;
      // case [EIs(eI,tI),EIs(eII,tII)] :
      //   var eq = comply(eI,eII);
      //   if(eq.is_ok()){
      //     eq = Eq.NullOr(new HComplexType()).comply(tI,tII);
      //   }
      //   eq;
      default : 
        Eq.EnumValueIndex().comply(lhs.prj(),rhs.prj());
    }
  }
}