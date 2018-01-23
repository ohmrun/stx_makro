package stx.macro.expr;

import fig.core.Package;
class TypePaths{
    static public function eq(l:TypePath,r:TypePath):Bool{
        var lid : Ident = l;
        var rid : Ident = r;

		var eq_tparams = l.params.zip(r.params).all(
			function(tp){
				return TypePaths.eq(l,r);
			}
		);
		return lid == rid && eq_tparams && l.sub == r.sub;
	}
}