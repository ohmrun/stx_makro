package stx.macro.expr;

class Unops{
    static public function eq(l:Unop,r:Unop):Bool{
        return switch([l,r]){
            case [OpIncrement,OpIncrement]  : true;
            case [OpDecrement,OpDecrement]  : true;
            case [OpNot,OpNot]              : true;
            case [OpNeg,OpNeg]              : true;
            case [OpNegBits,OpNegBits]      : true;
            default                         : false;
        }
    }
}
