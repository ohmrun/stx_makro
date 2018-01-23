
class Positions{
  #if macro
  static public inline function equals(l:Position,r:Position):Bool{
    return true;//(l.file == r.file) && (l.min == r.min) && (l.max == r.max);
  }
  #end
}
