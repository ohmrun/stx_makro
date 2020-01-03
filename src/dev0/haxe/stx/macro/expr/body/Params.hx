package stx.macro.expr.body;

class Params{
    static public function eq(l:Array<Expr>,r:Array<Expr>){
        return l.zip(r).all(
            (tp) -> Exprs.eq(tp._0,tp._1)
        );
    }
}