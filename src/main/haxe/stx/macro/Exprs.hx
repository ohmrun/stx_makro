package stx.macro;


using thx.Arrays;
import stx.Macro;
import haxe.ds.Option;


import haxe.macro.Expr;

#if macro
  import tink.macro.Exprs in Tk;
  import Type in T;
  import haxe.macro.Expr;
  import tink.macro.Types;
  import haxe.macro.Type;
  import haxe.macro.Context;
#end

private enum Arity{
  AZero;
  AOne;
  ATwo;
  AThree;
}
class Exprs{

  static public macro function quote(e:Expr){
    return doQuote(e);
  }
  #if macro
  static public function toEFieldPath(str:String):Expr{
    var array = str.split(".");
    var head  = Tk.at(EConst(CIdent(array.first())));
    var rest  = array.dropLeft(1);
    return rest.foldLeft(head,
      function(memo,next){
        return Tk.at(EField(memo,next));
      }
    );
  }
  static public function posQuote(pos:Position):Expr{
    return {
      pos : pos,
      expr : EObjectDecl(
        [{
          field : "file",
          expr  : macro ""
        },
        {
          field : "min",
          expr  : macro 0
        },
        {
          field : "max",
          expr  : macro 0
        }]
      )
    };
  }
  static public function doQuote(e:Expr):Expr{
    trace("_______________________________________");
    var p                   = new haxe.macro.Printer();
    trace(p.printExpr(e));
    var pos : Position      = e.pos;
    var pos_out : Dynamic   = {};
        pos_out.min = 0;
        pos_out.max = 0;
        pos_out.file = "";


    function enum_handler(v){
      var nm    = T.getEnumName((T.getEnum(v)));
      var ctor  = T.enumConstructor(v);
      var path  = nm.split(".");
          path.push(ctor);
      var id      = toEFieldPath(path.join("."));
      return id;
    }
    var ex_val      = T.getEnum(e.expr);
    var enm_nm      = T.getEnumName(ex_val);
    var enm_ctor    = T.enumConstructor(e.expr);
    var enm_path    = enm_nm.split(".");
        enm_path.push(enm_ctor);
    var enm_id      = toEFieldPath(enm_path.join("."));
    var outer : Expr= $i{enm_id};

    trace(p.printExpr(outer));


    var arity       = AOne;

    var edef_inner  : Expr = switch(e.expr){
      case EConst( c ):
        arity = AOne;
        var ctor  = T.enumConstructor(c);
        var id    = enum_handler(c);

        if(ctor == "CRegexp"){
          var v = T.enumParameters(c)[0];
          var b = T.enumParameters(c)[1];
          macro @:pos(pos) $outer($id($v{v},$v{b}));
        }else{
          var v = T.enumParameters(c)[0];
          macro $outer($id($v{v}));
        };
      case EArray( e1, e2) :
        arity = ATwo;
        var l = doQuote(e1);
        var r = doQuote(e2);
        var o = macro $outer($l,$r);
        trace(p.printExpr(o));
        o;

      case EBinop( op , e1 , e2  ):
        arity = AThree;
        var id      = enum_handler(op);
        var l : Expr      = doQuote(e1);
        var r : Expr      = doQuote(e1);
        macro {};
        //[id,l,r];
      case EField( e , field  ):
        var e : Expr = doQuote(e);
        var f : Expr = macro @:pos(pos) $v{field};
        macro {};
        //[e,f];
      case EParenthesis( e  ):
        macro @:pos(pos) {};//doQuote(e);
      case EObjectDecl( fields ):
        //EArrayDecl( values : Array<Expr> );
        function map_fields(obj:{ field : String, expr : Expr }):Expr{
          return macro @:pos(pos) { field : $i{obj.field}, expr : doQuote(obj.expr) };
        }
        var decl                = fields.map(map_fields);
        var exp : Expr          = { expr : EArrayDecl(decl), pos : pos };
        macro {};
      case EArrayDecl(values) :
        var exp = { expr : EArrayDecl(values.map(doQuote)), pos : pos };
        macro {};
      case ECall( e , params ):
        arity = ATwo;
        var args    = params.map(doQuote);
        var args_e  = { expr : EArrayDecl(args), pos : pos };
        //[doQuote(e),args_e];
        macro {};
      case ENew( t , params):
        var pack_expr : Expr =
        {
          expr : EArrayDecl(
            t.pack.map(
              function(x:String):Expr{
                return macro $i{x};
              }
            )
          ),
          pos : pos
        };

        var t_declr_params = {
          expr : EArrayDecl(
            t.params.map(
              function(x){
                return switch x {
                  case TPExpr(e) :
                    var quoted = doQuote(e);
                    return macro TPExpr($quoted)
                  case TPType(ct) :
                }
              }
            )
          );
        }
        var t_declr : Array<{ field : String, expr : Expr }>= [
          {
            field : "pack",
            expr  : pack_expr
          },
          {
            field : "name",
            expr  : macro $i{t.name}
          },
          {
            field : "params",
            expr  :
          }
        ];

        macro @:pos(pos) {};
      default:
        trace("unknown");
        macro @:pos(pos) {};
    }

//    trace(edef_inner);
    return {
      expr : EObjectDecl(
        [
          {
            field : "expr",
            expr  : macro $edef_inner,
          },
          {
            field : "pos",
            expr  : posQuote(pos)
          }
        ]
      ),
      pos : pos
    }
  }
  static public function getLastExprOfBlock(e:Expr):Null<Expr>{
    return switch e.expr {
      case EBlock(arr):
        arr[arr.length -1];
      default : e;
    }
  }
  static public function getEFieldPath(e:Expr){
    function rec(e:Expr,path:Array<String>){
      var next = path.copy();
      return switch (e.expr) {
        case EField(e,field)    :
          next.unshift(field);
          rec(e,next);
        case EConst(CIdent(s))  :
          next.unshift(s);
          next;
        default                 : [];
      }
    }
    return rec(e,[]).join(".");
  }
  /*static public macro function type(e:Expr){
    return switch (e.expr){
      case EConst(CIdent(str)) :
        var type = Context.getType(str);
        return {
          expr : ECheckType(
            Macro.unit(),
            Types.toComplex(type)
          ),
          pos : Context.currentPos()
        };
      default : Macro.unit();
    }
  }*/
  #end
}
class Positions{
  #if macro
  static public inline function equals(l:Position,r:Position):Bool{
    return true;//(l.file == r.file) && (l.min == r.min) && (l.max == r.max);
  }
  #end
}
class MetaDatas{

}
