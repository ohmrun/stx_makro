package stx.makro.feat.track_generics;

using stx.Nano;
using stx.Test;
using stx.Log;

import stx.makro.types.*;

import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.TypeTools;

using stx.Makro;
using stx.makro.Type;
using stx.makro.Expr;

class Test extends TestCase{
  static public function main(){
    __.test().run(
      [
        new stx.makro.feat.track_generics.Test()
      ],[]
    );
  }
  public function test_complex_generic_structure<U>(){
    final data : PartiallyAppliedComplexGenericClass<U,BasicClassSubclass,BasicClass>
      = new PartiallyAppliedComplexGenericClass();
    //$type(data);
    go_test_complex_generic_structure(data);
  }
  static public macro function go_test_complex_generic_structure(e:Expr){
    final type              = (e.toHExpr()).getType();
    final applications      = type.get_param_applications();
    final parameters        = type.get_type_parameters();
    // final applied        = type.apply_type_parameters();
    // trace(type);
    // trace('$applications');
    // trace('$parameters');
    // trace("_________________________________________________");
    // trace(type.get_all_fields().join("\n__________________________________________________\n"));
    // trace(applied);
    //TypeTools.applyTypeParameters   
    return macro {};
  }
  public function test_looking_through_metadata(){
    final data = new ClassWithMetadata();
    go_test_looking_through_metadata(data);
  }
  static public macro function go_test_looking_through_metadata(e:Expr){
    final type = e.toHExpr().getType();
    trace(type);
    trace(type.get_meta());
    return macro {};
  }
}