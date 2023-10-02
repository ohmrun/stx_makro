typedef ClassField = {
	var name:String;
	var type:Type;
	
	var params:Array<TypeParameter>;
	var doc:Null<String>;
	var meta:MetaAccess;

	
	var kind:FieldKind;
	var isPublic:Bool;
	var isExtern:Bool;
	var isFinal:Bool;
	var isAbstract:Bool;

	
	
	
	function expr():Null<TypedExpr>;
	
	
	var overloads:Ref<Array<ClassField>>;

	var pos:Expr.Position;
}
