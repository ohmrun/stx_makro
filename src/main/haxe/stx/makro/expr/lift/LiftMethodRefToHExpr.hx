package stx.makro.expr.lift;

class LiftMethodRefToHExpr{
  static public function toHExpr(self:MethodRef,pos){ 
    var ref     = self;
    var efield  = HExprDef.EField;
    var ident   = Constant.CIdent.fn().then(c -> LiftHExpr.Constant.toHExpr(c,pos));
    var head    = ref.call;
    function f(next,memo) return efield(memo,next).expr(pos);

    return switch([ref.module,ref.pack,ref.name]){
      case [null,[],null]     : ident(head);
      case [null,[],name]     : f(name,ident(head));
      case [null,arr,name]    : 
        var arr0 = arr.snoc(name).snoc(head);
        arr0.tail().lfold(f,ident(arr0.head().def(()->"")));
      case [str,_,name]       : 
        var arr0 = str.map(
          (dir) -> dir.into(head).toArray()
        ).defv([]);
        arr0.tail().lfold(f,ident(arr0.head().def(()->"")));
    }
  }
}