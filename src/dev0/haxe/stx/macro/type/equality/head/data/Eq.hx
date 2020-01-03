package stx.macro.type.equality.head.data;

interface Eq{
    function eqType(l:Null<Type>,r:Null<Type>):Bool;
    function eqAnonType(l:AnonType,r:AnonType):Bool;
    function eqAnonStatus(l:AnonStatus,r:AnonStatus):Bool;
    function eqTypeParameter(l:TypeParameter,r:TypeParameter):Bool;
    function eqClassField(l:ClassField,r:ClassField):Bool;
    function eqEnumField(l:EnumField,r:EnumField):Bool;
    function eqClassKind(l:ClassKind,r:ClassKind):Bool;
    function eqBaseType(l:BaseType,r:BaseType):Bool;
    function eqClassType(l:ClassType,r:ClassType):Bool;
    function eqEnumType(l:EnumType,r:EnumType):Bool;
    function eqDefType(l:DefType,r:DefType):Bool;
    function eqAbstractType(l:AbstractType,r:AbstractType):Bool;
    function eqMetaAccess(l:MetaAccess,r:MetaAccess):Bool;
    function eqFieldKind(l:FieldKind,r:FieldKind):Bool;
    function eqVarAccess(l:VarAccess,r:VarAccess):Bool;
    function eqMethodKind(l:MethodKind,r:MethodKind):Bool;
    function eqTConstant(l:TConstant,r:TConstant):Bool;
    function eqTVar(l:TVar,r:TVar):Bool;
    function eqModuleType(l:ModuleType,r:ModuleType):Bool;
    function eqTFunc(l:TFunc,r:TFunc):Bool;
    function eqFieldAccess(l:FieldAccess,r:FieldAccess):Bool;
    function eqTypedExprDef(l:TypedExprDef,r:TypedExprDef):Bool;
    function eqTypedExpr(l:TypedExpr,r:TypedExpr):Bool;
}