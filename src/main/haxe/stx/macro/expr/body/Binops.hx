package stx.macro.expr;

class Binops{
    static public function eq(l:Binop,r:Binop):Bool{
        return switch([l,r]){
            case [OpAdd,OpAdd]:                 true;
            case [OpMult,OpMult]:               true;
            case [OpDiv,OpDiv]:                 true;
            case [OpSub,OpSub]:                 true;
            case [OpAssign,OpAssign]:           true;
            case [OpEq,OpEq]:                   true;
            case [OpNotEq,OpNotEq]:             true;
            case [OpGt,OpGt]:                   true;
            case [OpGte,OpGte]:                 true;
            case [OpLt,OpLt]:                   true;
            case [OpLte,OpLte]:                 true;
            case [OpAnd,OpAnd]:                 true;
            case [OpOr,OpOr]:                   true;
            case [OpXor,OpXor]:                 true;
            case [OpBoolAnd,OpBoolAnd]:         true;
            case [OpBoolOr,OpBoolOr]:           true;
            case [OpShl,OpShl]:                 true;
            case [OpShr,OpShr]:                 true;
            case [OpUShr,OpUShr]:               true;
            case [OpMod,OpMod]:                 true;
            case [OpAssignOp(l),OpAssignOp(r)]: eq(l,r);
            case [OpInterval,OpInterval]:       true;
            case [OpArrow,OpArrow]:             true;
            default: false;
        }
    }
}