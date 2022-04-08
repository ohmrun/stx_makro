package stx.g.lang;

class GObjectFieldCtr extends Clazz{
  static public function unit(){
    return new GObjectFieldCtr();
  }
  private function lift(self:GObjectFieldDef):GObjectField{
    return GObjectField.lift(self);
  }
  public function Make(field,?expr,?quotes){
    return GObjectField.make(
      field,
      expr(GExpr.__),
      quotes
    );
  }
}
typedef GObjectFieldDef = {
	var field:String;
	var expr:GExpr;
	var ?quotes:GQuoteStatus;
}
@:using(stx.g.lang.GObjectField.GObjectFieldLift)
@:forward abstract GObjectField(GObjectFieldDef) from GObjectFieldDef to GObjectFieldDef{
  static public var __(default,never) = new GObjectFieldCtr();
  static public var _(default,never) = GObjectFieldLift;
  public function new(self) this = self;
  static public function lift(self:GObjectFieldDef):GObjectField return new GObjectField(self);

  static public function make(field:String,expr:GExpr,?quotes:GQuoteStatus){
    return lift({field:field,expr:expr,quotes:quotes});
  }
  public function prj():GObjectFieldDef return this;
  private var self(get,never):GObjectField;
  private function get_self():GObjectField return lift(this);

  public function toSource():GSource{
		return Printer.ZERO.printObjectField(this);
	}
}
class GObjectFieldLift{
  #if macro
  static public function to_macro_at(self:GObjectField,pos:Position){
    return {
      field  : self.field,
      expr   : self.expr.to_macro_at(pos),
      quotes : __.option(self.quotes).map(x -> x.to_macro_at(pos)).defv(null)
    }
  }
  #end
}