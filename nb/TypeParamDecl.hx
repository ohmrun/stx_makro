typedef TypeParamDecl = {
	var name : String;
	@:optional var constraints : Array<ComplexType>;
	@:optional var params : Array<TypeParamDecl>;
	@:optional var meta : Metadata;
}
