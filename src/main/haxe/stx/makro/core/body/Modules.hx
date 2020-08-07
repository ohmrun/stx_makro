package stx.makro.core.body;

class Modules{
  static public function toString(id:Module){
    return switch([id.module,id.pack]){
      case [None,[]]  : id.name;
      case [None,arr] : '${arr.join(".")}.${id.name}';
      case [Some(module),_] : '${module}.${id.name}';
    }
  }
  static public function toName(id:Module){
    return switch([id.module,id.pack]){
      case [None,[]]  : id.name;
      case [None,arr] : '${arr.join("_")}_${id.name}';
      case [Some(module),_] : '${StringTools.replace(module.toString(),module.sep(),"_")}_${id.name}';
    }
  }
}