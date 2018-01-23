package stx.macro.expr;

class Metadatas{
    public static function eq(l:Metadata,r:Metadata):Bool{    
        return l.zip(r).all(
            function(tp){
                return MetadataEntries.eq(tp._0,tp._1);
            }
        );
    }
}
