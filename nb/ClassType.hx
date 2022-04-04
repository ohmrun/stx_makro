typedef ClassType = BaseType & {
	var kind:ClassKind;
	var isInterface:Bool;
	var isFinal:Bool;
	var isAbstract:Bool;
	var superClass:Null<{t:Ref<ClassType>, params:Array<Type>}>;
	var interfaces:Array<{t:Ref<ClassType>, params:Array<Type>}>;
	var fields:Ref<Array<ClassField>>;
	var statics:Ref<Array<ClassField>>;
	var constructor:Null<Ref<ClassField>>;
	var init:Null<TypedExpr>;
	var overrides:Array<Ref<ClassField>>;
}