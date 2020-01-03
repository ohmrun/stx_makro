package stx.macro.expr.body;

class TypeParams{
    static public function eq(l:TypeParam,r:TypeParam):Bool{
        return switch([l,r]){
            case [TPType(lt),TPType(rt)] : ComplexTypes.eq(lt,rt);
            case [TPExpr(lt),TPExpr(rt)] : Exprs.eq(lt,rt);
            default: false;
        }
    }
}