package stx.makro.type.body;

import haxe.ds.StringMap;


import stx.makro.alias.StdType;
import stx.makro.alias.StdClassType;

import stx.makro.type.pack.ClassAndParam;

class ClassTypes{
  @:noUsing static public function interfaces(ct:ClassType,?ancestors:Bool=false):Array<ClassAndParam>{
    return switch(ancestors){
      case true   : 
        ct.prj().interfaces
          .map((x) -> (x:ClassAndParam))
          .concat(
            ClassTypes.ancestors(ct)
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