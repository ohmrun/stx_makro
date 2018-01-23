package stx.macro.expr;

enum Selector{
    SExpr(e:Expr);
    SComplexType(c:ComplexType);
    SParams(arr:Array<Expr>);
}