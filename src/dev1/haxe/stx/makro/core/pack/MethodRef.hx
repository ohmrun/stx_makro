package stx.makro.core.pack;

import stx.makro.core.head.data.MethodRef in MethodRefT;

@:forward abstract MethodRef(MethodRefT) from MethodRefT{
  public function new(self){
    this = self;
  }
  static public function fromModule(ident:Module,call:String){
    return {
      name    : ident.name,
      pack    : ident.pack,
      module  : ident.module,
      call    : call
    }
  }
  public function toModule():Module{
    return {
      name : this.name,
      pack : this.pack,
      module : this.module
    };
  }
  @:noUsing public function expr(pos){ 
    var ref     = this;
    var efield  = ExprDefs.EField;
    var ident   = Constants.CIdent.fn().then(c -> c.expr(pos));
    var head    = ref.call;
    function f(next,memo) return efield(memo,next).expr(pos);

    return switch([ref.module,ref.pack,ref.name]){
      case [null,[],null]     : ident(head);
      case [null,[],name]     : f(name,ident(head));
      case [null,arr,name]    : 
        var arr0 = arr.snoc(name).snoc(head);
        arr0.tail().fold(f,ident(arr0.head().def(()->"")));
      case [str,_,name]       : 
        var arr0 = str.split(".").ds().snoc(head);
        arr0.tail().fold(f,ident(arr0.head().def(()->"")));
    }
  }
}