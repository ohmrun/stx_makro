package stx.makro.core;

@:using(stx.makro.core.Module.ModuleLift)
@:forward abstract Module(ModuleDef) from ModuleDef{
  static public var _(default,never) = ModuleLift;
  public function new(self){
    this = self;
  }
  public function cons(str:String):Module{
    return switch([this.module,this.pack]){
      case [None,[]]        : { module : None, pack : [str], name : this.name};
      case [Some(md),[]]    : { module : Some(new haxe.io.Path('$str${__.sep()}$md')), pack : [] , name : this.name };
      case [None,arr]       : { module : None, pack : [str].concat(arr).prj(), name : this.name};
      case [Some(md),arr]   : { module : Some(new haxe.io.Path('$str${__.sep()}$md')), pack : [str].concat(arr).prj() , name : this.name } ;
    }
  }
  public function call(str):MethodRef{
    return MethodRef.fromModule(this,str);
  }
  
  public function equals(that:ModuleDef){
    var thix = Identifier.fromIdentDef(this);
    var thax = Identifier.fromIdentDef(that);
    return thix == thax && this.module.zip(that.module).map(__.decouple((l,r) -> l == r )).defv(true);
  }
  public var module(get,never) : Option<haxe.io.Path>;
  private function get_module(){
    return __.option(this.module).flatten();
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
      case [Some(module),_] : '${StringTools.replace(module.toString(),__.sep(),"_")}_${id.name}';
    }
  }
}