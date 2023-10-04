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
  public var module(get,never):Option<String>;
  private function get_module():Option<String>{
    return __.option(getBaseType()).map(x -> x.module);
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
      default              : [];
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
          final ref : HRef<AnonType> = 
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
  /**
   * Useful for naming local type parameters in TypeDefinition
   * @param self 
   * @return HType
   */
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
  /**
   * Struct here refers to a typedef of an anonymous structure.
   * @param self 
   */
  static public function is_struct(self:HType){
    return switch(self){
      case TType(t,_)  if(switch(t.get().type){ case TAnonymous(_) : true; default : false;})     : true;
      default : false;
    }  
  }
  static public function is_enum(self:HType){
    return switch(self){
      case TEnum(t,_)   : true;
      default           : false;
    }  
  }
  static public function get_convention(self:HType):HConstructorConvention{
    return switch(self){
      case TInst(_,_)                   : HCNew;
      case x if ((x:HType).is_struct()) : HCInline;
      case TType(t,_)                   : get_convention(t.get().type);
      case TAbstract(t,_)               : HCNew;
      default                           : HCInline;
    }
  }
  /**
   * Abstracts and Concrete Classes can be instantiated via `new`.
   * @param self 
   * @return Bool
   */
  //TODO this might also come as part of a constraint?
  static public function is_newable(self:HType):Bool{
    return switch(self){
      case TAbstract(t,_) : true;
      case TInst(t,_)     : true;
      default             : false;
    }
  }
  /**
   * Abstracts and Concrete Classes can be instantiated via `new`.
   * @param self 
   * @return Option<HType>
   */
  static public function get_nearest_newable(self:HType):Option<HType>{
    return switch(self){
      case TInst(t,_) if (t.get().isAbstract)             : 
        None;
      case TInst(t,_)                                       : 
        Some(self); 
      case TType(t,_) 
        if(
          switch(t.get().type){ 
            case TType(tI,_)      : true; 
            default               : false;
          }
        )       : 
        get_nearest_newable(t.get().type);
      case TType(t,_)       : Some(t.get().type);
      case TAbstract(t,_)   : Some(self);
      default               : None;
    }
  }
  /**
  *  Abstracts and TypeDefs don't contain enough information to build themselves.
  *  If the head type is one of these, you should more be looking for the face and body,
  *  the body being class hierarchy or type extension chain.
  * 
   * @param self 
   * @return Option
   */
  static public function get_face(self:HType):Option<HType>{
    return switch(self){
      case TInst(t,_)                 : Some(self); 
      case TType(t,_) 
        if(
          switch(t.get().type){ 
            case TType(tI,_)      : true; 
            case TAbstract(tI,_)  : true; 
            default               : false;
          }
        )       : 
        get_face(t.get().type);
      case TType(t,_)                 :  Some(t.get().type);
      case TAbstract(t,_)   
        if(
          switch(t.get().type){ 
            case TType(tI,_)      : true; 
            case TAbstract(tI,_)  : true; 
            default               : false;
          }
        )                             : get_face(t.get().type);
      case TAbstract(t,_)             : Some(self);
      default                         : None;
    }
  }
  static public function get_vars(self:HType){
    return self.fields.filter(
      x -> {
        final field         = (x:HClassField); 
        final is_function   = field.is_function();
        final is_writeable  = field.is_writeable();
        return !is_function && is_writeable;
      }
    );
  }
  // static public function toHTypeParamDecl(self:HType){
  //   return self.is_type_parameter().if_else(
  //     () -> {

  //     },
  //     () -> None
  //   )
  // }
    // /**
  #if macro
  static public function get_type_parameters(type:HType){
    final params  = [];
    function with_type_parameter(type){
      params.push(type);
    }
    final self    = type;
    __.log().trace(_ -> _.thunk(() -> self));
    __.log().trace(_ -> _.thunk(() -> self.get_params()));
    __.log().trace(_ -> _.thunk(() -> self.get_params_applied()));
    //__.log().trace(self.getIdentity().toString());
    //__.log().trace(haxe.macro.TypeTools.toString(self));
    //final has_implementation = 
    
    
    function add_type_parameters(t){
      haxe.macro.TypeTools.iter(
        t,
        t -> {
          final htype : HType     = t;
          final is_type_parameter = htype.is_type_parameter();
          __.log().trace('$htype ${is_type_parameter}');
          if(is_type_parameter){
            with_type_parameter(htype.stripTypeParameterPack());
          }
        }
      );
    }
    add_type_parameters(self);
    for (field in self.get_fields()){
      add_type_parameters(field.type);
    }
    for (type in self.get_params_applied()){
      add_type_parameters(type);
    }
    for (param in self.get_params()){
      add_type_parameters(param.t);
    }
    switch(self){
      case TEnum(t,_) : 
        for(f in t.get().constructs){
          switch(f.type){
            case TFun(args,ret) : 
              for(arg in args){
                add_type_parameters(arg.t);
              }
            default : 
          }
        }
      case TAbstract(t,_) : 
        __.log().trace(_ -> _.thunk(() -> t.get().type));
        add_type_parameters(t.get().type);
        for (field in (t.get().type:HType).get_fields()){
          add_type_parameters(field.type);
        }
      case TType(t,_) : 
        __.log().trace(_ -> _.thunk(() -> t.get().type));
        add_type_parameters(t.get().type);
        for (field in (t.get().type:HType).get_fields()){
          add_type_parameters(field.type);
        }
      default         : null;
    }
    return params;
  }
  static public function std_type(self:HType){
    return stx.makro.type.HStdType.ensure(self);
  }
  #end
  static public function get_type_string(self:HType):Option<String>{
    return switch(self){
      case TMono(t)               : __.option(t.toString());
      case TEnum(t,params)        : __.option(t.toString());
      case TInst(t,params)        : __.option(t.toString());
      case TType(t,params)        : __.option(t.toString());
      case TFun(args, ret)        : __.option();
      case TAnonymous(a)          : __.option(a.toString());
      case TDynamic(t)            : __.option(t).flat_map(x -> (x:HType).get_type_string());
      case TLazy(f)               : get_type_string(f());
      case TAbstract(t, params)   : __.option(t.toString());
      case null                   : __.option();
    }
  }
  //  * The fields of a typedef over an anonymous type are in the fields property of it's type property.
  //  * @param self 
  //  */
  // static public function get_scope(self:HType){
  //   return switch(self){
  //     case TInst(t,_)  : 
  //       t.get().fields.get().map(x -> HEdge.fromClassField(x)).imm();
  //     case TType(t,_) if (is_struct(self))  :
  //       (t.get().type:HType).get_fields().map(x -> HEdge.fromClassField(x));
  //     case TEnum(t,_) : 
  //       Iter.fromIterator(t.get().constructs.iterator()).toCluster().map(x -> HEdge.fromHEnumField(x));
  //     default : 
  //       self.get_fields().map(x -> HEdge.fromClassField(x));
  //   }
  // }

}
