package stx.macro.expr.body;

class Functions{
    public static function unit():Function{
        return {
            args : [],
            ret : null,
            expr : null
        }
    }
    public static function eq(l:Function,r:Function){    
        return l.args.zip(r.args).all(
            function(tp){
                return FunctionArgs.eq(tp._0,tp._1);
            }
        ) && ComplexTypes.eq(l.ret,r.ret)
         && Exprs.eq(l.expr,r.expr)
         && l.params.zip(r.params).all(
             function(tp){
                 return TypeParamDecls.eq(tp._0,tp._1);
             }
         );
    }
}
