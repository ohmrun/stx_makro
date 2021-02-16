package stx.makro.expr;

@:forward abstract HExpr(haxe.macro.Expr){
  static public var _(default,never)             = HExprLift;
  static public var ZERO(default,never) : HExpr  = lift({ expr : EBlock([]), pos : null });
  public function new(self:haxe.macro.Expr){
    this = self;
  } 
  @:noUsing static public function lift(self:haxe.macro.Expr):HExpr{
    return new HExpr(self);
  }
  @:noUsing static public function mark(pos:Pos):HExpr{
    return HExprDef.MARK.expr(pos);
  }
  @:noUsing static public function unit(pos:Pos):HExpr{
    return HExprDef.ZERO.expr(pos);
  }  
  public function getType():stx.makro.Type{
    return stx.makro.Type._.getType(self);
  }
  static public function ref(str:String,pos):HExpr{
    return lift({
      pos : pos,
      expr : EConst(CIdent(str))
    });
  }
  public inline function toExpr() return prj();
  public function prj():haxe.macro.Expr return this;

  public function show(){
    var printer = new haxe.macro.Printer();
    return printer.printExpr(this);
  }
  public var self(get,never):HExpr;
  private function get_self():HExpr{
    return lift(this);
  }
}
class HExprLift{
  static public var _(default,never) = new LiftHExpr();

  @:noUsing static function lift(self:haxe.macro.Expr):HExpr return HExpr.lift(self);

  /*
  static public function mod<T>():Y<Couple<Monoid<T>,HExpr>,T>{
    return function rec(fn:Y<Couple<Monoid<T>,HExpr>,T>){
      return function(tp:Couple<Monoid<T>,HExpr>):T{
        var m = tp.fst();
        var e = tp.snd();
        function f(e:HExpr) return fn(rec)(__.couple(m,e));
        function fld(next:HExpr,memo:T) return m.plus(memo,f(next));
        return switch(e.expr){
          case EConst(c)            :   m.unit();
          case EArray(e1, e2)       :   
            var l = f(lift(e1));
            var r = f(lift(e2));
            m.plus(l,r);
          case EBinop(op, e1, e2)   :   m.plus(f(lift(e1)),f(lift(e2)));   
          case EField(e, field)     :   f(lift(e));
          case EParenthesis( e )    :   f(lift(e));
          case EObjectDecl( fields ):   m.unit();//TODO
          case EArrayDecl(values)   :
            HExprArray.lift(values).fold(fld,m.unit());
          case ECall( e , params  ) : 
            HExprArray.lift(params).fold(fld,f(lift(e)));
          case ENew( t , params )   : 
            HExprArray.lift(params).fold(fld,m.unit());
          case EUnop( op , postFix , e ):
            f(lift(e));
          case EVars( vars ):
            m.unit();
          case EFunction( name , f ):
            m.unit();
          case EBlock( exprs ):
            HExprArray.lift(exprs).fold(fld,m.unit());
          case EFor( it, expr ):
            m.plus(f(lift(it)),f(lift(expr)));
          case EIf( econd , eif , eelse ):
            m.plus(m.plus(f(lift(econd)),f(lift(eif))),f(lift(eelse)));
          case EWhile( econd , e , normalWhile  ):
            var next = m.plus(f(lift(econd)),f(lift(e)));
            next;
          case ESwitch( e, cases, edef):
            var head  = f(lift(e));
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
  }*/
}
class LiftHExpr extends Clazz{
  static public function makro(e:haxe.macro.Expr):HExpr{
    return HExpr.lift(e);
  }
  
  public var Constant = {
    toHExpr : (self:Constant,?p:Pos) -> LiftConstantToHExpr.toHExpr(self,p)
  }
  public var MethodRef = {
    toHExpr : (self:MethodRef,?p:Pos) -> LiftMethodRefToHExpr.toHExpr(self,p)
  }
  public var Module = {
    toHExpr : (self:Module,?p:Pos) -> LiftModuleToHExpr.toHExpr(self,p)
  }
}