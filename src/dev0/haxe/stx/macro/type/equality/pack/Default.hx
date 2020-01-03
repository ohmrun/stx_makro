package stx.macro.type.equality.pack;

import stx.macro.type.equality.head.Data.Eq;

class Default implements Eq{
    function eqParams(l:Array<Type>,r:Array<Type>):Bool{
        return l.zip(r).map(
            (t) -> eqType(t._0,t._1)
        ).all((b) -> true);
    }
    public function eqType(l:Null<Type>,r:Null<Type>):Bool{
        return switch ([l,r]) {
            case [TMono( t0 ),TMono( t1 )]                : eqType(t0.get(),t1.get());
            case [TEnum(lt,lparams),TEnum(rt,rparams)]    :
                eqBaseType(
                    stx.macro.type.body.Types.getBaseType(l),
                    stx.macro.type.body.Types.getBaseType(r)
                ) 
                && eqParams(lparams,rparams);  
            case [TInst( t0, p0 ),TInst( t1, p1 )]:
                eqClassType(t0.get(),t1.get()) && eqParams(p0,p1);
            case [TType( t0, p0 ), TType( t1, p1 )]:
                eqDefType(t0.get(),t1.get()) && eqParams(p0,p1);
            case [TFun(a0, r0 ),TFun(a1, r1)] : 
                a0.zip(a1).map(
                    (t) -> {
                        var l = t._0;
                        var r = t._1;
                        return l.name == r.name && l.opt == r.opt && eqType(l.t,r.t);
                    }
                ).all((b) -> b) && eqType(l,r);
            case [TAnonymous(a0),TAnonymous(a1)]    : 
                eqAnonType(a0.get(),a1.get());
            case [TDynamic(l),TDynamic(r)]          : 
                eqType(l,r);
            case [null,null]                        : 
                true;
            case [TLazy(f),_] :
                eqType(f(),r);
            case [_,TLazy(f)] :
                eqType(l,f());
            case [TAbstract(a0,p0),TAbstract(a1,p1)] :
                eqAbstractType(a0.get(),a1.get()) && eqParams(p0,p1);
            default : 
                false;
        }
    }
    public function eqAnonType(l:AnonType,r:AnonType):Bool{
        return false;
    }
    public function eqAnonStatus(l:AnonStatus,r:AnonStatus):Bool{
        return false;
    }
    public function eqTypeParameter(l:TypeParameter,r:TypeParameter):Bool{
        return false;
    }
    public function eqClassField(l:ClassField,r:ClassField):Bool{
        return false;
    }
    public function eqEnumField(l:EnumField,r:EnumField):Bool{
        return false;
    }
    public function eqClassKind(l:ClassKind,r:ClassKind):Bool{
        return false;
    }
    public function eqBaseType(l:BaseType,r:BaseType):Bool{
        return l.pack.zip(r.pack).map(
            (t) -> {
                return t._0 == t._1;
        }).all((b:Bool) -> b)
        &&
            l.name == r.name
        && 
            l.module == r.module
        && 
            l.pos == r.pos
        &&
            l.isPrivate == r.isPrivate
        &&
            l.isExtern == r.isExtern
        &&
            l.params.zip(r.params).map(
                (t) -> eqTypeParameter(t._0,t._1)
            ).all((b)-> b)
        &&
            eqMetaAccess(l.meta,r.meta)
        &&
            l.doc == r.doc;
    }
    public function eqClassType(l:ClassType,r:ClassType):Bool{
        return false;
        /*
        return eqBaseType(l,r)
        &&
            eqClassKind(l.kind,r.kind)
        &&
            l.isInterface && r.isInterface
        && 
            Options.toOption(l.superClass).zip(Options.toOption(r.superClass)).map(
                (t) -> 
                        eqClassType(t._0.t.get(),t._1.t.get())
                    &&
                        eqParams(t._0.params,t._1.params)
            ).getOrElse(false);*/
    }
    public function eqEnumType(l:EnumType,r:EnumType):Bool{
        return false;
    }
    public function eqDefType(l:DefType,r:DefType):Bool{
        return false;
    }
    public function eqAbstractType(l:AbstractType,r:AbstractType):Bool{
        return false;
    }
    public function eqMetaAccess(l:MetaAccess,r:MetaAccess):Bool{
        return false;
    }
    public function eqFieldKind(l:FieldKind,r:FieldKind):Bool{
        return false;
    }
    public function eqVarAccess(l:VarAccess,r:VarAccess):Bool{
        return false;
    }
    public function eqMethodKind(l:MethodKind,r:MethodKind):Bool{
        return false;
    }
    public function eqTConstant(l:TConstant,r:TConstant):Bool{
        return false;
    }
    public function eqTVar(l:TVar,r:TVar):Bool{
        return false;
    }
    public function eqModuleType(l:ModuleType,r:ModuleType):Bool{
        return false;
    }
    public function eqTFunc(l:TFunc,r:TFunc):Bool{
        return false;
    }
    public function eqFieldAccess(l:FieldAccess,r:FieldAccess):Bool{
        return false;
    }
    public function eqTypedExprDef(l:TypedExprDef,r:TypedExprDef):Bool{
        return false;
    }
    public function eqTypedExpr(l:TypedExpr,r:TypedExpr):Bool{
        return false;
    }    
}