package stx.macro.type;

using thx.Maps;
using thx.Arrays;

class EnumTypes{
    static public function eqR(l:EnumType,r:EnumType,eq:Type->Type->Bool):Bool{
        var l_constructs    = l.constructs.tuples();
        var r_constructs    = r.constructs.tuples();
        var eq_constructs   = 
            l_constructs.equals(
                r_constructs,
                function(tp0,tp1){
                    return tp0._0 == tp1._0 && EnumFields.eqR(tp0._1,tp1._1,eq);
                }
            );
        var eq_names        = l.names.equals(r.names);
        return eq_names && eq_constructs;
    }
}