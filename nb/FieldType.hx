enum FieldType {
	FVar( t : Null<ComplexType>, ?e : Null<Expr> );
	FFun( f : Function );
	FProp( get : String, set : String, ?t : Null<ComplexType>, ?e : Null<Expr> );
}
