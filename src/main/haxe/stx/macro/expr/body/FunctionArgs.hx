package stx.macro.expr;

import stx.macro.Exprs;
import stx.macro.expr.Metadatas;

class FunctionArgs{
    static public function eq(l:FunctionArg,r:FunctionArg):Bool{
        return l.name == r.name
            && l.opt == r.opt
            && ComplexTypes.eq(l.type,r.type)
            && Exprs.eq(l.value,r.value)
            && Metadatas.eq(l.meta,r.meta);
    }
}
