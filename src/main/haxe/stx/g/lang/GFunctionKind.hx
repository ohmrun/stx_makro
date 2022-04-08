package stx.g.lang;

@:using(stx.g.lang.GFunctionKind.GFunctionKindLift)
enum GFunctionKind{
	GFAnonymous;
	GFNamed(name:String, ?inlined:Bool);
	GFArrow;
}
class GFunctionKindLift{
	#if macro
	static public function to_macro_at(self:GFunctionKind,pos:Position):FunctionKind{
		return switch(self){
			case GFAnonymous           :		FAnonymous;
			case GFNamed(name, inlined):		FNamed(name, inlined);
			case GFArrow               :		FArrow;
		}
	}
	#end
}