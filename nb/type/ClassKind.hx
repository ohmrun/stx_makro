package nb.type;

 enum ClassKind {
	KNormal;
	KTypeParameter(constraints:Array<Type>);
	KModuleFields(module:String);
	KExpr(expr:Expr);
	KGeneric;
	KGenericInstance(cl:Ref<ClassType>, params:Array<Type>);
	KMacroType;
	KAbstractImpl(a:Ref<AbstractType>);
	KGenericBuild;
}


/**
  switch (ck) {
    case KNormal:
    case KTypeParameter(constraints):
    case KExtension(cl, params):
    case KHExpr(expr):
    case KGeneric:
    case KGenericInstance(cl, params):
    case KMacroType:
    case KAbstractImpl(a):
    case KGenericBuild:
  }
**/