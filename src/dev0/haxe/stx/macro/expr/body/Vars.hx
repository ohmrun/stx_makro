package stx.macro.expr.body;

class Vars{
    static public function eq(l:Var,r:Var):Bool{
        return l.name == r.name 
            && ComplexTypes.eq(l.type,r.type)
            && Exprs.eq(l.expr,r.expr);
    }
}