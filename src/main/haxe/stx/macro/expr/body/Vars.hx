package stx.macro.expr;

import stx.macro.Exprs;

class Vars{
    static public function eq(l:Var,r:Var):Bool{
        return l.name == r.name 
            && ComplexTypes.eq(l.type,r.type)
            && Exprs.eq(l.expr,r.expr);
    }
}