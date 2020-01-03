package stx.macro.expr.head.data;

enum Selector{
    SExpr(e:Expr);
    SComplexType(c:ComplexType);
    SParams(arr:Array<Expr>);
}