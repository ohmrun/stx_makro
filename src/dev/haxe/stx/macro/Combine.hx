package stx.macro;

using thx.Arrays;

using stx.Tuple;


#if macro
  using tink.macro.Bouncer;
  import haxe.macro.Compiler;
  import haxe.macro.Printer;
  import tink.macro.Types;
  import tink.macro.Exprs;
  import haxe.macro.Type;
  import haxe.macro.Expr;
  import haxe.macro.Context;
#end

class Combine{
    static public macro function apply(e0:Expr,e1:Expr,rest:Expr){
      var path0 = stx.macro.Exprs.path(e0).get().join('.');
      var path1 = stx.macro.Exprs.path(e1).get().join('.');
      var type0 = Context.getType(path0);
      var type1 = Context.getType(path1);

      var flds0 = (Types.getFields(type0)).toOption().get();
      var flds1 = (Types.getFields(type1)).toOption().get();


      var lefts = flds0.zip(flds0).map(
        function(l,r){
          return tuple2(l.name,r);
        }.tupled()
      ).toMap();

      var rights = flds1.map(
        function(x){
          return x.name;
        }
      ).zip(flds1).map(function(l,r){return new Pair(l,r);}.paired()).toMap();

      /*lefts.each(
        function(l:String,r:ClassField){
          if(rights.exists(
            function(l0,r0){
              return l0 == l;
            }.tupled()
          )){
            var r_var = rights.search(
              function(l1,r1){
                return l1 == l;
              }.tupled()
            ).ensure();
            var eq = Equal.getEqualFor(snd(r_var).type);
            var ltp = snd(r_var).type;
            var rtp = r.type;
            trace(ltp,rtp);
            trace(Enums.equals(ltp,rtp));
            var type_ok = eq(snd(r_var).type,r.type);
            trace(type_ok);
            trace(r);
          }
        }.tupled()
      );*/
      var out = rights;

      lefts.keys().each(
        function(key){
          if(!out.exists(key)){
            out.set(key,lefts.get(key));
          }
        }
      );
      //trace(lefts);
      var out0 = out.toArray().map(snd).map(untyped haxe.macro.TypeTools.toField);
      //trace(out0);
      var path = Context.getLocalClass().get();
      var name = stx.macro.Types.name(type0) + "And" + stx.macro.Types.name(type1);
      //trace(name);
      var tdef : TypeDefinition = {
        pack : ["gen"].append(path.pack),
        name : name,
        pos  : Context.currentPos(),
        kind : TDStructure,
        fields : out0,
        params : []
      }
      //trace(tdef.pack);
      //trace(new Printer().printTypeDefinition(tdef));
      Context.defineType(tdef);
      Compiler.include(tdef.pack.join("."));
      //trace(Context.getType(tdef.pack.join(".") + "."  + tdef.name));
      return
        {
          expr  : ECheckType(rest,TPath({name : tdef.name, pack : tdef.pack})) ,
          pos   : rest.pos
        };
    }
}
typedef CombineT1 = {
  var a : String;
}
typedef CombineT2 = {
  var b : String;
}
typedef CombineCompatible = {
  var a : String;
  var c : String;
}
