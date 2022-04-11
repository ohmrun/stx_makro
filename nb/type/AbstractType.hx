package nb.type;

typedef AbstractType = BaseType & {
	var type:Type;
	var impl:Null<Ref<ClassType>>;
	var binops:Array<{op:Expr.Binop, field:ClassField}>;
	var unops:Array<{op:Expr.Unop, postFix:Bool, field:ClassField}>;
	var from:Array<{t:Type, field:Null<ClassField>}>;
	var to:Array<{t:Type, field:Null<ClassField>}>;
	var array:Array<ClassField>;
	var resolve:Null<ClassField>;
	var resolveWrite:Null<ClassField>;
}
