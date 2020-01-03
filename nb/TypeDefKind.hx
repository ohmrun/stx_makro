enum TypeDefKind {
	TDEnum;
	TDStructure;
	TDClass( ?superClass : TypePath, ?interfaces : Array<TypePath>, ?isInterface : Bool, ?isFinal : Bool );
	TDAlias( t : ComplexType ); // ignore TypeDefinition.fields
	TDAbstract( tthis : Null<ComplexType>, ?from : Array<ComplexType>, ?to: Array<ComplexType> );
}
