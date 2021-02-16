package stx.makro.expr.lift;

class LiftModuleToHExpr{
  static public function toHExpr(self:Module,pos){
    var id      = self;
    var efield  = HExprDef.EField;
    var ident   = Constant.CIdent.fn().then(x->HExpr._._.Constant.toHExpr(x,pos));
    var head    = id.name;

    function f(next,memo) return efield(memo,next).expr(pos);

    return switch([id.module,id.pack]){
      case [None,[]]      : ident(head);
      case [None,arr]     : 
        var arr = __.option(arr).defv([]).snoc(head);
        arr.tail().lfold(f,ident(arr.head().def(()->"")));
      case [Some(dir),_]  : 
        var arr = dir.into(head).toArray();
        arr.tail().lfold(f,ident(arr.head().def(()->"")));
    };
  }
}