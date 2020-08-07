package stx.makro;

import stx.makro.alias.StdMetadataEntry;

class Lift{
  static public function toModule(str:String):Option<Module>{
    var arr             = str.split(".");
    var name : String   = arr.pop();
    return Some(new Module({
      name : name,
      pack : arr,
      module : None
    }));
  }
  static public function here(stx:Wildcard){
    return haxe.macro.Context.currentPos();
  }
}
class LiftType{
  static public function makro(t:StdType):Type{
    return new stx.makro.Type(t);
  }
}
class LiftExpr{
  static public function makro(e:StdExpr):Expr{
    return new stx.makro.Expr(e);
  }
}
class LiftEnumType{
  static public function makro(e:StdEnumType):EnumType{
    return new EnumType(e);
  }
}
class LiftMetadataEntry{
  static public function makro(md:StdMetadataEntry):MetadataEntry{
    return md;
  }
}
class LiftBlock {
  static public function toBlock(arr:Array<StdExpr>):Expr{
    return {
      expr  : EBlock(arr.prj()),
      pos   : Context.currentPos()
    };
  }
}
class LiftClassType{
  static public function makro(ct:StdClassType):ClassType{
    return ct;
  }
}