package stx.macro;

#if macro
  import stx.Makro;
#end

class GenTest extends Case{
  public function test(){
    _({});
    var a = new a.GenTestDeploy();
    trace("ok");
  }
  static macro function _(e){
    // trace("POPULATE");
    // var build = stx.Makro.build;
    // var pos = __.here();
    // var td : TypeDefinition = {
    //   fields : [
    //     {
    //       access : [APublic],
    //       name : "new",
    //       kind : FFun(
    //         {
    //           args  : [],
    //           ret   : null,
    //           expr  : HExprdef._.EBlock([]).expr(pos)
    //         }
    //       ),
    //       pos : __.here()
    //     }
    //   ],
    //   pack   : ["a"],
    //   name   : "GenTestDeploy",
    //   kind   : TDClass(),
    //   pos    : __.here()
    // };   
    // var printer = new Printer();
    // var show    = printer.printTypeDefinition(td);
    // build.publish(td);
    return macro {};
  }
}