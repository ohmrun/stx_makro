package stx.makro.types;

using stx.Pico;

class ComplexGenericClass<T,U,V>{
  var t : T;
  var u : Null<U>;
  var v : V;

  public function getW<W>(){
    return null;
  }
}