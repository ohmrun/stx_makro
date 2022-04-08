package stx.g.lang;

@:using(stx.g.lang.GQuoteStatus.GQuoteStatusLift)
enum GQuoteStatus {
	GUnquoted;
	GQuoted;
}
class GQuoteStatusLift{
	#if macro
	static public function to_macro_at(self:GQuoteStatus,pos:Position){
		return switch(self){
			case GUnquoted 	: Unquoted;
			case GQuoted 		: Quoted;
		}
	}
	#end
}