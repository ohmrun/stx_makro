package stx.macro;

class Stripper{
    static public function apply(e:HExpr){
        return macro {}
    }
    #if macro
    static public function _apply(t:Type){
        
    }
    #end
}