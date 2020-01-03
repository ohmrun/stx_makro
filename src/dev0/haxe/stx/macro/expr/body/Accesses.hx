package stx.macro.expr.body;

class Accesses{
    public static function eq(l:Access,r:Access):Bool{
        return switch([l,r]){
            case [APublic,APublic]:     true;
            case [APrivate,APrivate]:   true;
            case [AStatic,AStatic]:     true;
            case [AOverride,AOverride]: true;
            case [ADynamic,ADynamic]:   true;
            case [AInline,AInline]:     true;
            case [AMacro,AMacro]:       true;
            default:                    false;
        }
    }
}
