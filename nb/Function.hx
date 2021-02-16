typedef Function = {
	var args : Array<FunctionArg>;
	var ret : Null<ComplexType>;
	var expr : Null<HExpr>;
	@:optional var params : Array<TypeParamDecl>;
}
