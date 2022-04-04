package;

enum Type {
	TMono(t:Ref<Null<Type>>);
	TEnum(t:Ref<EnumType>, params:Array<Type>);
	TInst(t:Ref<ClassType>, params:Array<Type>);
	TType(t:Ref<DefType>, params:Array<Type>);
	TFun(args:Array<{name:String, opt:Bool, t:Type}>, ret:Type);
	TAnonymous(a:Ref<AnonType>);
	TDynamic(t:Null<Type>);
	TLazy(f:Void->Type);
	TAbstract(t:Ref<AbstractType>, params:Array<Type>);
}
switch(self){
  case TMono(t)               :
	case TEnum(t,params)        :
	case TInst(t,params)        :
	case TType(t,params)        :
	case TFun(args, ret)        :
	case TAnonymous(a)          :
	case TDynamic(t)            :
	case TLazy(f)               :
	case TAbstract(t, params)   :
}