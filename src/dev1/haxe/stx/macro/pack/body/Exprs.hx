package stx.macro.pack.body;

class Exprs{
  static public function mod<T>():FTC<Monoid<T>,Expr,T>{
    return function rec(fn:FTC<Monoid<T>,Expr,T>){
      return function(m:Monoid<T>,e:Expr):T{
        function f(e:Expr) return fn(rec)(m,e);
        function fld(next:Expr,memo:T) return m.batch(memo,f(next));
        return switch(e.expr){
          case EConst(c)            :   m.prior();
          case EArray(e1, e2)       :   
            var l = f(e1);
            var r = f(e2);
            m.batch(l,r);
          case EBinop(op, e1, e2)   :   m.batch(f(e1),f(e2));   
          case EField(e, field)     :   f(e);
          case EParenthesis( e )    :   f(e);
          case EObjectDecl( fields ):   m.prior();//TODO
          case EArrayDecl(values)   :
            values.fold(fld,m.prior());
          case ECall( e , params  ) : 
            params.fold(fld,f(e));
          case ENew( t , params )   : 
            params.fold(fld,m.prior());
          case EUnop( op , postFix , e ):
            f(e);
          case EVars( vars ):
            m.prior();
          case EFunction( name , f ):
            m.prior();
          case EBlock( exprs ):
            exprs.fold(fld,m.prior());
          case EFor( it, expr ):
            m.batch(f(it),f(expr));
          case EIf( econd , eif , eelse ):
            m.batch(m.batch(f(econd),f(eif)),f(eelse));
          case EWhile( econd , e , normalWhile  ):
            var next = m.batch(f(econd),f(e));
            next;
          case ESwitch( e, cases, edef):
            var head  = f(e);
            var cases = cases.fold(
            (next,memo) -> m.batch(memo,Cases.foldKeys(m,next)(f))
            ,m.prior());
            var next = m.batch(head,cases);
            if(edef!=null){
              next = m.batch(next,f(edef));
            }
            next;
          case ETry( e, catches ):
            var head = f(e);
            var rest = catches.map((c) -> c.expr).fold(fld,m.prior());
            m.batch(head,rest);
          case EReturn(e):
            f(e);
          case EBreak: 
            m.prior();
          case EContinue:
            m.prior();
          case EUntyped( e ):
            f(e);
          case EThrow( e  ):
            f(e);
          case ECast( e , t ):
            f(e);
          case EDisplay( e , displayKind):
            f(e);
          case EDisplayNew( t ):
            m.prior();
          case ETernary( econd , eif, eelse ):
            [econd,eif,eelse].fold(fld,m.prior());
          case ECheckType( e , t  ):
            f(e);
          case EMeta( s , e ):
            f(e);
        }
      }
    }
  }
}