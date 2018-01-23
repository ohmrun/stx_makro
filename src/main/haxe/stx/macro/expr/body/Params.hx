package stx.macro.expr;

class Params{
    static public function eq(l:Array<Expr>,r:Array<Expr>){
        return l.zip(r).all(
            function(tp){
                return stx.macro.Exprs.eq(tp._0,tp._1);
            }
        );
    }
}