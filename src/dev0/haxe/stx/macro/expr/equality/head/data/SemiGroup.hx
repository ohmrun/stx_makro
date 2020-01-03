package stx.macro.expr.equality.head.data;

interface SemiGroup<T>{
    public function Expr(l:Expr,r:Expr):T;
    public function ComplexType(l:ComplexType,r:ComplexType):T;
    public function Case(l:Case,r:Case):T;
}