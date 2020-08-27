package stx.makro.type;

@:forward abstract TypeParam(Module){
  private function new(s){
    this = s;
  }
  @:from static public function fromType(type:Type):TypeParam{
    return new TypeParam(switch(type){
      case TInst(t, [])             : type.getModule().force(); 
      default                       : throw __.fault().of(UnexpectedMacroCondition);
    });
  }
}