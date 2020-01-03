typedef TypeDefinition = {
	var pack : Array<String>;
	var name : String;
	@:optional var doc : Null<String>;
	var pos : Position;
	@:optional var meta : Metadata;
	@:optional var params : Array<TypeParamDecl>;
	@:optional var isExtern : Bool;
	var kind : TypeDefKind;
	var fields : Array<Field>;
}