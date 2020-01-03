package stx.macro.type.pack;

import stx.macro.type.head.data.Identity in IdentityT;
import stx.macro.type.body.Identities;

abstract Identity(IdentityT) from IdentityT to IdentityT{
  public function new(self:IdentityT) this = self;
  public function toString(){
    return Identities.toString(this);
  }
  public function toUniquePath(){
    return Identities.toUniquePath(this);
  }
  public function isAnonymous(){
    return switch(this){
      case TLambda(_,_), TAnon(_) : true;
      default : false;
    }
  }
}