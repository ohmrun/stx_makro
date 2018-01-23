package stx.macro;

import stx.macro.type.EnumTypes;
import stx.macro.BaseTypes;
import stx.macro.Types;
import stx.macro.type.TypeParameters;
import fig.core.Package;
import stx.types.*;

class TypeEqualityTest{
    public function new(){

    }
    public function test(){
        TypeEqualities.apply(new SimpleClassType());
    }
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
        var type = stx.macro.Exprs.getType(e);
            
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