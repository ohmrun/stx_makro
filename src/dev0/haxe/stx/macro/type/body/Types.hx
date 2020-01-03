package stx.macro.type.body;


class Types{
  static public function isTerminal(type:Type):Bool{
    return if(getParams(type).length > 0){
      false;
    }else{
      switch(type){
        case TType(t,_)       :
          isTerminal(Context.follow(t.get().type));
        case TAbstract(a,_)   :
          var l = identify(a.get().type);
          var r = identify(type);
          if(l == r){
            true;
          }else{
            isTerminal(Context.followWithAbstracts(a.get().type));
          }
        case _.identify().name => "String"  : true;
        case TInst(_)                       : false;
        case TAnonymous(_)                  : false;
        default                             : true;
      }
    }
  }
  static public function findTypeByName(name:String){
    return /*Context.getModule(name).find(
      function(type0){
        return identify(type0) == name;
      }
    );*/ Context.getType(name);
  }
  static public function isAnonType(type:Type):Bool{
    return (switch (type){
      case TAnonymous(at) : true;
      default             : false;
    });
  }
  static public function identify(type:Type):Ident{
    var anon_type;
    return if(isAnonType(type)){
      { pack : [], name : Context.signature(anon_type) };
    }else{
      Ident.fromDotString(tink.macro.Types.toString(tink.macro.Types.toComplex(type)));
    }
  }
  static public function nominal(type:Type):String{
    return if(isAnonType(type)){
          "";
        }else{
          "";
        }
  }
  static public function name(t:Null<Type>):Option<String>{
    return switch (t) {
      case TMono( t ) :           //Ref<Null<Type>>
        None;
      case TEnum( t , params ) :  //Ref<EnumType> Array<Type>
        Some(t.get().name);
      case TInst( t , params ) :  //Ref<ClassType> Array<Type>
        Some(t.get().name);
      case TType( t , params ) :  //Ref<DefType> Array<Type>
        Some(t.get().name);
      case TFun( args , ret ) :   //Array<{ name : String, opt : Bool, t : Type }> Type
        None;
      case TAnonymous( a ) : //Ref<AnonType>
        None;
      case TDynamic( t ) : //Null<Type>
        None;
      case TLazy( f  ) : //Void -> Type
        None;
      case TAbstract( t , params ) : // Ref<AbstractType> Array<Type>
        Some(t.get().name);
      case null : None;
    }
  }
  public static function isIterable(type:Type):Bool{
    return switch(type){
      case TAnonymous(a):
        var is_iterable = false;
        var deets = a.get();
        var has_one_field = deets.fields.length == 1;
        if(has_one_field){
          var field_called_iterator           = false;
          var field                           = deets.fields[0];
          field_called_iterator               = field.name == "iterator";
          if(field_called_iterator){
            var field_is_function = switch field.type{
              case TFun(_,_): true;
              default       : false;
            }
            if(field_is_function){
              var is_iterator = switch(field.type){
                case TFun([],TType(v,params)):
                  var possible_iter_type = v.get();
                  possible_iter_type.module == "StdTypes" && possible_iter_type.name == "Iterator";
                default : false;
              }
              is_iterable = is_iterator;
            }
          }
        }
        return is_iterable;
      default: false;
    }

  }
  static public function eqR(l:Type,r:Type,eq:Type->Type->Bool):Bool{
    return switch([l,r]){
      case [TMono(t0),TMono(t1)]        : eq(t0.get(),t1.get());
      case [TEnum(t0,p0),TEnum(t1,p1)]  : 
        EnumTypes.eqR(t0.get(),t1.get(),eq) && eqManyR(p0,p1,eq);
      case [TInst(t0,p0),TInst(t1,p1)]  : 
        ClassTypes.eqR(t0.get(),t1.get(),eq) && eqManyR(p0,p1,eq);
      default : false;
    }
  }
  static public function eqManyR(params0:Array<Type>,params1:Array<Type>,eq:Type->Type->Bool):Bool{
      return params0.zip(params1).all(
        function(tp){
          return eq(tp._0,tp._1);
        }
      );
    }
}
