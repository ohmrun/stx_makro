package stx.macro.expr;

/**
 *  var pos : Position;
 */
 import stx.macro.Exprs;
class MetadataEntries{
    public static function eq(l:MetadataEntry,r:MetadataEntry):Bool{    
        return l.name == r.name &&
            l.params.zip(r.params).all(
                function(tp){
                    return Exprs.eq(tp._0,tp._1);
                }
            );
    }
}