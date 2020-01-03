package stx.macro.expr;

class Equality{
    var ops : Impl;
    public function new(){
        this.ops = new Impl();
    }
    public function apply(l:Expr,r:Expr):Bool{
        return switch([l.expr,r.expr]){
            case [EConst(c0),EConst(c1)]                                            : 
                Constants.eq(c0,c1);
            case [EArray(le0,le1),EArray(re0,re1)]                                  :
                Exprs.eq(le0,re0) 
                && Exprs.eq(le1,re1);
            case [EBinop(lo,le0,le1),EBinop(ro,re0,re1)]                            :
                Binops.eq(lo,ro) 
                && Exprs.eq(le0,re0) 
                && Exprs.eq(le1,re1);
            case [EField(le,lf),EField(re,rf)]                                      : 
                lf == rf 
                && Exprs.eq(le,re);
            case [EParenthesis(l),EParenthesis(r)]                                  : 
                Exprs.eq(l,r);
            case [EObjectDecl(larr),EObjectDecl(rarr)]                              : 
                larr.zip(rarr).all(
                    function(tp){
                        return tp._0.field == tp._1.field 
                        && apply(tp._0.expr,tp._1.expr);
                    }
                );
            case [EArrayDecl(l),EArrayDecl(r)]                                      : 
                l.zip(r).all(
                    function(tp){
                        return apply(tp._0,tp._1);
                    }
                );
            case [ECall(le,lp),ECall(re,rp)]                                        : 
                Exprs.eq(le,re) 
                && Params.eq(lp,rp);
            case [ENew(lt,lp),ENew(rt,rp)]                                          : 
                TypePaths.eq(lt,rt) 
                && Params.eq(lp,rp);
            case [EUnop(lop,lpf,le),EUnop(rop,rpf,re)]                              :
                Unops.eq(lop,rop)
                && lpf == rpf
                && Exprs.eq(le,re);
            case [EVars(l),EVars(r)]                                                :
                l.zip(r).all(
                    function(tp){
                        return Vars.eq(tp._0,tp._1);
                    }
                );
            case [EFunction(ln,lf),EFunction(rn,rf)]                                : 
                ln == rn 
                && Functions.eq(lf,rf);
            case [EBlock(l),EBlock(r)]                                              :
                l.zip(r).all(
                    function(tp){
                        return Exprs.eq(tp._0,tp._1);
                    }
                );
            case [EFor(lit,le),EFor(rit,re)]                                        :
                Exprs.eq(lit,rit) 
                && Exprs.eq(le,re);
            /*case [EIn(lit,le),EIn(rit,re)]                                          :
                Exprs.eq(lit,rit) 
                && Exprs.eq(le,re);*/
            case [EIf(lit,le,lelse),EIf(rit,re,relse)]                              :
                Exprs.eq(lit,rit) 
                && Exprs.eq(le,re) 
                && Exprs.eq(lelse,relse);
            case [EWhile(lit,le,ln),EWhile(rit,re,rn)]                              :
                Exprs.eq(lit,rit) 
                && Exprs.eq(le,re) 
                && ln == rn;
            case [ESwitch(le,lc,ldef),ESwitch(re,rc,rdef)]                          :
                Exprs.eq(le,re)
                && lc.zip(rc).all(
                    function(tp){
                        return Cases.eq(tp._0,tp._1);
                    }
                ) 
                && Exprs.eq(ldef,rdef);
            case [ETry(le,lc),ETry(re,rc)]                                          :
                Exprs.eq(le,re) 
                && lc.zip(rc).all(
                    function(tp){
                        return Catches.eq(tp._0,tp._1);
                    }
                );
            case [EReturn(l),EReturn(r)]                                            : 
                Exprs.eq(l,r);
            case [EBreak,EBreak]                                                    : 
                true;
            case [EContinue,EContinue]                                              : 
                true;
            case [EUntyped(l),EUntyped(r)]                                          : 
                Exprs.eq(l,r);
            case [EThrow(l),EThrow(r)]                                              : 
                Exprs.eq(l,r);
            case [ECast(le,lt),ECast(re,rt)]                                        : 
                Exprs.eq(le,re) 
                && ComplexTypes.eq(lt,rt);
            case [EDisplay(le,lc),EDisplay(re,rc)]                                  : 
                Exprs.eq(le,re) 
                && lc == rc;
            case [EDisplayNew(lt),EDisplayNew(rt)]                                  : 
                TypePaths.eq(lt,rt);
            case [ETernary(lecond, leif, leelse),ETernary(recond, reif, reelse)]    : 
                Exprs.eq(lecond,recond)
                && Exprs.eq(leif,reif)
                && Exprs.eq(leelse,reelse);
            case [ECheckType(le,lt),ECheckType(re,rt)]                              : 
                Exprs.eq(le,re) 
                && ComplexTypes.eq(lt,rt);
            case [EMeta(lm,le),EMeta(rm,re)]                                        : 
                MetadataEntries.eq(lm,rm) 
                && Exprs.eq(le,re);
            default                                                                 : 
                false;
        }
    }
}
class Impl{
    public function new(){

    }
    public function expr(l:Expr,r:Expr):Bool{
        return false;
    }
}