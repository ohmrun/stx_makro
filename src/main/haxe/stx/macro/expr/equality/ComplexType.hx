package stx.macro.expr.equality;

import haxe.macro.Expr.ComplexType in ComplexTypeT;

class ComplexType{
    var expr : Expr;
    var type_path : TypePath;
    
    public function new(expr:Expr){
        this.expr = expr;
    }
    public function apply(l:ComplexTypeT,r:ComplexTypeT):Bool{
        return l.values.all(this.expr.apply)
        && expr.apply(l.guard)
        && expr.apply(l.expr);
    }
}