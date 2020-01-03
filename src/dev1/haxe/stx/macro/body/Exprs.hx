package stx.macro.body;

class Exprs{
  static public function mark(pos){
    return ExprDefs.MARK.expr(pos);
  }
  static public function unit(pos){
    return ExprDefs.UNIT.expr(pos);
  }
}