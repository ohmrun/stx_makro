package stx.macro;

import haxe.Serializer;
using thx.Arrays;
using thx.ReadonlyArray;

#if macro
using tink.MacroApi;
using stx.macro.BaseTypes;
using stx.macro.Types;
#end
import haxe.macro.Type;

class Identifiers{
  static var types : Map<String,Int>;
  #if macro
  static public function safeFullName(bt:BaseType):String{
    return if(bt.hasPack()){
      '${bt.pack.join("_")}_${bt.name}';
    }else{
      bt.name;
    }
  }
  static function handleParams(params:ReadonlyArray<Type>,handler){
    var tail = (params:ReadonlyArray<Type>).map(handler).flatten();
        tail = tail.foldLeft(
          [],
          function(memo,next){
            return switch(memo){
              case [] : [next];
              default : memo.concat(["_And",next]);
            }
          }
        );
    return tail;
  }
  static function handleAnonType(type:Type){
    var identifier = type.identify();
    if(types == null){
      types = new Map();
    }
    var index = if(types.exists(identifier)){
      types.get(identifier);
    }else{
      var int = tink.macro.Types.register(function(){ return type; });
      types.set(identifier,int);
      int;
    }
    return ['Anon_$index'];
  }
  static public function safeName(type:Type){
    function handler(type:Type):ReadonlyArray<String>{
      //trace(type.path());
      return switch(type){
        case TInst(t,[])      :
          var head = safeFullName(Types.getBaseType(type));
          [head];
        case TInst(t,params) :
          var head = safeFullName(Types.getBaseType(type));
          var tail = handleParams(params,handler);
          return ([head]:ReadonlyArray<String>).append("_Of").concat(tail).append("_");
        case _.isNativeArray()  => true :
          var col_type  = type.getParams()[0];
          (['Array_Of']:ReadonlyArray<String>).concat(handler(type));
        case _.isNativeList()  => true :
          var col_type  = type.getParams()[0];
          (['List_Of']:ReadonlyArray<String>).concat(handler(type));
        case _.isString()       => true                     : ["String"];
        case _.isInt()          => true                     : ["Int"];
        case _.path()           => Some("StdTypes.Float")   : ["Float"];
        case _.path()           => Some("StdTypes.Bool")    : ["Bool"];
        case TType(t,[])       : [safeFullName(Types.getBaseType(type))];
        case TType(t,params)   :
            var head = safeFullName(Types.getBaseType(type));
            var tail = handleParams(params,handler);
            return ([head]:ReadonlyArray<String>).append("_Of").concat(tail).append("_");
        case TAnonymous(a) : handleAnonType(type);
        default : [];
      }
    }
    var out = handler(type);
    return out;
  }
  #end
}
