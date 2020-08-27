package stx.makro;

typedef MethodCall        = stx.makro.expr.MethodCall; 
typedef ExprDef           = stx.makro.expr.ExprDef;

typedef Constant          = stx.makro.expr.Constant;

typedef TypeDefKind       = stx.makro.expr.TypeDefKind;
typedef ClassTypeDefKind  = stx.makro.expr.ClassTypeDefKind;
typedef TypeDefinition    = stx.makro.expr.TypeDefinition;

typedef MetadataEntry     = stx.makro.expr.MetadataEntry;

typedef Cases             = stx.makro.expr.Cases;

@:forward abstract Expr(haxe.macro.Expr) to haxe.macro.Expr{
  static public var _(default,never) = ExprLift;
  static public var ZERO : Expr = { expr : EBlock([]), pos : null };
  static public function mark(pos:Pos):Expr{
    return ExprDef.MARK.expr(pos);
  }
  static public function unit(pos:Pos):Expr{
    return ExprDef.ZERO.expr(pos);
  }  
  public function new(self){
    this = self;
  }
  public function getType():stx.makro.Type{
    return stx.makro.Type._.getType(this);
  }
  static public function ref(str:String,pos){
    return {
      pos : pos,
      expr : EConst(CIdent(str))
    };
  }
  public function prj(){
    return this;
  }
  public function show(){
    var printer = new haxe.macro.Printer();
    return printer.printExpr(this);
  }
  public var self(get,never):Expr;
  private function get_self():Expr{
    return lift(this);
  }
}
class ExprLift{
  static public var _(default,never) = new LiftExpr();

  static public function mod<T>():Y<Couple<Monoid<T>,Expr>,T>{
    return function rec(fn:Y<Couple<Monoid<T>,Expr>,T>){
      return function(tp:Couple<Monoid<T>,Expr>):T{
        var m = tp.fst();
        var e = tp.snd();
        function f(e:Expr) return fn(rec)(__.couple(m,e));
        function fld(next:Expr,memo:T) return m.plus(memo,f(next));
        return switch(e.expr){
          case EConst(c)            :   m.unit();
          case EArray(e1, e2)       :   
            var l = f(e1);
            var r = f(e2);
            m.plus(l,r);
          case EBinop(op, e1, e2)   :   m.plus(f(e1),f(e2));   
          case EField(e, field)     :   f(e);
          case EParenthesis( e )    :   f(e);
          case EObjectDecl( fields ):   m.unit();//TODO
          case EArrayDecl(values)   :
            values.fold(fld,m.unit());
          case ECall( e , params  ) : 
            params.fold(fld,f(e));
          case ENew( t , params )   : 
            params.fold(fld,m.unit());
          case EUnop( op , postFix , e ):
            f(e);
          case EVars( vars ):
            m.unit();
          case EFunction( name , f ):
            m.unit();
          case EBlock( exprs ):
            exprs.fold(fld,m.unit());
          case EFor( it, expr ):
            m.plus(f(it),f(expr));
          case EIf( econd , eif , eelse ):
            m.plus(m.plus(f(econd),f(eif)),f(eelse));
          case EWhile( econd , e , normalWhile  ):
            var next = m.plus(f(econd),f(e));
            next;
          case ESwitch( e, cases, edef):
            var head  = f(e);
            var cases = cases.fold(
            (next,memo) -> m.plus(memo,Cases.foldKeys(m,next)(f))
            ,m.unit());
            var next = m.plus(head,cases);
            if(edef!=null){
              next = m.plus(next,f(edef));
            }
            next;
          case ETry( e, catches ):
            var head = f(e);
            var rest = catches.map((c) -> c.expr).fold(fld,m.unit());
            m.plus(head,rest);
          case EReturn(e):
            f(e);
          case EBreak: 
            m.unit();
          case EContinue:
            m.unit();
          case EUntyped( e ):
            f(e);
          case EThrow( e  ):
            f(e);
          case ECast( e , t ):
            f(e);
          case EDisplay( e , displayKind):
            f(e);
          case EDisplayNew( t ):
            m.unit();
          case ETernary( econd , eif, eelse ):
            [econd,eif,eelse].fold(fld,m.unit());
          case ECheckType( e , t  ):
            f(e);
          case EMeta( s , e ):
            f(e);
          case EIs(e,_) : 
            f(e);
        }
      }
    }
  }
}
class LiftExpr extends Clazz{
  static public function makro(e:StdExpr):Expr{
    return new stx.makro.Expr(e);
  }
  
  public var Constant = {
    toExpr : (self:Constant,?p:Pos) -> LiftConstantToExpr.toExpr(self,p)
  }
  public var MethodRef = {
    toExpr : (self:MethodRef,?p:Pos) -> LiftMethodRefToExpr.toExpr(self,p)
  }
  public var Module = {
    toExpr : (self:Module,?p:Pos) -> LiftModuleToExpr.toExpr(self,p)
  }
}
typedef LiftConstantToExpr        = stx.makro.expr.lift.LiftConstantToExpr;
typedef LiftMethodRefToExpr       = stx.makro.expr.lift.LiftMethodRefToExpr;
typedef LiftModuleToExpr          = stx.makro.expr.lift.LiftModuleToExpr;