package types;

class GenericSimpleClass<T>{
  public function new(v){
    this.inner = v;
  }
  public var inner : T;
}
