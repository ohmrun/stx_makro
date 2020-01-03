package stx.macro;

import stx.macro.alias.StdMetadataEntry;

class Lift{
  static public function toModule(str:String):Module{
    var arr = str.split(".");
    var name = arr.pop();
    return {
      name : name,
      pack : arr
    };
  }
  static public function here(stx:Wildcard){
    return haxe.macro.Context.currentPos();
  }
}
class LiftType{
  static public function stx(t:StdMacroType):Type{
    return new stx.macro.pack.Type(t);
  }
}
class LiftExpr{
  static public function stx(e:StdExpr):Expr{
    return new stx.macro.pack.Expr(e);
  }
}
class LiftEnumType{
  static public function stx(e:StdEnumType):EnumType{
    return e;
  }
}
class LiftMetadataEntry{
  static public function stx(md:StdMetadataEntry):MetadataEntry{
    return md;
  }
}