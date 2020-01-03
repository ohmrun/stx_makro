package stx.macro.expr.pack;

import stx.macro.expr.head.Data.FieldPath in FieldPathT;

@:forward abstract FieldPath(FieldPathT) from FieldPathT{
    public function new(self){
        this = self;
    }
    @:from static public function fromExpr(e:Expr):FieldPath{
        function rec(e:Expr,path:Array<String>){
            var next = path.copy();
            return switch (e.expr) {
                case EField(e,field)    :
                next.unshift(field);
                rec(e,next);
                case EConst(CIdent(s))  :
                next.unshift(s);
                next;
                default                 : [];
            }
        }
        return new FieldPath(rec(e,[]));
    }
    public function toString(){
        return this.join(".");
    }
    public function toExpr(){
        var array = this.copy();
        var head  = TkExprs.at(EConst(CIdent(array.first())));
        var rest  = array.dropLeft(1);
        return rest.foldLeft(head,
            function(memo,next){
                return TkExprs.at(EField(memo,next));
            }
        );
    }
    public function isDefined(){
        return this.length > 0;
    }
    public var name(get,never) : Option<String>;
    private function get_name():Option<String>{
        return this.length > 0 ? Some(this[this.length - 1]) : None;
    }
}