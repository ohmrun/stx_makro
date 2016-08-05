package stx.macro;

class BaseTypes{
  static public function hasPack(b:BaseType){
    return b.pack != null && b.pack.length > 0;
  }
  static public function isSecondaryType(b:BaseType){
    var module_els = b.module.split(".");
    var out        = module_els[module_els.length-1] != b.name;
    return out;
  }
}
