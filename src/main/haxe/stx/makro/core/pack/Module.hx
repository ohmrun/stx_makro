package stx.makro.core.pack;

using stx.makro.Lift;

import stx.makro.core.head.data.Module in ModuleT;

@:forward abstract Module(ModuleT) from ModuleT{

  public function cons(str:String):Module{
    return switch([this.module,this.pack]){
      case [null,[]]  : { module : null, pack : [str], name : this.name};
      case [null,arr] : { module : null, pack : [str].ds().concat(arr), name : this.name};
      case [md,[]]    : { module : '$str.$md', pack : [] , name : this.name };
      case [md,arr]   : { module : '$str.$md', pack : [str].ds().concat(arr) , name : this.name } ;
    }
  }
  public function call(str):MethodRef{
    return MethodRef.fromModule(this,str);
  }
  @:noUsing public function expr(pos){
    var id      = this;
    var efield  = ExprDefs.EField;
    var ident   = Constants.CIdent.fn().then(x->x.expr(pos));
    var head    = id.name;

    function f(next,memo) return efield(memo,next).expr(pos);

    return switch([id.module,id.pack]){
      case [null,[]]  : ident(head);
      case [null,arr] : 
        var arr = arr.snoc(head);
        arr.tail().fold(f,ident(arr.head().def(()->"")));
      case [str,_]  : 
        var arr = str.split(".").ds().snoc(head);
        arr.tail().fold(f,ident(arr.head().def(()->"")));
    }
  }
  public function toString():String{
    return switch([this.module,this.pack]){
      case [null,[]]  : this.name;
      case [null,arr] : arr.snoc(this.name).join(".");
      case [md,[]]    : '$md.${this.name}';
      case [md,arr]   : '$md.${this.name}';
    }
  }
}