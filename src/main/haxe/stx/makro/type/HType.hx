package stx.makro.type;

@:using(stx.makro.type.HType.HTypeLift)
@:forward abstract HType(StdMacroType) from StdMacroType to StdMacroType{
  static public var _(default,never) = HTypeLift;
  public function new(self) this = self;

  @:noUsing static public function lift(self:StdMacroType):HType return new HType(self);

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
  public function getMoniker(){
    return _.getMoniker(this);
  }
  public function getBaseType(){
    return _.getBaseType(this);
  }
  #if macro
  @:noUsing static public function getHType(ident:Ident):Option<HType>{
    return try{
      Some(haxe.macro.Context.getType(ident.toIdentifier().toString()));
    }catch(e:Exception){
      __.log().debug(_ -> _.pure(e));
      None;
    }
  }
  #end
  public var fields(get,never):HClassFieldCluster;
  public function get_fields():HClassFieldCluster{
    return _.get_fields(this);
  }
  public function prj(){
    return this;
  }
  public var pack(get,never):Cluster<String>;
  private function get_pack():Cluster<String>{
    return __.option(getBaseType()).map(x -> Cluster.lift(x.pack)).defv([].imm());
  }
  public var name(get,never):Option<String>;
  private function get_name():Option<String>{
    return __.option(getBaseType()).map(x -> x.name);
  }
}
class HTypeLift{
  @:noUsing static private function lift(self:StdMacroType):HType return HType.lift(self);

  static public function arity(type:HType):Int{
    return switch (type) {
      case TInst(ref,params) :
        var constructor_ref = ref.get().constructor;
        if(constructor_ref == null){
          return -1;
        }
        var constructor = constructor_ref.get().type;
        return switch (constructor) {
          case TFun(args,_) : args.length;
          default : -1;
        }
      default :
        return -1;
    }
    return -1;
  }
  static public function makro(t:StdMacroType):HType{
    return new stx.makro.HType(t);
  }
  static public function getMeta(t:HType){
    return (getBaseType(t):stx.pico.Option<HBaseType>).map(
      (bt) -> bt.meta.get()
    ).def(()->[]);
  }
  static public function getTypeVars(type:HType):Cluster<{id:HSimpleTypeIdentifier,type:HType}>{
    var implementations    = get_params_applied(type);
    var params             = getBaseType(type).params;
    var fields             = get_fields(type);
    var out                = [];
    for (i in 0...params.length){
      var param = params[i];
      var p     = HSimpleTypeIdentifier.fromType(param.t);
      __.log().trace('$p');
      var impl  = implementations[i];
      out.push({
        id    : p,
        type  : impl
      });
    }
    return out.imm();
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
      case getPath(type) => Some("StdMacroTypes.Int"): true;
      default : false;
    }
  }
  static public function isInStdMacroType(type:Type):Bool{
    return switch(type){
      case TAbstract(a,_) : 
        a.get().module == "StdMacroTypes";
        default : false; 
    }
  }
  public static function isNativeList(type:Type):Bool{
    return switch type {
      case getPath(type) => Some("List"): true;
      default: false;
    }
  }
  static public function getPath(t:HType):Option<String>{
    var bt : HBaseType = getBaseType(t);
    return switch(bt == null){
      case true   : None;
      case false :
        Some(if(!HBaseType._.is_module_name_consistent(bt)){
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
  static public function getMoniker(t:Type):Option<Moniker>{
    return if(is_anonymous(t)){
      None;
    }else{
      var base = getBaseType(t);
      Some(stx.makro.type.core.Moniker.lift({
        name    : base.name,
        pack    : Way.lift(base.pack),
        module  : __.option(new haxe.io.Path(base.module))
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
  static public function get_params_applied(t:Type):Array<Type>{
    return switch (t) {
      case TEnum( t , params )      : params;
      case TInst( t , params )      : params;
      case TType( t , params )      : params;
      case TAbstract( t , params )  : params;
      default                       : [];
    }
  }
  // static public function is_direct_type(t:Type){
    
  // }
  static public function get_params(self:Type):Cluster<HTypeParameter>{
    return __.option(getBaseType(self)).map(
      x -> x.params
    ).defv([]);
  }
  #if macro
  static public function materialize(self:Type){
    final app     = haxe.macro.TypeTools.applyTypeParameters;
    final cparams = get_params(self);

    // return switch(self){
    //   case TEnum( t , params )      : 
    //   case TInst( t , params )      : params;
    //   case TType( t , params )      : params;
    //   case TAbstract( t , params )  : params;     
    // }
  }
  static public function canonical(self:HType){
    return tink.macro.Types.toString(self.toComplexType());
  }
  #end
  static public function get_all_fields(self:Type){
    return switch(self){
      case TInst(ref,params) : 
        final type    = ref.get();
        final rest    = (type:HClassType);
        final uppers  = rest.get_ancestors();
        final fields  = uppers.flat_map(x -> x.data.fields.get());
        // trace(fields.join("\n"));
        fields;
      default                 : [];
    }
  }
  static public function get_constructor(){
    
  }
  static public function is_type_parameter(self:HType){
    return switch(self){
      case TInst(t, params): switch(t.get().kind){
        case KTypeParameter(_) : true;
        default : false;
      }
      default : false;
    }
  }
  static public function is_mono(self:HType){
    return switch(self){
      case TMono(t)   : true;
      default         : false;
    }
  }
  static public function getClassType(self:HType):Option<ClassType>{
    return switch(self){
      case TInst(t,_) : Some(t.get());
      default         : None;
    }
  }
  static public function getTypedef(self:HType):Option<DefType>{
    return switch(self){
      case TType(t,_) : Some(t.get());
      default         : None;
    }
  }
  static public function eatMonos(type:HType):HType{
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
          final fields              = 
            (t.fields.map((cf:HClassField) -> cf.copy(null,rec(cf.type))):Array<ClassField>);
          final tI : AnonType       = 
            {
              status :  t.status,
              fields :  fields
            };
          final ref : Ref<AnonType> = 
            {
              get : () -> tI,
              toString : a.toString
            }
          haxe.macro.Type.TAnonymous(ref);
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
  static public function stripTypeParameterPack(self:HType):HType{
    return switch(self){
      case TInst(t, params): switch(t.get().kind){
        case KTypeParameter(_) : 
          TInst({ get : () -> (t.get():HClassType).copy([],null,""), toString : t.toString },params);
        default : throw 'Not a type parameter: $self';
      }
      default : throw 'Not a type parameter: $self';
    }
  }
}