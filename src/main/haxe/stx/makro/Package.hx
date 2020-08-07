package stx.makro;

#if (test=="stx_makro")
  import stx.makro.test.*;
#end

class Package{
  #if (test=="stx_makro")
    static var log : Log = __.log();
    static public function tests():Array<haxe.unit.TestCase>{
      log.debug("run tests");
      return [];
    }
    static public function macro_tests():Array<haxe.unit.TestCase>{
      log.debug("run macro tests");
      return [];
    }
  #end
}
#if macro
  typedef Types                 = stx.makro.body.Types;
  typedef Exprs                 = stx.makro.body.Exprs;

  typedef Type                  = stx.makro.pack.Type;
  typedef Expr                  = stx.makro.pack.Expr;
#end