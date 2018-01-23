package stx.macro.expr;

import stx.macro.Exprs;

class Catches{
    static public function eq(l:Catch,r:Catch):Bool{
        return l.name == r.name 
            && ComplexTypes.eq(l.type,r.type)
            && Exprs.eq(l.expr,r.expr);
    }
    static public function eqR(eq:Selector->Selector->Bool){
        return function(l:Catch,r:Catch):Bool{
            return l.name == r.name 
            && eq(SComplexType(l.type),SComplexType(r.type))
            && eq(SExpr(l.expr),SExpr(r.expr));
        }
    }
}