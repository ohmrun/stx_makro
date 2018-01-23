package stx.macro;

import fig.core.Package;
import haxe.macro.Type;

class BaseTypes{
  static public function hasPack(b:BaseType):Bool{
    return b.pack != null && b.pack.length > 0;
  }
  /**
    Returns true if the type is found in a module with a name different to the module.
  */
  static public function isSecondaryType(b:BaseType){
    var module_els = b.module.split(".");
    var out        = module_els[module_els.length-1] != b.name;
    return out;
  }
  static public function equals(l:BaseType,r:BaseType){
    var lp : Ident = l;
    var rp : Ident = r;
    return (lp == rp) && l.module==r.module; 
  }
}
