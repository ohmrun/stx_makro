typedef Field = {
	var name 		: String;
	var ?doc 		: Null<String>;
	var ?access : Array<Access>;
	var kind 		: FieldType;
	var pos 		: Position;
	var ?meta 	: Metadata;
}
