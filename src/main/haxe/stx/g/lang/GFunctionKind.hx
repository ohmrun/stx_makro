package stx.g.lang;

enum GFunctionKind{
	GFAnonymous;
	GFNamed(name:String, ?inlined:Bool);
	GFArrow;
}