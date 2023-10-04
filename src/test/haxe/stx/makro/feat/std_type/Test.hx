package stx.makro.feat.std_type;

import haxe.macro.Expr;
import haxe.macro.Context;

using stx.Nano;
using stx.Test;
using stx.Log;
using stx.makro.Type;


class Test extends TestCase{
  static public function main(){
    __.test().run(
      [
        new Test()
      ],[]
    );
  }
  public function test_types(){
    //find({ a : 1, b : true});
    //find("s");
    //find([]);
    //find(true);
    //find(1);
    //find(1.2);
    final t : Map<String,String> = ["a" => "b"];
    find(t);
    final n : Null<String> = null;
    //find(n);
    //find(Xml.XmlType.Element);
  }
  static macro function find(e:Expr){
    final t : HType = Context.typeof(e);
    trace(t.get_type_string());
    final v : HType = stx.makro.type.HStdType.ensure(t);
    trace((v:HType));
    trace((v:HType).get_type_string());
    return macro {};
  }
}