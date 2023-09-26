package stx.makro.test;

using stx.Nano;
using stx.Test;
using stx.Log;

class IdentityTest extends TestCase{
  static public function main(){
    __.test().run(
      [
        new IdentityTest()
      ],[]
    );
  }
  public function test<A,R>(){

    godown(({ a : null, b : null } : TypedefOfStructSecondParameterAppliedAndNewParam<R,A>));
  }
  static macro function godown(e:Expr){
    final t :HType = Context.typeof(e);
    trace(t.get_params());
    trace(t.get_params_applied());
    final p : HType = switch(t){
      case TType(t,_) : t.get().type;
      default         : null;
    }
    trace(p.get_params());
    trace(p.get_params_applied());

    final a : HType = switch(p){
      case TType(t,_) : t.get().type;
      default         : null;
    }
    for(f in a.fields){
      trace(f.name);
      trace(f.type.toHType().is_type_parameter());
    }

    return macro {}
  }
}