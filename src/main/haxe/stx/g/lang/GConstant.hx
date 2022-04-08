package stx.g.lang;

class GConstantCtr extends Clazz{
  static public function unit(){
    return new GConstantCtr();
  }
  private function lift(self:GConstantSum):GConstant{
    return GConstant.lift(self);
  }
  public function Int(v:String,?s:String){
    return lift(GCInt(v,s));
  }
  public function Float(v:String,?s:String){
    return lift(GCFloat(v,s));
  }
  public function String(v:String,?s:GStringLiteralKind){
    return lift(GCString(v,s));
  }
  public function Ident(v:String){
    return lift(GCIdent(v));
  }
  public function Regexp(v:String,opt:String){
    return lift(GCRegexp(v,opt));
  }
}
enum GConstantSum{
  GCInt(v:String, ?s:String);
	GCFloat(f:String, ?s:String);
	GCString(s:String, ?kind:GStringLiteralKind);
	GCIdent(s:String);
	GCRegexp(r:String, opt:String);
}
@:using(stx.g.lang.GConstant.GConstantLift)
abstract GConstant(GConstantSum) from GConstantSum to GConstantSum{
  static public var __(default,never) = new GConstantCtr();
  public function new(self) this = self;
  static public function lift(self:GConstantSum):GConstant return new GConstant(self);

  public function prj():GConstantSum return this;
  private var self(get,never):GConstant;
  private function get_self():GConstant return lift(this);


  public function toSource():GSource{
		return Printer.ZERO.printConstant(this);
	}
}
class GConstantLift{
  #if macro
  static public function to_macro_at(self:GConstant,pos:Position){
    return switch(self){
      case GCInt(v, s)       : CInt(v, s);       
      case GCFloat(f, s)     : CFloat(f, s);     
      case GCString(s, kind) : CString(s, __.option(kind).map(x -> x.to_macro_at(pos)).defv(null)); 
      case GCIdent(s)        : CIdent(s);        
      case GCRegexp(r, opt)  : CRegexp(r, opt);  
    }
  }
  #end
}