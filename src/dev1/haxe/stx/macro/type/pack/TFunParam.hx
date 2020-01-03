package stx.macro.type.pack;

using stx.macro.Lift;

import stx.macro.type.head.data.TFunParam in TFunParamT;

@:forward abstract TFunParam(TFunParamT) from TFunParamT{
  public function equals(that:TFunParam){
    return 
      this.name == that.name && 
      this.opt == that.opt && 
      this.t.stx().getIdentity().equals(
        that.t.stx().getIdentity()
      );
  }
  public function getModule(){
    return (this.t:stx.macro.pack.Type).getModule();
  }
}