package stx.makro.type.pack;

using stx.makro.Lift;

import stx.makro.type.head.data.TFunParam in TFunParamT;

@:forward abstract TFunParam(TFunParamT) from TFunParamT{
  public function equals(that:TFunParam){
    return 
      this.name == that.name && 
      this.opt == that.opt && 
      this.t.makro().getIdentity().equals(
        that.t.makro().getIdentity()
      );
  }
  public function getModule(){
    return (this.t:stx.makro.pack.Type).getModule();
  }
}