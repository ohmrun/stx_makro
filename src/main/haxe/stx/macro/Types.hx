package stx.macro;


import stx.Equal;
#if macro
  using stx.macro.Types;

  import tink.macro.Exprs;
  import tink.macro.Types;
  import haxe.macro.Type;
  import haxe.macro.Expr;
  import haxe.macro.Context;
  import stx.macro.Exprs;
#end

class Types{

  static public macro function equals(l:Expr,r:Expr){
    var lt = Context.typeof(l);
    var rt = Context.typeof(r);
    equalsImpl(lt,rt);
    return macro {};
  }
  static public macro function blum(e:Expr){
    var t = Context.typeof(e);
    var a = path(t);
    
    return macro {};
  }
  #if macro
  static public function isAnonType(type:Type):Bool{
    return (switch (type){
      case TAnonymous(at) : true;
      default             : false;
    });
  }
  static public function identify(type:Type):String{
    var anon_type;
    return if(isAnonType(type)){
      Context.signature(anon_type);
    }else{
      tink.macro.Types.toString(tink.macro.Types.toComplex(type));
    }
  }
static public function nominal(type:Type):String{
  return if(isAnonType(type)){
        "";
      }else{
        "";
      }
  }

  static public function bfs(t:Type){
    //var handler = function()
  }
  static public function baseTypeNominallyEquals(l:BaseType,r:BaseType){
    var equality = true;
    if(l.pack.length != r.pack.length){
      equality = false;
    }else{
      for(i in 0...l.pack.length){
        var lpack = l.pack[0];
        var rpack = r.pack[0];
        if(lpack!=rpack){
          equality = false;
        }
      }
      if(equality){
        if(l.name!=r.name){
          equality = false;
        }
      }
      if(equality){
        equality = (l.module==r.module);
      }
    }
    return equality;
  }
  static public function paramsEquals(l:Array<Type>,r:Array<Type>):Bool {
    var equality = true;
    if(l.length != r.length){
      equality = false;
    }
    if(equality){
      for (idx in 0...l.length){
        if(!equalsImpl(l[idx],r[idx])){

        }
      }
    }
    return equality;
  }
  static public function equalsImpl(l:Type,r:Type):Bool{
    return switch ([l,r]) {
      case [TMono( t0 ),TMono( t1 )]                : equals(t0.get(),t1.get());
      case [TEnum(lt,lparams),TEnum(rt,rparams)]    :
        baseTypeNominallyEquals(getBaseType(l),getBaseType(r)) && paramsEquals(lparams,rparams);
      default : false;
      /*

      case TInst( t : Ref<ClassType>, params : Array<Type> );:
      case TType( t : Ref<DefType>, params : Array<Type> );:
      case TFun( args : Array<{ name : String, opt : Bool, t : Type }>, ret : Type );:
      case TAnonymous( a : Ref<AnonType> );:
      case TDynamic( t : Null<Type> );:
      case TLazy( f : Void -> Type );:
      case TAbstract( t : Ref<AbstractType>, params : Array<Type> );:*/
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
  static public function path(t:Type):Option<String>{
    var bt = getBaseType(t);
    return switch(bt == null){
      case true   : None;
      case false :
        Some(if(bt.isSecondaryType()){
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
  public static function getBaseType(t:Type):Null<BaseType>{
    return switch (t) {
      case TEnum( t , params )      : t.get();
      case TInst( t , params )      : t.get();
      case TType( t , params )      : t.get();
      case TAbstract( t , params )  : t.get();
      default                       : null;
    }
  }
  public static function getParams(t:Type):Array<Type>{
    return switch (t.reduce()) {
      case TEnum( t , params )      : params;
      case TInst( t , params )      : params;
      case TType( t , params )      : params;
      case TAbstract( t , params )  : params;
      default                       : [];
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
  public static function isNativeArray(type:Type):Bool{
    return switch type {
      case _.path() => Some("Array"): true;
      default: false;
    }
  }
  public static function isNativeList(type:Type):Bool{
    return switch type {
      case _.path() => Some("List"): true;
      default: false;
    }
  }
  public static function isTInst(type:Type):Bool{
    return switch type {
      case TInst(_,_): true;
      default : false;
    }
  }
  #end
}
