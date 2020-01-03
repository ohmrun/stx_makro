package stx.macro;

using stx.Eithers;
import tink.core.Either as TEither;
import stx.macro.JoinType;
using stx.Options;
using stx.Iterators;
import haxe.ds.StringMap;
using stx.Iterators;
using stx.Maps;
using stx.Compose;
import haxe.ds.ObjectMap;
import stx.types.Tuple2;
using stx.Tuples;
import tink.core.Pair;
using stx.Pairs;
import stx.Upshot;

import stx.Order;
import stx.Errors;
import tink.core.Outcome;
using stx.Arrays;

#if macro
import tink.macro.Types;
import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.Context;
#end

class Assign{
  
  static public macro function apply<T,U>(l:Expr,r:Expr,v:ExprOf<JoinType>){
    var jT  = 
    (switch (v.expr) {
      case EConst(CIdent(x)) :
        switch (x) {
          case "Inner": Inner;
          case "Outer": Outer;
          case "Right": Right;
          case "Left" : Left;
          default     : Context.error('Specify JoinType',Context.currentPos()); null;
        }
      default : Context.error('Specify JoinType',Context.currentPos());
    });
    var l0 = Context.typeof(l);
    var r0 = Context.typeof(r);

    var l1 : Upshot<Array<ClassField>> = Types.getFields(l0);
    var r1 : Upshot<Array<ClassField>> = Types.getFields(r0);

    var sorted :  Array<TEither<ClassField,ClassField>> = 
    l1.map(Arrays.map.bind(_,TEither.Left)).zip(r1.map(Arrays.map.bind(_,TEither.Right))).map(
      function(l0:Array<TEither<ClassField,ClassField>>,r0:Array<TEither<ClassField,ClassField>>){
        var srt = function(x:TEither<ClassField,ClassField>,y:TEither<ClassField,ClassField>){
          return ClassFieldOrder.sort(Eithers.get(x),Eithers.get(y));
        }
        return tuple2(ArrayOrder.sortWith(l0,srt),ArrayOrder.sortWith(r0,srt));
      }.tupled()
    ).map(
      getFieldList.bind(_,_,jT).tupled()
    ).toOption().release();

    sorted = sorted == null ? [] : sorted;

    var out0 = sorted.map(
      function(x){
        return x.map(
          untyped haxe.macro.TypeTools.toField,
          untyped haxe.macro.TypeTools.toField
        );
    });
    var path = Context.getLocalClass().get();
    var name = stx.macro.Types.name(l0) + "Join" + jT + stx.macro.Types.name(r0);
    
    var tdef : TypeDefinition = {
      pack : ["gen"].append(path.pack),
      name : name,
      pos  : Context.currentPos(),
      kind : TDStructure,
      fields : out0.map(Eithers.get),
      params : []
    }
    Context.defineType(tdef);

    var out1 = (switch (jT) {
      case Left :
        sorted.map(
          function(x:TEither<ClassField,ClassField>){
            var x0 = x.get();
            return switch (l.expr) {
              case EObjectDecl(flds) :
                flds.search(function(y) return x0.name == y.field).ensure();
              case EConst(CIdent(v)) :  
               var fld_type = Types.toComplex(x0.type);
                var o = { expr : , pos : Context.currentPos() };
                var fld = {
                  name : x0.name,
                  kind : FVar(fld_type,)
                }
                //trace(o);
                null;
              default : null;
            }
          }
        );
      default : null;    
    });
    
    trace(out1);
    return { 
      expr : EBlock([]), 
      pos : Context.currentPos()
    };
  }
  #if macro
    static public function getFieldList(l:Array<TEither<ClassField,ClassField>>,r:Array<TEither<ClassField,ClassField>>,type:JoinType){
      return switch (type) {
        case Left   : 
          l.filter(
            function(x){
              var xv = x.get();
              return !(r.exists(
                function(y){
                  return y.get().name == xv.name;
                }
              ));
            }
          );
        case Right  : 
          r.filter(
            function(x){
              var xv = x.get();
              return !(l.exists(
                function(y){
                  return y.get().name == xv.name;
                }
              ));
            }
          );
        case Inner  : 
          var both   = r.append(l);
          var counts = both.foldLeft(
            new StringMap(),
            function(memo,next){
              var next_v = next.get();
              return if(!memo.exists(next_v.name)){
                memo.set(next_v.name,1);
                memo;
              }else{
                memo.set(next_v.name,memo.get(next_v.name)+1);
                memo;
              }
            }
          );
          counts.keys().toArray().zip(counts.iterator().toArray())
            .filter(
              function(x){
                return x.b == 2;
              }
            ).map(
              function(x){
                return x.a;
              }
            ).map(
              function(x){
                return both.search(
                  function(y){
                    return y.get().name == x;
                  }
                ).val();
              }
            );
        case Outer  : 
          var both   = l.append(r);
          var counts = both.foldLeft(
            new StringMap(),
            function(memo,next){
              var next_v = next.get();
              return if(!memo.exists(next_v.name)){
                memo.set(next_v.name,1);
                memo;
              }else{
                memo.set(next_v.name,memo.get(next_v.name)+1);
                memo;
              }
            }
          );
          counts.keys().toArray().zip(counts.iterator().toArray())
            .filter(
              function(x){
                return x.b == 1;
              }
            ).map(
              function(x){
                return x.a;
              }
            ).map(
              function(x){
                return both.search(
                  function(y){
                    return y.get().name == x;
                  }
                ).val();
              }
            );
      }
    }
  #end
}
#if macro
  class ClassFieldOrder{
    static public function sort(l:ClassField,r:ClassField){
      return Order.getOrderFor(l.name)(l.name,r.name);
    }
  }
#end