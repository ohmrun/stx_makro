package stx.makro.type;

class HClassTypeCtr extends Clazz{

}
@:using(stx.makro.type.HClassType.HClassTypeLift)
@:forward abstract HClassType(ClassType) from ClassType to ClassType{
  static public var _(default,never) = HClassTypeLift;
  public function new(self)this = self;
  @:noUsing static public inline function lift(self:ClassType) return new HClassType(self);
  
  public function prj():ClassType{
    return this;
  }
  @:to public function toBaseType():BaseType{
    return this;
  }
  public function get_interface(?ancestors:Bool):Array<HClassAndParam>{ return _.get_interface(this,ancestors); }

/**
 * This aliases weirdly
*/
//public var fields(get,never):Cluster<HClassField>;
  public function get_fields():Cluster<HClassField>{
    return this.fields.get();
  }
}
class HClassTypeLift{
  @:noUsing static public function get_interface(ct:HClassType,?ancestors:Bool=false):Array<HClassAndParam>{
    return switch(ancestors){
      case true   : 
        ct.prj().interfaces
          .map((x) -> (x:HClassAndParam))
          .concat(
            HClassType._.get_ancestors(ct)
              .flat_map(
                (x) -> {
                  return x.data.get_interface(ancestors).map((x) -> (x:HClassAndParam));
                }
              )
          );
      case false  : ct.prj().interfaces.map((x) -> (x:HClassAndParam));
    }
  }
  static public function get_ancestors(c:HClassType):Array<HClassAndParam>{
    var out = __.option(c.superClass).map(
      function rec(x:{t:Ref<ClassType>, params:StdArray<StdMacroType>}):Array<HClassAndParam>{
        var next : HClassType = x.t.get();
        return __.option(next.superClass).map(rec).map(
          (y) -> [(x:HClassAndParam)].concat(y)
        ).defv([(x:HClassAndParam)]);
      }
    ).defv([]);
    return out;
  }
  static public function copy(self:HClassType,
      ?pack:Array<String>,
      ?name:String,
      ?module:String,
      ?pos:haxe.macro.Expr.Position,
      ?isPrivate:Bool,
      ?isExtern:Bool,
      ?params:Array<TypeParameter>,
      ?meta:MetaAccess,
      ?doc:Null<String>,
      ?exclude:()->Void,
      ?kind:ClassKind,
      ?isInterface:Bool,
      ?isFinal:Bool,
      ?isAbstract:Bool,
      ?superClass:Null<{t:Ref<ClassType>, params:Array<Type>}>,
      ?interfaces:Array<{t:Ref<ClassType>, params:Array<Type>}>,
      ?fields:Ref<Array<ClassField>>,
      ?statics:Ref<Array<ClassField>>,
      ?constructor:Null<Ref<ClassField>>,
      ?init:Null<TypedExpr>,
      ?overrides:Array<Ref<ClassField>>
  ):HClassType{
    return {
      pack        : __.option(pack).def(() -> self.pack),
      name        : __.option(name).def(() -> self.name),
      module      : __.option(module).def(() -> self.module),
      pos         : __.option(pos).def(() -> self.pos),
      isPrivate   : __.option(isPrivate).def(() -> self.isPrivate),
      isExtern    : __.option(isExtern).def(() -> self.isExtern),
      params      : __.option(params).def(() -> self.params),
      meta        : __.option(meta).def(() -> self.meta),
      doc         : __.option(doc).def(() -> self.doc),
      exclude     : __.option(exclude).def(() -> self.exclude),
      kind          : __.option(kind).def(() -> self.kind),
      isInterface   : __.option(isInterface).def(() -> self.isInterface),
      isFinal       : __.option(isFinal).def(() -> self.isFinal),
      isAbstract    : __.option(isAbstract).def(() -> self.isAbstract),
      superClass    : __.option(superClass).def(() -> self.superClass),
      interfaces    : __.option(interfaces).def(() -> self.interfaces),
      fields        : __.option(fields).def(() -> self.fields),
      statics       : __.option(statics).def(() -> self.statics),
      constructor   : __.option(constructor).def(() -> self.constructor),
      init          : __.option(init).def(() -> self.init),
      overrides     : __.option(overrides).def(() -> self.overrides)
    };
  }
  // static public function toTypeRef(self:HClassType,params){
  //   return TInst({
  //     get : self,
  //     toString : 
  //   })
  // }
}