package stx.makro;

typedef TFunParam               = stx.makro.type.TFunParam;
typedef TFunParamArray          = stx.makro.type.TFunParamArray;
typedef Identity                = stx.makro.type.Identity;

typedef BaseType                = stx.makro.type.BaseType;

typedef TypeParam               = stx.makro.type.TypeParam;
typedef ModuleType              = stx.makro.type.ModuleType;
typedef EnumValueConstructor    = stx.makro.type.EnumValueConstructor;

typedef EnumType                = stx.makro.type.EnumType;

typedef ClassType               = stx.makro.type.ClassType;

typedef ClassAndParam           = stx.makro.type.ClassAndParam;

@:using(stx.makro.Type.TypeLift)
@:forward abstract Type(StdType) from StdType to StdType{
  static public var _(default,never) = TypeLift;
  public function new(self) this = self;

  @:noUsing static public function lift(self:StdType):Type return new Type(self);

  public function followWithAbstracts(){
    return Context.followWithAbstracts(this);
  }
  public function follow(){
    return Context.follow(this);
  }
  public function getIdentity(){
    return Identity._.getTypeIdentity(this);
  }
  
}
class TypeLift{
  static public function getMeta(t:Type){
    return (getBaseType(t):stx.pico.Option<BaseType>).map(
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
    var out                = [];
    for (i in 0...params.length){
      var param = params[i];
      var p  = TypeParam.fromType(param.t);
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
        Some(if(!BaseType._.isModuleNameConsistent(bt)){
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
  static public function getModule(t:Type):Option<Module>{
    return if(is_anonymous(t)){
      None;
    }else{
      var base = getBaseType(t);
      Some(({
        name : base.name,
        pack : base.pack,
        module : None
      }:Module));
    } 
  }
  static public function is_anonymous(t:Type):Bool{
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
  static public function mod<T>():Y<Couple<Monoid<T>,Type>,T>{
    var idents = new haxe.ds.StringMap();

    return function rec(fn:Y<Couple<Monoid<T>,Type>,T>){
      return function(tp:Couple<Monoid<T>,haxe.macro.Type>):T{
        return tp.decouple(
          (m:Monoid<T>,type) -> {
            var ident = tink.macro.Types.getID(type);
            //trace('ident: "$ident"');
            if(ident == null){

            }else{
              if(idents.exists(ident)){
                return m.unit();
              }else{
                idents.set(ident,true);
              }
            }
            function f(m,t) return fn(rec)(__.couple(m,t));
            function fld(next:Type,memo:Monoid<T>):Monoid<T> { return memo.put(f(memo,next)); };

            function pr(ct)  return ct.type;
            function pr2(tp) return tp.t; 

            return switch (type) {
              case TMono(t)         :
                __.option(t.get()).map(f.bind(m)).def(m.unit);
              case TEnum(t, params) :
                t.get().params.map(pr2).fold(fld,
                  params.fold(fld,m)
                ).unit();
              case TInst(t, params):
                params.fold(fld,m).unit();
              case TType(t, params):
                params.fold(fld,m).unit();
              case TFun(args, ret):
                args.map(pr2)
                    .fold(fld,fld(ret,m))
                    .unit();
              case TAnonymous(a):
                a.get().fields
                .map(pr)
                .fold(fld,m)
                .unit();
              case TDynamic(t):
                __.option(t)
                  .map(
                    (t) -> fld(t,m).unit()
                  ).def(m.unit);
              case TLazy(lz):
                fld(lz(),m).unit();
              case TAbstract(t, params):
                t.get().array.map(pr)
                .fold(fld,
                    params.fold(fld,
                      fld(t.get().type,m)
                    )
                ).unit();
                
            }
          }
        );
      }
    }
  }
}
class LiftClassType{
  static public function makro(ct:StdClassType):stx.makro.type.ClassType{
    return ct;
  }
}
class LiftType{
  static public function makro(t:StdType):Type{
    return new stx.makro.Type(t);
  }
}