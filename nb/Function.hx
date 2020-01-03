typedef Function = {
	var args : Array<FunctionArg>;
	var ret : Null<ComplexType>;
	var expr : Null<Expr>;
	@:optional var params : Array<TypeParamDecl>;
}
