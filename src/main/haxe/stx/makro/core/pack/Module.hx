package stx.makro.core.pack;


@:forward abstract Module(SourceIdentDef) from SourceIdentDef{
  public function new(self){
    this = self;
  }
  public function cons(str:String):Module{
    return switch([this.module,this.pack]){
      case [None,[]]        : { module : None, pack : [str], name : this.name};
      case [Some(md),[]]    : { module : Some(new haxe.io.Path('$str${md.sep()}$md')), pack : [] , name : this.name };
      case [None,arr]       : { module : None, pack : [str].concat(arr).prj(), name : this.name};
      case [Some(md),arr]   : { module : Some(new haxe.io.Path('$str${md.sep()}$md')), pack : [str].concat(arr).prj() , name : this.name } ;
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
      case [None,[]]      : ident(head);
      case [None,arr]     : 
        var arr = __.of(arr).defv([]).snoc(head);
        arr.tail().lfold(f,ident(arr.head().def(()->"")));
      case [Some(dir),_]  : 
        var arr = dir.split().snoc(head);
        arr.tail().lfold(f,ident(arr.head().def(()->"")));
    };
  }
  public function equals(that:SourceIdentDef){
    var thix = new SourceIdent(this);
    var thax = new SourceIdent(that);
    return thix.eq(thax);
  }
}