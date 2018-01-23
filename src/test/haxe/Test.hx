using Lambda;


/*
import stx.macro.Exprs;
import ah.macro.JsonSchemaGenerator;
*/
import utest.Runner;
import utest.ui.Report;
class Test{
  static public function main(){
    trace("MAIN");
    #if !macro
      //new Test();
    #end
  }
  #if macro
    static macro function build(){
      var runner                  = new Runner();
      var tests : Array<Dynamic>  = [
          new stx.macro.TypeEqualityTest(),
          new stx.macro.ExprsTest(),
      ];
      utest.ui.Report.create(runner);
      tests.iter(
        function(x){
          runner.addCase(x);
        }
      );
      runner.run();
      return macro {};
    }
  #end
  function test(){
    var runner = new Runner();
    Report.create(runner);
    var tests : Array<Dynamic> = [
      //new stx.macro.AssignTest(),
      //new stx.macro.ClassTypesTest(),
      //new stx.macro.QuoteTest(),
      //new stx.macro.IdentifiersTest(),
      //new stx.macro.TypesTest(),
      //new ah.macro.DiveTest(),
      //new ah.macro.SelectTest(),

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
  public function new(){
    
  }
}
