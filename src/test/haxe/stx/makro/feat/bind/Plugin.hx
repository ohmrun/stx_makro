package stx.makro.feat.bind;

import haxe.macro.TypeTools.toComplexType;

class Plugin{
  static public macro function use(){
    trace('stx.makro.feat.bind.Plugin.use');
    haxe.macro.Context.onTypeNotFound(apply);
    return macro {};
  }
  static public function apply(type_name:String):TypeDefinition{
    final x = (type_name:Chars).starts_with("stx.gen");
    if(x == true){
      //trace(type_name);
      final ident     = Identifier.pure(type_name).toIdent();
      final pack      = ident.pack.prj();
      final pack_head = pack.ldropn(2);
      final plugin    = pack_head.head();
      final target    = Ident.make(ident.name,pack_head);
      trace('$target');
      final type      = Context.getType(target.canonical());
      trace(type);
      toComplexTypeStx(type);
    }
    return null;
  }
  static public function toComplexTypeStx(type:HType){
    function perhaps_apply(params:Array<TypeParameter>,applied_params:Array<Type>){
      return params.zip(applied_params).map(
        __.decouple(
          (param:TypeParameter,applied_param:HType) -> {
            trace('${param} ${applied_param}');
            return applied_param.is_mono() ? param.t : applied_param;
          }
        )
      );
    }
    function rec(type){
      return switch(type){
        case TMono(t)               : type;
        case TEnum(t,params)        : 
          final applied = perhaps_apply(t.get().params,params);
          TEnum(t,applied);
        case TInst(t,params)        : 
          final applied = perhaps_apply(t.get().params,params);
          TInst(t,applied);
        case TType(t,params)        : 
          final applied = perhaps_apply(t.get().params,params);
          TType(t,applied);
        case TFun(args, ret)        : 
          final args  = args.map(x -> { name : x.name, opt : x.opt, t : rec(x.t)});
          final ret   = rec(ret);
          TFun(args,ret);
        case TAnonymous(a)          : 
          final t = a.get();
          TAnonymous(
            {
              get : () -> {
                status :  t.status,
                fields : t.fields.map((cf:HClassField) -> cf.copy(null,rec(cf.type)))
              },
              toString : a.toString
            }
          );
        case TDynamic(t)            : TDynamic(
          t == null ? null : rec(t)
        );
        case TLazy(f)               : TLazy(() -> rec(f()));
        case TAbstract(t, params)   : 
          final applied = perhaps_apply(t.get().params,params);
          TAbstract(t,applied);
      }
    }
    return rec(type);
  }
}