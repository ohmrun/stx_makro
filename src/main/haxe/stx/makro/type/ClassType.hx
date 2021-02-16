package stx.makro.type;

import stx.makro.alias.StdClassType;

@:using(stx.makro.type.ClassType.ClassTypeLift)
@:forward abstract ClassType(StdClassType) from StdClassType to StdClassType{
  static public var _(default,never) = ClassTypeLift;
  public function new(self){
    this = self;
  }
  public function prj():StdClassType{
    return this;
  }
  @:to public function toBaseType():BaseType{
    return this;
  }
  public function interfaces(ancestors){ return _.interfaces(this,ancestors); }
}
class ClassTypeLift{
  @:noUsing static public function interfaces(ct:ClassType,?ancestors:Bool=false):Array<ClassAndParam>{
    return switch(ancestors){
      case true   : 
        ct.prj().interfaces
          .map((x) -> (x:ClassAndParam))
          .concat(
            ClassType._.ancestors(ct)
              .flat_map(
                (x) -> {
                  return x.t.get().prj().interfaces.map((x) -> (x:ClassAndParam));
                }
              )
          );
      case false  : ct.prj().interfaces.map((x) -> (x:ClassAndParam));
    }
  }
  static public function ancestors(c:ClassType):Array<ClassAndParam>{
    var out = __.option(c.superClass).map(
      function rec(x:{t:Ref<StdClassType>, params:StdArray<StdType>}):Array<ClassAndParam>{
        var next : ClassType = x.t.get();
        if(c.name == "NotherConfig"){
          //trace(next);
        }
        return __.option(next.superClass).map(rec).map(
          (y) -> [(x:ClassAndParam)].concat(y)
        ).defv([(x:ClassAndParam)]);
      }
    ).defv([]);
    return out;
  }
}