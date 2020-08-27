package types;

class GenericTwoClass<T:GenericSimpleClass<U>,U>{
  public function new(v){
    this.inner = v;
  }
  public var inner : T;
}
