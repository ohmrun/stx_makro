package stx.macro;


class TypeEqualityTest extends TestCase{
    
}
class TypeEquality{
    var flags : TypeEqualityFlags;

    public function new(flags){
        this.flags = flags;
    }
    public function apply(t:Type){

    }
}
class TypeEqualities{
    static public macro function apply(e:Expr):Expr{
        return macro true;
    }
#if macro
    static public function _apply(t:Type):Bool{
        return false;
    }
#end
}
typedef TypeEqualityFlags = {
    @:optional var metadata : Bool;
}