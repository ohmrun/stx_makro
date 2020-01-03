package stx.makro;

import stx.makro.alias.StdMetadataEntry;

typedef Errors =  stx.makro.core.body.Errors;

class Lift{
  static public function toModule(str:String):Module{
    var arr   = str.split(".");
    var name  = arr.pop();
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
  static public function makro(t:StdMacroType):Type{
    return new stx.makro.pack.Type(t);
  }
}
class LiftExpr{
  static public function makro(e:StdExpr):Expr{
    return new stx.makro.pack.Expr(e);
  }
}
class LiftEnumType{
  static public function makro(e:StdEnumType):EnumType{
    return e;
  }
}
class LiftMetadataEntry{
  static public function makro(md:StdMetadataEntry):MetadataEntry{
    return md;
  }
}