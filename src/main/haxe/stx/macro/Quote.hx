package stx.macro;

import haxe.macro.Expr;
import haxe.ds.StringMap;

class EnumConstruction{
  public var val     : EnumValue;
  public var idx     : Int;
  public var enm     : Enum<Dynamic>;
  public var params  : Array<Dynamic>;
  public var cons    : String;
  public var name    : String;

  public function new(e:EnumValue){
    this.val     = e;
    this.enm     = T.getEnum(e);
    this.idx     = T.enumIndex(e);
    this.params  = T.enumParameters(e);

    if(this.params == null){
      this.params = [];
    }
    this.cons    = T.enumConstructor(e);
    this.name    = T.getEnumName(this.enm);
  }
  public function toString(){
    return this.name + ":" + this.cons;
  }
}
enum Params<A,B,C> {
  POne(a:A);
  PTwo(a:A,b:B);
  PThree(a:A,b:B,c:C);
}
typedef Contructor<A,B,C,T> = Params<A,B,C> -> T;  
typedef State = {
  var pos : Position;
}
class Quote{
  static public var map : StringMap<String>  = new StringMap();
  static var p                               = new haxe.macro.Printer();

  static public macro function quote(e:Expr):ExprOf<Expr>{
    
    var pos           = e.pos;
    var expr          = e.expr;

    var state : State = {
      pos : pos
    }
    var out : Expr    = quotes(state,e);
    var val           = p.printExpr(out);//hmm. Think it's about position.
    var ref           = Context.parse(val,pos);
    //var idx           = "_" + Std.string(Math.random() * 1000000000000000000);
    
    var x : Expr = {
          expr  : haxe.macro.Expr.ExprDef.EConst(CString(val)),
          pos   : pos
        }
    return macro ($ref:haxe.macro.Expr);
  }

  #if macro
    static function quotes(s:State,a:Any):Expr{
      var vt : ValueType = T.typeof(a);
      //trace('quotes: ');
      return switch (vt){
        case TObject        : objectate(s,a);
        case TEnum(e)       : enumerate(s,new EnumConstruction(a));
        case TInt           : 
          //trace('quote: int');
          macro $v{a};
        case TBool          : 
        //trace('quote: bool');
          macro $v{a};
        case TClass(String) : 
          //trace('quote: string');
          macro $v{a};
        
        case TClass(Array)  : 
          //trace('quote: array');
          //trace(a);
          var va : Array<Expr> = Lambda.array(Lambda.map(a,quotes.bind(a)));
          //trace('quote: array:done');
          //trace(p.printExprs(va,""));
          macro $a{va};
        case TNull          : 
          //trace('quote: null');
          macro null;
      case TUnknown       : objectate(s,s.pos);
        default           : 
          //trace('handling: ' + a + "of type:" + vt);
          throw new Error('Cannot handle: ' + a + ":" + vt,s.pos); macro {}
      }
    }
    static function enumerate(s:State,e:EnumConstruction):Expr{      
      //trace('enumerate: $e');
      var reslve    : Expr          = macro std.Type.resolveEnum($v{e.name});
      var cons      : Expr          = macro $v{e.cons};
      var params                    = {
        expr : EArrayDecl(e.params.map(quotes.bind(s))),
        pos : s.pos
      }
      var prms                      = [reslve,cons,params];
      /*
      trace("___________________________");
      trace(p.printExprs(prms,"\n"));
      trace("___________________________");
      */
      return macro std.Type.createEnum($a{prms});
    }
    static function objectate(s:State,a:Any):Expr{
      var fields = Reflect.fields(a);
      //trace('objectate: ${fields}');

      var vals   = fields.filter(
        function(x){
          return x != "null";
        }
      ).map(
        function(x):{ field : String, expr : Expr } {
          return { 
            field : x, 
            expr  : quotes(s,Reflect.field(a,x)) 
          }
        }
      );
      
      return { expr : EObjectDecl(vals), pos : s.pos };
    }
  #end
}