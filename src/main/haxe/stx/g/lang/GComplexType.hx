package stx.g.lang;

class GComplexTypeCtr extends Clazz{
	static public function unit(){
		return new GComplexTypeCtr();
	}
	private function lift(self:GComplexTypeSum){
		return GComplexType.lift(self);
	}
	public function Path(p:GTypePath):GComplexType{
		return lift(GTPath(p));
	}
	public function Function(args:GComplexTypeCtr -> Cluster<GComplexType>, ret : GComplexTypeCtr -> GComplexType){
		return lift(GTFunction(args(unit()),ret(unit()))); 
	}
	public function Anonymous(fields:GFieldCtr->Cluster<GField>){
		return lift(GTAnonymous(fields(GField.__)));
	}
	public function Parent(t:GComplexTypeCtr->GComplexType){
		return lift(GTParent(t(this)));
	}
	public function Extend(p:GTypePathCtr->Cluster<GTypePath>,fields:GFieldCtr->Cluster<GField>){
		return lift(GTExtend(
			p(GTypePath.__),
			fields(GField.__)
		));
	}
	public function Optional(t:GComplexTypeCtr->GComplexType){
		return lift(GTOptional(t(this)));
	}
	public function Named(n:String,t:GComplexTypeCtr->GComplexType){
		return lift(GTNamed(n,t(this)));
	}
	public function Intersection(t:GComplexTypeCtr->Cluster<GComplexType>){
		return lift(GTIntersection(t(this)));
	} 
}
enum GComplexTypeSum{
	GTPath( p : GTypePath );
	GTFunction( args : Cluster<GComplexType>, ret : GComplexType );
	GTAnonymous( fields : Cluster<GField> );
	GTParent( t : GComplexType );
	GTExtend( p : Cluster<GTypePath>, fields : Cluster<GField> );
	GTOptional( t : GComplexType );
	GTNamed( n : String, t : GComplexType );
	GTIntersection(tl:Cluster<GComplexType>);
}
abstract GComplexType(GComplexTypeSum) from GComplexTypeSum to GComplexTypeSum{
	static public var __(default,never) = new GComplexTypeCtr();
  public function new(self) this = self;
  static public function lift(self:GComplexTypeSum):GComplexType return new GComplexType(self);

  public function prj():GComplexTypeSum return this;
  private var self(get,never):GComplexType;
  private function get_self():GComplexType return lift(this);
}
