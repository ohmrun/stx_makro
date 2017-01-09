package stx.macro;

class Unquote{
    static var p   = new haxe.macro.Printer();

    @:noUsing static public macro function unquote(e){
        return $e($a);
    }
}