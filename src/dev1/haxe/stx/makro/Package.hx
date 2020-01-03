package stx.makro;

#if test
  import stx.makro.test.*;
#end
class Package{
  #if test
    static var log : Log = __.log();
    static public function tests():Array<Dynamic>{
      log.debug("run tests");
      return [];
    }
    static public function macro_tests():Array<Dynamic>{
      log.debug("run macro tests");
      return [];
    }
  #end
}
typedef Types                 = stx.makro.body.Types;
typedef Exprs                 = stx.makro.body.Exprs;

typedef Type                  = stx.makro.pack.Type;
typedef Expr                  = stx.makro.pack.Expr;
