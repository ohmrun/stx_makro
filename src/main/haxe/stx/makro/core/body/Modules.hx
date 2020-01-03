package stx.makro.core.body;

class Modules{
  static public function toString(id:Module){
    return switch([id.module,id.pack]){
      case [null,[]]  : id.name;
      case [null,arr] : '${arr.join(".")}.${id.name}';
      case [module,_] : '${module}.${id.name}';
    }
  }
  static public function toName(id:Module){
    return switch([id.module,id.pack]){
      case [null,[]]  : id.name;
      case [null,arr] : '${arr.join("_")}_${id.name}';
      case [module,_] : '${StringTools.replace(module,".","_")}_${id.name}';
    }
  }
}