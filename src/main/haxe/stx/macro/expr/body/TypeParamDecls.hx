package stx.macro.expr;

import stx.macro.expr.Metadatas;

class TypeParamDecls{
    public static function eq(l:TypeParamDecl,r:TypeParamDecl){    
        return l.name == r.name
            && l.constraints.zip(r.constraints).all(
                function(tp){
                    return ComplexTypes.eq(tp._0,tp._1);
                }
            ) && l.params.zip(r.params).all(
                function(tp){
                    return TypeParamDecls.eq(tp._0,tp._1);
                }
            ) && Metadatas.eq(l.meta,r.meta);
    }
}