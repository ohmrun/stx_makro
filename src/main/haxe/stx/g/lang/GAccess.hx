package stx.g.lang;

class GAccessCtr extends Clazz{
	static public function unit(){
		return new GAccessCtr();
	}
	private function lift(self:GAccessSum):GAccess{
		return GAccess.lift(self);
	}
	public function Public() return lift(GAPublic);
	public function Private() return lift(GAPrivate);
	public function Static() return lift(GAStatic);
	public function Override() return lift(GAOverride);
	public function Dynamic() return lift(GADynamic);
	public function Inline() return lift(GAInline);
	public function Macro() return lift(GAMacro);
	public function Final() return lift(GAFinal);
	public function Extern() return lift(GAExtern);
	public function Abstract() return lift(GAAbstract);
	public function Overload() return lift(GAOverload);
}
enum GAccessSum {
	GAPublic;
	GAPrivate;
	GAStatic;
	GAOverride;
	GADynamic;
	GAInline;
	GAMacro;
	GAFinal;
	GAExtern;
	GAAbstract;
	GAOverload;
}

abstract GAccess(GAccessSum) from GAccessSum to GAccessSum{
	static public var __(default,never) = new GAccessCtr();
  public function new(self) this = self;
  static public function lift(self:GAccessSum):GAccess return new GAccess(self);

  public function prj():GAccessSum return this;
  private var self(get,never):GAccess;
  private function get_self():GAccess return lift(this);

	public function toSource():GSource{
		return Printer.ZERO.printAccess(this);
	}
	#if macro 
	// public function toHaxe(){
	// 	return 
	// }
	#end
}