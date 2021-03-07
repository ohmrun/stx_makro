package stx.makro.type;

typedef TFunParamDef = { t : StdType, opt : Bool, name : String };

@:forward abstract TFunParam(TFunParamDef) from TFunParamDef{
  public function equals(that:TFunParam){
    return 
      this.name == that.name && 
      this.opt == that.opt && 
      Type._.makro(this.t).getIdentity().equals(
        Type._.makro(that.t).getIdentity()
      );
  }
  public function getModule(){
    return Type.lift(this.t).getModule();
  }
}