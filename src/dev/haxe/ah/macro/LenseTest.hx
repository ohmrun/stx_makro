package ah.macro;

import munit.Assert.*;

class LenseTest extends stx.Base{

    public function testLenseBuild(){
      var lense    = new Lense<ah.macro.LenseClass>();
      var impl     = new ah.macro.LenseClass();
          impl.a   = "3";
      var c        = lense.a.get(impl);
      equals("3",3);
    }

}
