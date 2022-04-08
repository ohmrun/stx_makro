typedef TypeDefinition = {
	var pack 			: Array<String>;
	var name 			: String;
	var ?doc 			: Null<String>;
	var pos 			: Position;
	var ?meta 		: Metadata;
	var ?params 	: Array<TypeParamDecl>;
	var ?isExtern : Bool;
	var kind 			: TypeDefKind;
	var fields 		: Array<Field>;
}