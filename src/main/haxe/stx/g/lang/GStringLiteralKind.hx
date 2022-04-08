package stx.g.lang;

@:using(stx.g.lang.GStringLiteralKind.GStringLiteralKindLift)
enum GStringLiteralKind {
	GDoubleQuotes;
	GSingleQuotes;
}
class GStringLiteralKindLift{
	#if macro
	static public function to_macro_at(self:GStringLiteralKind,pos:Position):StringLiteralKind{
		return switch(self){
			case GDoubleQuotes: DoubleQuotes;
			case GSingleQuotes: SingleQuotes;
		}
	}
	#end
}