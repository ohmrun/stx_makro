package stx.macro.expr.body;

class Cases{
    static public function eq(l:Case,r:Case):Bool{
        return Params.eq(l.values,r.values)
            && Exprs.eq(l.guard,r.guard)
            && Exprs.eq(l.expr,r.expr);
    }
    static public function eqR(eq:Selector->Selector->Bool){
        return function(l:Case,r:Case){
            return eq(SParams(l.values),SParams(r.values))
            && eq(SExpr(l.guard),SExpr(r.guard))
            && eq(SExpr(l.expr),SExpr(r.expr));
        }
    }
}
