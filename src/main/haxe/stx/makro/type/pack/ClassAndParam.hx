package stx.makro.type.pack;

import stx.makro.alias.StdType;
import stx.makro.alias.StdClassType;
import stx.makro.type.head.data.ClassAndParam in ClassAndParamT;

@:forward abstract ClassAndParam(ClassAndParamT) from ClassAndParamT{
  public function new(self) this = self;
  
  @:from static public function fromType(obj:{t:Ref<StdClassType>, params:StdArray<StdType>}):ClassAndParam{
    var t = {
      get       : () -> (obj.t.get():ClassType),
      toString  : () -> obj.t.toString()
    };
    var p = obj.params.map(
      (x) -> (x:Type)
    );
    return new ClassAndParam({
      t       : t,
      params : p
    });
  }
}