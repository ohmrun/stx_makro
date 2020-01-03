package stx.macro.body;

import stx.ds.pack.Map;
import stx.ds.graph.Package;
import haxe.macro.Context;
import stx.macro.type.body.*;
import stx.macro.type.Package;
import stx.macro.core.Package;

class Types{ 
  static public function getMeta(t:Type){
    return (getBaseType(t):stx.core.pack.Option<BaseType>).map(
      (bt) -> bt.meta.get()
    ).def(()->[]);
  }
  static public function getType(e:Expr){
    return Context.typeof(e);
  }
  static public function getTypeVars(type:Type):Array<{id:TypeParam,type:Type}>{
    var implementations    = getParamImplementations(type);
    var params             = getBaseType(type).params;
    var fields             = getFields(type);
    var out = [];
    for (i in 0...params.length){
      var param = params[i];
      var p : TypeParam = param.t;
      trace(p);
      var impl = implementations[i];
      
      out.push({
        id : p,
        type : Context.follow(impl)
      });
    }
    return out;
  }
  static public function getFields(type:Type):Array<ClassField>{
    return switch(type){
      case TAnonymous( a ) : a.get().fields;
      case TInst(v,_)      : v.get().fields.get();
      default               : [];
    }
  }
  public static function isNativeArray(type:Type):Bool{
    return switch type {
      case getPath(type) => Some("Array"): true;
      default: false;
    }
  }
  public static function isTInst(type:Type):Bool{
    return switch type {
      case TInst(_,_): true;
      default : false;
    }
  }
  public static function isString(type:Type):Bool{
    return switch type {
      case getPath(type) => Some("String") : true;
      default : false;
    }
  }
  public static function isInt(type:Type):Bool{
    return switch(type){
      case getPath(type) => Some("StdTypes.Int"): true;
      default : false;
    }
  }
  static public function isInStdType(type:Type):Bool{
    return switch(type){
      case TAbstract(a,_) : 
        a.get().module == "StdTypes";
        default : false; 
    }
  }
  public static function isNativeList(type:Type):Bool{
    return switch type {
      case getPath(type) => Some("List"): true;
      default: false;
    }
  }
  static public function getPath(t:Type):Option<String>{
    var bt : BaseType = getBaseType(t);
    return switch(bt == null){
      case true   : None;
      case false :
        Some(if(!BaseTypes.isModuleNameConsistent(bt)){
          '${bt.module}.${bt.name}';
        }else{
          if(bt.hasPack()){
            '${bt.module}';
          }else{
            bt.name;
          }
        });
    }
  }
  static public function getModule(t:Type):Null<Module>{
    return if(isAnonymous(t)){
      null;
    }else{
      var base = getBaseType(t);
      {
        name : base.name,
        pack : base.pack
      };
    } 
  }
  static public function isAnonymous(t:Type):Bool{
    return getBaseType(t) == null;
  }
  static public function getBaseType(t:Type):Null<BaseType>{
    return switch (t) {
      case TEnum( t , params )      : t.get();
      case TInst( t , params )      : t.get();
      case TType( t , params )      : t.get();
      case TAbstract( t , params )  : t.get();
      default                       : null;
    }
  }
  static public function getParamImplementations(t:Type):Array<Type>{
    return switch (t) {
      case TEnum( t , params )      : params;
      case TInst( t , params )      : params;
      case TType( t , params )      : params;
      case TAbstract( t , params )  : params;
      default                       : [];
    }
  }
  static public function mod<T>():Y2<Monoid<T>,Type,T>{
    var idents = new haxe.ds.StringMap();

    return function rec(fn:Y2<Monoid<T>,Type,T>){
      return function(m:Monoid<T>,type:haxe.macro.Type):T{
        var ident = tink.macro.Types.getID(type);
        //trace('ident: "$ident"');
        if(ident == null){

        }else{
          if(idents.exists(ident)){
            return m.prior();
          }else{
            idents.set(ident,true);
          }
        }
        function f(m,t) return fn(rec)(m,t);
        function fld(next:Type,memo:Monoid<T>):Monoid<T> { return memo.put(f(memo,next)); };

        function pr(ct)  return ct.type;
        function pr2(tp) return tp.t; 

        return switch (type) {
          case TMono(t)         :
            __.option(t.get()).map(f.bind(m)).def(m.prior);
          case TEnum(t, params) :
            t.get().params.map(pr2).fold(fld,
              params.fold(fld,m)
            ).prior();
          case TInst(t, params):
            params.fold(fld,m).prior();
          case TType(t, params):
            params.fold(fld,m).prior();
          case TFun(args, ret):
            args.map(pr2)
                .fold(fld,fld(ret,m))
                .prior();
          case TAnonymous(a):
            a.get().fields
             .map(pr)
             .fold(fld,m)
             .prior();
          case TDynamic(t):
            __.option(t)
              .map(
                (t) -> fld(t,m).prior()
              ).def(m.prior);
          case TLazy(lz):
            fld(lz(),m).prior();
          case TAbstract(t, params):
            t.get().array.map(pr)
             .fold(fld,
                params.fold(fld,
                  fld(t.get().type,m)
                )
             ).prior();
            
        }
      }
    }
  }
}