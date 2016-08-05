package stx.macro;

using stx.Arrays;

import haxe.macro.Expr;
import haxe.macro.Context;

class Join {
  public function new(){
    
  }
  static public macro function apply(l:Expr,r:Expr){
    var lfields = [];
    var rfields = [];

    switch (l) {
      case { expr : EConst(CIdent(v)) , pos : p } : 
        switch (Context.getType(v)) {
          case TType(t,params) :
            switch (t.get().type) {
              case TAnonymous(t):
                lfields = t.get().fields;
              default :
            };
          default       :
        };
      default :
    }
    var ofields = lfields.append(rfields).map(
      function(x){
        trace(x);
      }
    );
    return { expr : EBlock([]), pos : Context.currentPos()};
  }
}