package stx.macro.type;

class TypeParameters{
    static public function eqR(l:TypeParameter,r:TypeParameter,eq: Type->Type->Bool){
        return l.name == r.name && eq(l.t,r.t);
    }
}