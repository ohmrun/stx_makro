package stx.makro.type;

@:using(stx.makro.type.EnumType.EnumTypeLift)
@:forward abstract EnumType(haxe.macro.Type.EnumType) from haxe.macro.Type.EnumType{
  static public var _(default,never) = EnumTypeLift;
  public function new(self){
    this = self;
  }
}
class EnumTypeLift{  
  @:noUsing static public function getModule(e:EnumType):Module{
    return Module.lift({
      name    : e.name,
      pack    : Way.lift(e.pack),
      module  : new haxe.io.Path(e.module)
    });
  }
  @:noUsing static public function getConstructors(e:EnumType):Map<String,TFunParamArray>{
    return e.constructs.toArrayKV().fold(
      (next,memo:Map<String,TFunParamArray>) -> next.into(
        (k,v) -> switch v.type {
          case TFun(args,_) : 
            memo.set(k,(args:TFunParamArray));
            memo;
          default           : 
            memo.set(k,[]);
            memo;
        }
      ),
      __.nano().Map().String()
    );
  } 
  @:noUsing static public function constructorHandler<U>(e:EnumType,handler:Array<TFunParam>->U):StringMap<U>{
    var next = new StringMap();
    for(key => val in e.constructs){
      switch(val.type){
        case TFun(args,_)     : next.set(key,handler(args));
        default               : next.set(key,handler([]));
      }
    }
    return next;
  }   
  @:noUsing static public function constructorOf(e:EnumType,name:String){
    var out = None;
    for(key => val in e.constructs){
      if(key == name){
        out = Some(val.type);
      }
    }
    return out;
  }
}