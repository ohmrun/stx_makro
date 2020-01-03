typedef FunctionArg = {
	var name : String;
	@:optional var opt : Bool;
	var type : Null<ComplexType>;
	@:optional var value : Null<Expr>;
	@:optional var meta : Metadata;
}