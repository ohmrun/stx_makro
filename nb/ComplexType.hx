enum ComplexType {
	TPath( p : TypePath );
	TFunction( args : Array<ComplexType>, ret : ComplexType );
	TAnonymous( fields : Array<Field> );
	TParent( t : ComplexType );
	TExtend( p : Array<TypePath>, fields : Array<Field> );
	TOptional( t : ComplexType );
	TNamed( n : String, t : ComplexType );
	TIntersection(tl:Array<ComplexType>);
}