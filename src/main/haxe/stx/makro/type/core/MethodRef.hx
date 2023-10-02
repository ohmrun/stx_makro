package stx.makro.type.core;

typedef MethodRefDef = {
  >MonikerDef,
  call : String,
}

@:forward abstract MethodRef(MethodRefDef) from MethodRefDef{
  public function new(self){
    this = self;
  }
  static public function fromMoniker(ident:Moniker,call:String):MethodRef{
    return {
      name    : ident.name,
      pack    : __.option(ident.pack).def(Way.unit),
      module  : ident.module,
      call    : call
    }
  }
  public function toMoniker():Moniker{
    return {
      name    : this.name,
      pack    : this.pack,
      module  : this.module
    };
  }
  /**
   * TODO:: Does the compiler report different module structure at different times?
   */
  public function canonical(){
    return switch(this.module){
      case Some(v) : [v.toString()].imm().snoc(this.call).join(".");
      default      : __.option(this.pack).defv(Way.unit()).toCluster().snoc(this.name).snoc(this.call).join(".");
    }
  }
}