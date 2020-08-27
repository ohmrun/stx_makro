package stx.makro.type;

typedef ClassAndParamDef = { t : Ref<ClassType>, params:Array<Type> };

@:forward abstract ClassAndParam(ClassAndParamDef) from ClassAndParamDef{
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