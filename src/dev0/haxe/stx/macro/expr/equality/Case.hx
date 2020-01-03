package stx.macro.expr.equality;

import haxe.macro.Expr.Case in CaseT;

class Case{
    var expr : Expr;
    public function new(expr:Expr){
        this.expr = expr;
    }
    public function apply(l:CaseT,r:CaseT):Bool{
        return l.values.all(this.expr.apply)
        && expr.apply(l.guard)
        && expr.apply(l.expr);
    }
}