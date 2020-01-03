package stx.macro.expr.body;

class Fields{
    public static function eq(l:Field,r:Field){
        return l.name == r.name 
        &&
            l.access.zip(r.access).all(
                function(tp){
                    return Accesses.eq(tp._0,tp._1);
                }
            );
    }
}
