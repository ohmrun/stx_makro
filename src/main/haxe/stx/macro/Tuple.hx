package ah.macro;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

using haxe.macro.Tools;

class Tuple {
    static var arityMap = new Map<Int,Bool>();

    static function build():ComplexType {
        return switch (Context.getLocalType()) {
            case TInst(_.get() => {name: "Tuple"}, types):
                if (types.length == 0) {
                    var args = Context.getCallArguments();
                    if (args != null)
                        types = [for (arg in args) Context.typeof(arg)];
                }
                if (types.length < 2)
                    Context.fatalError("Tuple must have at least 2 elements", Context.currentPos());
                buildTuple(types);
            default:
                throw false;
        }
    }

    static function buildTuple(types:Array<Type>):ComplexType {
        var arity = types.length;
        var name = 'Tuple$arity';

        var isTargetCS = Context.defined("cs");

        if (!arityMap.exists(arity)) {
            var pos = Context.currentPos();

            var fields:Array<Field> = [];
            var constructorArgs:Array<FunctionArg> = [];
            var constructorExprs:Array<Expr> = [];
            var typeParams:Array<TypeParamDecl> = [];

            for (i in 0...arity) {
                var fieldName = 'v$i';
                var typeName = 'T$i';
                var ct = TPath({pack: [], name: typeName});
                typeParams.push({name: typeName});
                constructorArgs.push({name: fieldName, type: ct});
                constructorExprs.push(macro this.$fieldName = $i{fieldName});
                var meta:Metadata = [];
                if (isTargetCS)
                    meta.push({name: ":readOnly", pos: pos});
                fields.push({
                    pos: pos,
                    name: fieldName,
                    access: [APublic],
                    kind: FProp("default", "null", ct),
                    meta: meta,
                });
            }

            fields.push({
                pos: pos,
                name: "new",
                access: [APublic, AInline],
                kind: FFun({
                    args: constructorArgs,
                    ret: macro : Void,
                    expr: macro $b{constructorExprs}
                })
            });

            var meta:Metadata = [];
            if (isTargetCS) {
                meta.push({name: ":nativeGen", pos: pos});
                meta.push({name: ":struct", pos: pos});
            }

            Context.defineType({
                pos: pos,
                pack: [],
                name: name,
                params: typeParams,
                meta: meta,
                kind: TDClass(),
                fields: fields
            });

            arityMap[arity] = true;
        }

        return TPath({pack: [], name: name, params: [for (t in types) TPType(t.toComplexType())]});
    }
}
