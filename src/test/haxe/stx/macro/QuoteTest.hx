package stx.macro;

import stx.macro.Unquote in UQ;
import stx.macro.Quote in Q;

class QuoteTest{
    public function new(){

    }
    public function testLiteral(){
        var a = { 
            expr : std.Type.createEnum(
                std.Type.resolveEnum("haxe.macro.ExprDef"), 
                "EBlock", 
                [
                    [
                        { 
                            expr : std.Type.createEnum(
                                std.Type.resolveEnum("haxe.macro.ExprDef"), 
                                "EConst", 
                                [
                                    std.Type.createEnum(
                                        std.Type.resolveEnum("haxe.macro.Constant"), 
                                        "CInt", 
                                        ["1"]
                                    )
                                ]
                            ), pos : {  }                  
                        }
                    ]
                ]
            ), 
            pos : {  } 
        }
    }
    /*
    public function test(){
        trace("___________");
        var out = Q.quote({
            trace("HERLO");
        });
        trace("___________");
        var c = "H)";
        $type(out);
    
        trace("___________");
            
    }*/
}