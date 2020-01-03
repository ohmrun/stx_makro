package ah.macro;

using thx.Arrays;

import thx.Uuid.create in uuid;

using tink.core.Outcome;

import ah.Exprs;

#if macro
  import haxe.macro.Expr;
  import haxe.macro.Context;
  using tink.MacroApi;
#end


@doc("does not currently support Anonymous type declarations")
class Select{
  #if macro
  public static function apply(def:Expr,from:Expr){
    var path, names, block = [],tmp_name = '_${uuid()}',out_name = uuid();
    var printer = new haxe.macro.Printer();
    var tmp_var = macro var $tmp_name = $from;
    block.push(tmp_var);
    Exprs.yield(def,
      function yielder(e){
        (switch (e.expr) {
          case EConst(CIdent(s)) :
            if(Select.isUC(s)){
              var type    = Context.getType(s);
              var fields  = Types.getFields(type).sure();
              var names   = fields.map(function(x) return x.name);
              var decl    =
                EObjectDecl(names.map(
                  function(nm){
                    var l = macro $i{tmp_name};
                    var a = macro $l.$nm;
                        a.pos = Context.currentPos();
                    return { field : nm, expr : a };
                  }
                ));
              var decl0     = { expr : decl, pos : tink.macro.Positions.sanitize(null) };
              var ident     = Types.toComplex(type);
              var expr      = macro var $out_name : $ident = $decl0;
                  expr.pos  = Context.currentPos();
              block.push(expr) ;
              block.push(macro $i{out_name});
            }else{
              var tp = Context.getLocalVars().get(s);
              throw "unimplemented";
            }
          case EField(e,field) :
            throw "unimplemented";
            null;
          default :
          trace(e.expr);
            throw "unimplemented";
            null;
        });
        return e;
      }
    );
    var o = Exprs.toBlock(block);
    //trace(printer.printExpr(o));
    return o;
  }
  // copied from marc weber who copied from tinkerbell {{{3
  static inline function isUC(s:String) {
    return StringTools.fastCodeAt(s, 0) < 0x5B;
  }
  #end
}
