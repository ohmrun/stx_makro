package stx.macro.type;

class ClassKinds{
    static public function eqR(l:ClassKind,r:ClassKind,eq:Type->Type->Bool){
        return switch(l,r){
            case [KNormal,KNormal]                          : true;
            case [KTypeParameter(c0),KTypeParameter(c1)]    : Params.eqR(c0,c1,eq);
            case [KExtension(t0, p0), KExtension(t1, p1)]   : ClassTypes.eqR(t0,t1,eq) && Params(p0,p1,eq);
            case [KExpr(expr:Expr);
        }
    }
        enum ClassKind {
	KNormal;

	/**
		A type parameter class with a set of constraints.
	**/
	KTypeParameter(constraints:Array<Type>);

	/**
		A structurally extended class.

		@deprecated
	**/
	KExtension(cl:Ref<ClassType>, params:Array<Type>);

	/**
		A special kind of class to encode expressions into type parameters.
	**/
	KExpr(expr:Expr);

	/**
		A `@:generic` base class.
	**/
	KGeneric;

	/**
		A concrete `@:generic` instance, referencing the original class and the
		applied type parameters.
	**/
	KGenericInstance(cl:Ref<ClassType>, params:Array<Type>);

	/**
		A special class for `haxe.macro.MacroType`.

		@deprecated
	**/
	KMacroType;

	/**
		An implementation class of an abstract, i.e. where all its run-time code
		is.
	**/
	KAbstractImpl(a:Ref<AbstractType>);

	/**
		A `@:genericBuild` class
	**/
	KGenericBuild;
}
}