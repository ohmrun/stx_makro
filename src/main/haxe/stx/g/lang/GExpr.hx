package stx.g.lang;

enum GExprSum{
  GEConst(c:GConstant);
  GEArray(e1:GExpr, e2:GExpr);
  GEBinop(op:GBinop, e1:GExpr, e2:GExpr);
  GEField(e:GExpr, field:String, ?kind:GFieldKind);
  GEParenthesis(e:GExpr);
  GEObjectDecl(fields:Cluster<GObjectField>);
  GEArrayDecl(values:Cluster<GExpr>);
  GECall(e:GExpr, params:Cluster<GExpr>);
  GENew(t:GTypePath, params:Cluster<GExpr>);
  GEUnop(op:GUnop, postFix:Bool, e:GExpr);
  GEVars(vars:Cluster<GVar>);
  GEFunction(kind:Null<GFunctionKind>, f:GFunction);
  GEBlock(exprs:Cluster<GExpr>);
  GEFor(it:GExpr, Gexpr:GExpr);
  GEIf(econd:GExpr, eif:GExpr, eelse:Null<GExpr>);
  GEWhile(econd:GExpr, e:GExpr, normalWhile:Bool);
  GESwitch(e:GExpr, cases:Cluster<GCase>, edef:Null<GExpr>);
  GETry(e:GExpr, catches:Cluster<GCatch>);
  GEReturn(?e:GExpr);
  GEBreak;
  GEContinue;
  GEUntyped(e:GExpr);
  GEThrow(e:GExpr);
  GECast(e:GExpr, t:Null<GComplexType>);
  GETernary(econd:GExpr, eif:GExpr, eelse:GExpr);
  GECheckType(e:GExpr, t:GComplexType);
  GEMeta(s:GMetadataEntry, e:GExpr);
  GEIs(e:GExpr, t:GComplexType);
}
class GExprCtr extends Clazz{
  static public function unit(){
    return new GExprCtr(); 
  } 
  private function lift(self:GExprSum){
    return GExpr.lift(self);
  }
  public function Const(c:GConstantCtr->GConstant){
    return lift(GEConst(c(GConstant.__)));
  } 
  public function Path(name:String,pack:Cluster<String>){
    return pack.rfold(
      (next:String,memo:GExpr) -> this.Field(
        _ -> memo,
        next        
      ),
      this.Const(_ -> _.Ident(name))
    );
  }
  public function Array(lhs,rhs){
    return lift(GEArray(lhs(this),rhs(this)));
  }
  public function Binop(op,l,r){
    return lift(GEBinop(op,l(this),r(this)));
  }
  public function Field(e,field,?kind){
    return lift(GEField(e(this),field,kind));
  }
  public function Parenthesis(e){
    return lift(GEParenthesis(e(this)));
  }
  public function Parens(e){
    return lift(GEParenthesis(e(this)));
  }
  public function ObjectDecl(fields){
    return lift(GEObjectDecl(fields(GObjectField.__)));
  }
  public function ArrayDecl(values){
    return lift(GEArrayDecl(values(this)));
  }
  public function Call(e,params){
    return lift(GECall(e(this),params(this)));
  }
  public function New(t,params){
    return lift(GENew(t(GTypePath.__),params(this)));
  }
  public function Unop(op,postFix,e){
    return lift(GEUnop(op,postFix,e(this)));
  }
  public function Vars(vars){
    return lift(GEVars(vars(GVar.__)));
  }
  public function Function(f,?kind){
    return lift(GEFunction(kind,f(GFunction.__)));
  }
  public function Block(exprs){
    return lift(GEBlock(exprs(this)));
  }
  public function For(it,expr){
    return lift(GEFor(it(this),expr(this)));
  }
  public function If(it,expr,?eelse){
    return lift(GEIf(it(this),expr(this),__.option(eelse).map(f -> f(this)).defv(null)));
  }
  public function While(econd,expr,normalWhile){
    return lift(GEWhile(econd(this),expr(this),normalWhile));
  }
  public function Switch(e,cases,?edef){
    return lift(GESwitch(e(this),cases(this),__.option(edef).map( f -> f(this)).defv(null)));
  }
  public function Try(e,catches){
    return lift(GETry(e(this),catches(this)));
  }
  public function Return(?e){
    return lift(GEReturn(__.option(e).map(f -> f(this)).defv(null)));
  }
  public function Break(){
    return lift(GEBreak);
  }
  public function Continue(){
    return lift(GEContinue);
  }
  public function Untyped(e){
    return lift(GEUntyped(e(this)));
  }
  public function Throw(e){
    return lift(GEThrow(e(this)));
  }
  public function Cast(e,t){
    return lift(GECast(e(this),__.option(t).map(f -> f(GComplexType.__)).defv(null)));
  }
  public function Ternary(cond,eif,eelse){
    return lift(GETernary(cond(this),eif(this),eelse(this)));
  }
  public function CheckType(e,t){
    return lift(GECheckType(e(this),t(GComplexType.__)));
  }
  public function Meta(s,e){
    return lift(GEMeta(s(GMetadataEntry.__),e(this)));
  }
  public function Is(e,t){
    return lift(GEIs(e(this),t(GComplexType.__)));
  }
}
abstract GExpr(GExprSum) {
  static public var __(default,never) = new GExprCtr();
  public function new(self) this = self;
  static public function lift(self:GExprSum):GExpr return new GExpr(self);

  public function prj():GExprSum return this;
  private var self(get,never):GExpr;
  private function get_self():GExpr return lift(this);
}

