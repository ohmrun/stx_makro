package stx.assert.makro.expr.ord;

import stx.makro.expr.HExprDef as THExprDef;
import stx.makro.expr.HExpr as THExpr;
import haxe.macro.Expr as TExpr;

class HExprDef extends OrdCls<THExprDef>{
  final expr_ord : Ord<TExpr>;
  public function new(){
    this.expr_ord  = new stx.assert.makro.expr.ord.Expr();
  }
  public function comply(lhs:THExprDef,rhs:THExprDef):Ordered{
    return switch([lhs,rhs]){
      // case [EConst(cI),EConst(cII)] :
      //   new HConstant().comply(cI,cII);
      // case [EArray(e1I,e2I),EArray(e1II,e2II)] :
      //   var ord = expr_ord.comply(e1I,e1II);
      //   if(ord.is_not_less_than()){
      //     ord = expr_ord.comply(e2I,e2II);
      //   }
      //   ord;
      // case [EBinop(opI,e1I,e2I),EBinop(opII,e1II,e2II)] :
      //   var ord = new stx.assert.makro.expr.ord.Binop().comply(opI,opII);
      //   if(ord.is_not_less_than()){
      //     ord = expr_ord.comply(e1I,e1II);
      //   }
      //   if(ord.is_not_less_than()){
      //     ord = expr_ord.comply(e2I,e2II);
      //   }
      //   ord;
      // #if (haxe_ver > 4.205)
      // case [EField(eI,fieldI,kindI),EField(eII,fieldII,kindII)] :
      //   var ord = expr_ord.comply(eI,eII);
      //   if(ord.is_not_less_than()){
      //     ord = Ord.String().comply(fieldI,fieldII);
      //   }
      //   if(ord.is_not_less_than()){
      //     ord = Ord.NullOr(new stx.assert.makro.expr.ord.EFieldKind()).comply(kindI,kindII);
      //   }
      //   ord;
      // #else
      // case [EField(eI,fieldI),EField(eII,fieldII)] :
      //   var ord = expr_ord.comply(eI,eII);
      //   if(ord.is_not_less_than()){
      //     ord = Ord.String().comply(fieldI,fieldII);
      //   }
      //   ord;
      // #end
      // case [EParenthesis(eI),EParenthesis(eII)] :
      //   comply(eI,eII);
      // case [EObjectDecl(fieldsI),EObjectDecl(fieldsII)] :
      //   Ord.Cluster(new HObjectField()).comply(fieldsI,fieldsII);
      // case [EArrayDecl(valuesI),EArrayDecl(valuesII)] :
      //   Ord.Cluster(this).comply(valuesI,valuesII);
      // case [ECall(eI,paramsI),ECall(eII,paramsII)] :
      //   var ord = expr_ord.comply(eI,eII);
      //   if(ord.is_not_less_than()){
      //     ord = Ord.Cluster(this).comply(paramsI,paramsII);
      //   }
      //   ord;
      // case [ENew(tI,paramsI),ENew(tII,paramsII)] :
      //   var ord = new HTypePath().comply(tI,tII);
      //   if(ord.is_not_less_than()){
      //     ord = Ord.Cluster(this).comply(paramsI,paramsII);
      //   }
      //   ord;
      // case [EUnop(opI,postFixI,eI),EUnop(opII,postFixII,eII)] :
      //   var ord = new stx.assert.makro.expr.ord.Unop().comply(opI,opII);
      //   if(ord.is_not_less_than()){
      //     ord = Ord.Bool().comply(postFixI,postFixII);
      //   }
      //   if(ord.is_not_less_than()){
      //     ord = expr_ord.comply(eI,eII);
      //   }
      //   ord;
      // case [EVars(varsI),EVars(varsII)] :
      //   Ord.Cluster(new HVar()).comply(varsI,varsII);
      // case [EFunction(kindI,fI),EFunction(kindII,fII)] :
      //   var ord = Ord.NullOr(new HFunctionKind()).comply(kindI,kindII);
      //   if(ord.is_not_less_than()){
      //     ord = new HFunction().comply(fI,fII);
      //   }
      //   ord;
      // case [EBlock(exprsI),EBlock(exprsII)] :
      //   Ord.Cluster(this).comply(exprsI,exprsII);
      // case [EFor(iI,eexprI),EFor(iII,eexprII)] :
      //   var ord = expr_ord.comply(iI,iII);
      //   if(ord.is_not_less_than()){
      //     ord = expr_ord.comply(eexprI,eexprII);
      //   }
      //   ord;
      // case [EIf(econdI,eifI,eelseI),EIf(econdII,eifII,eelseII)] :
      //   var ord = expr_ord.comply(econdI,econdII);
      //   if(ord.is_not_less_than()){
      //     ord = expr_ord.comply(eifI,eifII);
      //   }
      //   if(ord.is_not_less_than()){
      //     ord = Ord.NullOr(this).comply(eelseI,eelseII);
      //   }
      //   ord;
      // case [EWhile(econdI,eI,normalWhileI),EWhile(econdII,eII,normalWhileII)] :
      //   var ord = expr_ord.comply(econdI,econdII);
      //   if(ord.is_not_less_than()){
      //     ord = expr_ord.comply(eI,eII);
      //   }
      //   if(ord.is_not_less_than()){
      //     ord = Ord.Bool().comply(normalWhileI,normalWhileII);
      //   }
      //   ord;
      // case [ESwitch(eI,casesI,edefI),ESwitch(eII,casesII,edefII) ] :
      //   var ord = expr_ord.comply(eI,eII);
      //   if(ord.is_not_less_than()){
      //     ord = Ord.Cluster(new HCase()).comply(casesI,casesII);
      //   }
      //   if(ord.is_not_less_than()){
      //     ord = Ord.NullOr(this).comply(edefI,edefII);
      //   }
      //   ord;
      // case [ETry(eI,catchesI),ETry(eII,catchesII)] :
      //   var ord = expr_ord.comply(eI,eII);
      //   if(ord.is_not_less_than()){
      //     ord = Ord.Cluster(new HCatch()).comply(catchesI,catchesII);
      //   }
      //   ord;
      // case [EReturn(eI),EReturn(eII)] :
      //   comply(eI,eII);
      // case [EBreak,EBreak] :
      //   NotLessThan;
      // case [EContinue,EContinue] :
      //   NotLessThan;
      // case [EUntyped(eI),EUntyped(eII)] :
      //   expr_ord.comply(eI,eII);
      // case [EThrow(eI),EThrow(eII)] :
      //   expr_ord.comply(eI,eII);
      // case [ECast(eI,tI),ECast(eII,tII)] :
      //   var ord = expr_ord.comply(eI,eII);
      //   if(ord.is_not_less_than()){
      //     ord = Ord.NullOr(new HComplexType()).comply(tI,tII);
      //   }
      //   ord;
      // case [ETernary(econdI,eifI,eelseI),ETernary(econdII,eifII,eelseII)] :
      //   var ord = expr_ord.comply(econdI,econdII);
      //   if(ord.is_not_less_than()){
      //     ord = expr_ord.comply(eifI,eifII);
      //   }
      //   if(ord.is_not_less_than()){
      //     ord = expr_ord.comply(eelseI,eelseII);
      //   }
      //   ord;
      // case [ECheckType(eI,tI),ECheckType(eII,tII)] :
      //   var ord = expr_ord.comply(eI,eII);
      //   if(ord.is_not_less_than()){
      //     ord = Ord.NullOr(new HComplexType()).comply(tI,tII);
      //   }
      //   ord;
      // case [EMeta(sI,eI),EMeta(sII,eII)] :
      //   var ord = new HMetadataEntry().comply(sI,sII);
      //   if(ord.is_not_less_than()){
      //     ord = expr_ord.comply(eI,eII);
      //   }
      //   ord;
      // case [EIs(eI,tI),EIs(eII,tII)] :
      //   var ord = expr_ord.comply(eI,eII);
      //   if(ord.is_not_less_than()){
      //     ord = Ord.NullOr(new HComplexType()).comply(tI,tII);
      //   }
      //   ord;
      default : Ord.EnumValueIndex().comply(lhs.prj(),rhs.prj());
    }
  }
}