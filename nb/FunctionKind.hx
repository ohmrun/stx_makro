

enum FunctionKind {
	FAnonymous;
	FNamed(name:String, ?inlined:Bool);
	FArrow;
}
