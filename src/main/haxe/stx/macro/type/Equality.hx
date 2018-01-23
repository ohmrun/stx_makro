static public macro function equals(l:Expr,r:Expr){
  var lt = Context.typeof(l);
  var rt = Context.typeof(r);
  equalsImpl(lt,rt);
  return macro {};
}
static public function bfs(t:Type){
  //var handler = function()
}
static public function baseTypeNominallyEquals(l:BaseType,r:BaseType){
  var li : Ident = l;
  var ri : Ident = r;
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
