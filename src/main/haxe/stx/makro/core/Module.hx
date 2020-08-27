package stx.makro.core;

@:using(stx.makro.core.Module.ModuleLift)
@:forward abstract Module(SourceIdentDef) from SourceIdentDef{
  static public var _(default,never) = ModuleLift;
  public function new(self){
    this = self;
  }
  public function cons(str:String):Module{
    return switch([this.module,this.pack]){
      case [None,[]]        : { module : None, pack : [str], name : this.name};
      case [Some(md),[]]    : { module : Some(new haxe.io.Path('$str${md.sep()}$md')), pack : [] , name : this.name };
      case [None,arr]       : { module : None, pack : [str].concat(arr).prj(), name : this.name};
      case [Some(md),arr]   : { module : Some(new haxe.io.Path('$str${md.sep()}$md')), pack : [str].concat(arr).prj() , name : this.name } ;
    }
  }
  public function call(str):MethodRef{
    return MethodRef.fromModule(this,str);
  }
  
  public function equals(that:SourceIdentDef){
    var thix = new SourceIdent(this);
    var thax = new SourceIdent(that);
    return thix.eq(thax);
  }
}
class ModuleLift{
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