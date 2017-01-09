using Lambda;


import stx.macro.Exprs;
import ah.macro.JsonSchemaGenerator;
import utest.Runner;
import utest.ui.Report;

class Test{
  static public function main(){
    #if !macro
    new Test();
    #end
  }
  public function new(){
    var runner = new Runner();
    Report.create(runner);
    var tests : Array<Dynamic> = [
      new stx.macro.QuoteTest(),
      //new stx.macro.IdentifiersTest(),
      //new stx.macro.TypesTest(),
      //new ah.macro.DiveTest(),
      //new ah.macro.SelectTest(),
      //new stx.macro.ExprsTest(),
      //new stx.macro.TypesTest(),
      //new ah.macro.CloneTest(),
      //new ah.macro.AccessTest(),
      //new ah.macro.EntypeTest(),
      //new ExperimentTest(),
      //new ah.macro.PathTest(),
      //new ah.macro.SelectTest(),
      //new ah.macro.TupleTest()
      //new ah.macro.LenseTest(),
    ];
    tests.iter(
      function (arg){
        runner.addCase(arg);
      }
    );
    runner.run();
  }
}
