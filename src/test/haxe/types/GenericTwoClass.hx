package types;

class GenericTwoClass<T,U>{
  public function new(v,u){
    this.inner = v;
    this.other = u;
  }
  public var inner : T;
  public var other : U;
}
