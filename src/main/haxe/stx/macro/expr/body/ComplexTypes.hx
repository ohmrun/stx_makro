package stx.macro.expr;

class ComplexTypes{
    public static function eq(l:ComplexType,r:ComplexType){
        return switch([l,r]){
            case [TPath(l),TPath(r)]                            : TypePaths.eq(l,r);
            case [TFunction(largs, lret),TFunction(rargs, rret)] :
                largs.zip(rargs).all(
                    function(tp){
                        return eq(tp._0,tp._1);
                    }
                ) && eq(lret,rret);
            case [TAnonymous(l),TAnonymous(r)] : 
                l.zip(r).all(
                    function(tp){
                        return Fields.eq(tp._0,tp._1);
                    }
                );
            case [TParent(l),TParent(r)] : eq(l,r);
            case [TExtend(larr,lf),TExtend(rarr,rf)]:
                larr.zip(rarr).all(
                    function(tp){
                        return TypePaths.eq(tp._0,tp._1);
                    }
                ) &&
                lf.zip(rf).all(
                    function(tp){
                        return Fields.eq(tp._0,tp._1);
                    }
                );
            case [TOptional(l),TOptional(r)] : eq(l,r);
            default : false;
        }
    }
}
