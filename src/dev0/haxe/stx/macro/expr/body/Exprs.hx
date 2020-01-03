package stx.macro.expr.body;

class Exprs{
  static public function getFieldPath(e:Expr):FieldPath{
    return e;
  }
  static public function getType(e:Expr):Type{
    var path = e.getFieldPath();
    return path.isDefined() ? path.toString().findTypeByName() : Context.typeof(e);
  }
  static public function getLastExprOfBlock(e:Expr):Null<Expr>{
    return switch e.expr {
      case EBlock(arr):
        arr[arr.length -1];
      default : e;
    }
  }
  static public function eq(l:Expr,r:Expr):Bool{
    return new Equality().apply(l,r);
  }
}