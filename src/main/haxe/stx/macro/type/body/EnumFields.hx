package stx.macro.type;

class EnumFields{
    static public function eqR(l:EnumField,r:EnumField,eq:Type->Type->Bool){
        return l.name == r.name
            && eq(l.type,r.type)
            && l.index == r.index
            && l.params.zip(r.params).all(
                function(tp){
                    return TypeParameters.eqR(tp._0,tp._1,eq);
                }
            );
    }
}