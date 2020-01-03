package stx.macro.type;

#if macro

#end

class NominativeEquality{
  static public macro function apply(e0:Expr,e1:Expr){
    var l = Context.typeof(e0);
    var r = Context.typeof(e1);
    var o = _apply(l,r);
    return macro $v{o};
  }
  #if macro
  static public function _apply(e0:Type,e1:Type){
    return switch [e0,e1] {
      case [TMono(t0),TMono(t1)] :
        var l   =  t0.get();
        var r   =  t1.get();
        _apply(e0,e1);
      case [TEnum(t0, _ ),TEnum(t1, _ )] :
        SMT.baseTypeNominallyEquals(SMT.getBaseType(e0),SMT.getBaseType(e1));
      case [TInst(t0, _ ),TInst(t1, _ )] :
        SMT.baseTypeNominallyEquals(SMT.getBaseType(e0),SMT.getBaseType(e1));
      case [TType(t0 , _ ),TType(t1 , _ )]:
        _apply(t0.get().type,t1.get().type);
      case [TFun( args0 , ret0 ),TFun( args1 , ret1 )]:
        functionNominallyEquals(args0,ret0,args1,ret1);
      case [TAnonymous( a0 ),TAnonymous( a1 )]:
        anonymousNominallyEquals(a0.get(),a1.get());
      case [TDynamic( t0 ),TDynamic( t1 )] :
        if(
          (t0 == null && t1 != null) ||
          (t0 != null && t1 == null)
        ){
          false;
        }else{
          _apply(t0,t1);
        }
      case [TLazy( f0 ),TLazy( f1 )]:
        _apply(f0(),f1());
      case [TAbstract( t0 , _ ),TAbstract( t1 , _ )] :
        SMT.baseTypeNominallyEquals(SMT.getBaseType(e0),SMT.getBaseType(e1));
      default : false;
    }
  }
  static public function anonymousNominallyEquals(l:AnonType,r:AnonType){
    var fl    = l.fields;
    var fr    = r.fields;
    var equal = true;

    if(fl.length!=fr.length){
      equal = false;
    }
    if(equal){
      for(idx in 0...fl.length){
        var f0l = fl[idx];
        var f0r = fr[idx];
        equal = classFieldNominallyEquals(f0l,f0r);
        if(!equal){
          break;
        }
      }
    }
    return equal;
  }
  static public function classFieldNominallyEquals(cf0:ClassField,cf1:ClassField){
    return cf0.name == cf0.name && _apply(cf0.type,cf1.type);
  }
  static public function functionNominallyEquals(args0:Array<TFunArg>,ret0:Type,args1:Array<TFunArg>,ret1:Type){
    var equal = true;
    if(args0.length != args1.length){
      equal = false;
    }
    if(equal){
      for(idx in 0...args0.length){
        //? optional
        var l = args0[idx];
        var r = args1[idx];
        if(l.name != r.name){
          equal = false;
          break;
        }
        equal = _apply(l.t,r.t);
        if(!equal){
          break;
        }
      }
    }
    if(equal){
      equal = _apply(ret0,ret1);
    }
    return equal;
  }
  #end
}
/*
TMono(t);
TEnum( t, params);
TInst( t , params );
TType( t , params );
TFun( args , ret );
TAnonymous( a );
TDynamic( t );
TLazy( f );
TAbstract( t , params );
*/
