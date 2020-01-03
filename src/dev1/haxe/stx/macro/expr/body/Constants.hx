package stx.macro.expr.body;


class Constants{
  @:noUsing static public function CString(str:String):Constant{
    return StdConstant.CString(str);
  }
  @:noUsing static public function CIdent(str:String):Constant{
    return StdConstant.CIdent(str);
  }
} 