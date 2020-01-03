typedef Field = {
	var name : String;
	@:optional var doc : Null<String>;
	@:optional var access : Array<Access>;
	var kind : FieldType;
	var pos : Position;
	@:optional var meta : Metadata;
}