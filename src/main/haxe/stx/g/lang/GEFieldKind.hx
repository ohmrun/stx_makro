package stx.g.lang;


@:using(stx.g.lang.GEFieldKind.GEFieldKindLift)
enum GEFieldKind {
	GNormal;
	GSafe;
}
class GEFieldKindLift{
	#if macro
	static public function to_macro_at(self:GEFieldKind,pos:Position):EFieldKind{
		return switch(self){
			case GNormal 	: Normal;
			case GSafe 		: Safe;
		}
	}
	#end
}

