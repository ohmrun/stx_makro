package stx.makro.feat.type_variables;

using stx.Nano;
using stx.Test;
using stx.Log;

class Test extends TestCase{
  static public function main(){
    __.test().run(
      [
        new Test()
      ],[]
    );
  }
  public function test<T>(){
    final v : AppliedGenericType = {
      option : None
    };
    //of(v);

    of(new UnappliedGenericType());
  }
  macro static function of(e:Expr){
    final type = Context.typeof(e);
    trace(type);
    switch(type){
      case TInst(t,ps) : 
        trace(t.get().params);
        trace((type:HType).get_fields().map(x -> x.type));
      default : 
    }
    return macro {};
  }
}