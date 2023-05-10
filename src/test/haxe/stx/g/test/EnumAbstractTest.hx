package stx.g.test;

import stx.g.EnumAbstract;

class EnumAbstractTest extends TestCase{
  public function test(){
    final  _enum = types();
    trace(_enum.toSource());
  }
  public function test_odd_declaration_ok(){
    var a = AGENCY;
  }
  static public function types(){
    __.log().debug('enum abstract make');
    return EnumAbstract.make({
      type : __.g().ctype().string('std.String'),
      name : "EnumAbstractTestType",
      pack : ["stx","g","test"],
      constructors : [
        {
          name : "First",
          data : __.g().const().String("First")
        }
      ]
    });
  }
}
enum abstract LiteralEnumAbstractTestType(std.String) from std.String to std.String {
	public var AGENCY : stx.g.test.LiteralEnumAbstractTestType = "tooo";
}