package stx.macro.expr;

class Constants{
    static public function eq(l:Constant,r:Constant):Bool{
        return switch([l,r]){
            case [CInt(l),CInt(r)]                  : l == r;
            case [CFloat(l),CFloat(r)]              : l == r;
            case [CString(l),CString(r)]            : l == r;
            case [CIdent(l),CIdent(r)]              : l == r;
            case [CRegexp(l,ol),CRegexp(r,or)]      : l == r && ol == or;
            default                                 : false;
        }
    }
}