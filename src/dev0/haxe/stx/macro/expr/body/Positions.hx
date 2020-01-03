package stx.macro.expr.body;

class Positions{
  static public inline function equals(l:Position,r:Position):Bool{
    return true;//(l.file == r.file) && (l.min == r.min) && (l.max == r.max);
  }
}
