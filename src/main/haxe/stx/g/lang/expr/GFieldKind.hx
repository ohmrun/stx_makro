package stx.g.lang.expr;


@:using(stx.g.lang.expr.GEFieldKind.GEFieldKindLift)
enum GEFieldKind {
	GNormal;
	GSafe;
}
class GEFieldKindLift{
	static public function to_macro_at(self:GEFieldKind):EFieldKind{
		return switch(self){
			case GNormal 	: Normal;
			case GSafe 		: Safe;
		}
	}
}

