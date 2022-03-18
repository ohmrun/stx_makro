package stx.makro;

typedef MacroTypeFailureSum     = stx.fail.MacroTypeFailure.MacroTypeFailureSum;
typedef MacroTypeFailure        = stx.fail.MacroTypeFailure;
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

//@:using(stx.makro.Type.TypeLift)
@:forward abstract Type(StdType) from StdType to StdType{
  static public var _(default,never) = TypeLift;
  public function new(self) this = self;

  @:noUsing static public function lift(self:StdType):Type return new Type(self);

  #if macro
  public function followWithAbstracts(){
    return Context.followWithAbstracts(this);
  }
  public function follow(){
    return Context.follow(this);
  }
  #end
  public function getIdentity(){
    return Identity._.getTypeIdentity(this);
  }
  public function getModule(){
    return _.getModule(this);
  }
  public function getBaseType(){
    return _.getBaseType(this);
  }
}
class TypeLift{
  static public function makro(t:StdType):Type{
    return new stx.makro.Type(t);
  }
  static public function getMeta(t:Type){
    return (getBaseType(t):stx.pico.Option<BaseType>).map(
      (bt) -> bt.meta.get()
    ).def(()->[]);
  }
  
  static public function getTypeVars(type:Type):Array<{id:TypeParam,type:Type}>{
    var implementations    = getParamImplementations(type);
    var params             = getBaseType(type).params;
    var fields             = get_fields(type);
    var out                = [];
    for (i in 0...params.length){
      var param = params[i];
      var p  = TypeParam.fromType(param.t);
      trace(p);
      var impl = implementations[i];
      
      out.push({
        id  : p,
        type : impl
      });
    }
    return out;
  }
  static public function get_fields(type:Type):Array<ClassField>{
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
      Some(Module.lift({
        name    : base.name,
        pack    : Way.lift(base.pack),
        module  : None
      }));
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
}
class LiftClassType{
  static public function makro(ct:haxe.macro.Type.ClassType):stx.makro.type.ClassType{
    return ct;
  }
}