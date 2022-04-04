typedef ClassField = {
	var name:String;
	var type:Type;
	var isPublic:Bool;
	var isExtern:Bool;
	var isFinal:Bool;
	var isAbstract:Bool;
	var params:Array<TypeParameter>;
	var meta:MetaAccess;
	var kind:FieldKind;
	function expr():Null<TypedExpr>;
	var pos:Expr.Position;
	var doc:Null<String>;
	var overloads:Ref<Array<ClassField>>;
}
