typedef BaseType = {
	var pack:Array<String>;
	var name:String;
	var module:String;
	var pos:Expr.Position;
	var isPrivate:Bool;
	var isExtern:Bool;
	var params:Array<TypeParameter>;
	var meta:MetaAccess;
	var doc:Null<String>;
	function exclude():Void;
}