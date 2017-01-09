package ah.macro;

using stx.Options;
import haxe.ds.Option;

import stx.Positions;
using stx.Log;

import haxe.macro.Printer;
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;

#if macro
  import tink.macro.Exprs;
  import tink.macro.Types;
#end

enum CloneAssignment{
  //HeadAssignment(c:CloneAssignment);
  ErrorAssignment(cause:String,?pos:haxe.macro.Position);
  PrimitiveImmutable(type:Type,name:Option<String>);
  //ComplexAssignment(type:Type,process:Expr,name:Option<String>);
  DeepAssignment(subassignments:Array<CloneAssignment>,constructor:CloneAssignment);
}
typedef CloneConstructor = Type;

class Clone{
  var p     : Printer;
  var log   : stx.Log;
  public function new(){
    this.p  = new Printer();
    this.log = new stx.Log().whiteByMethod('interpreter').positioned(
      function(x){
        return true;
      }
    );
  }
  function forTypeAssignment(type:Type):CloneAssignment{
    var o =  switch(type){
      case TAbstract(tref,params) :
          var tval = tref.get();
          log.debug(tval.name);
          switch(tval.name){
            case "Int"    : PrimitiveImmutable(type,None);
            case "Float"  : PrimitiveImmutable(type,None);
            case "Bool"   : PrimitiveImmutable(type,None);
            default       : ErrorAssignment('Abstract');
          }
        case TInst(tref,params) :
          var tval = tref.get();
          log(tval.pack);
          switch(tval.name){
          case "String"   : PrimitiveImmutable(type,None);
            case "Array"  :
              var generic = forTypeAssignment(params[0]);
              var ct      = Context.toComplexType(params[0]);
              DeepAssignment([generic],PrimitiveImmutable(type,None));
            case "List"   :
              var generic = forTypeAssignment(params[0]);
              var ct      = Context.toComplexType(params[0]);
              DeepAssignment([generic],PrimitiveImmutable(type,None));
            default       : ErrorAssignment('TInst');
          };
        case TAnonymous(tref) :
          var tval    = tref.get();
          var fields  = tval.fields.map(forFieldAssignment);
          DeepAssignment(fields,PrimitiveImmutable(type,None));
        default : ErrorAssignment('Unimplemented');
    }
    log(o);
    return o;
  }
  function forFieldAssignment(field:ClassField):CloneAssignment{
    var ass = forTypeAssignment(field.type);
        ass = switch(ass){
        case PrimitiveImmutable(type,name): PrimitiveImmutable(type,name.orElseConst(Some(field.name)));
          default : ass;
        }
    return ass;
  }
  function forType(type:Type):Expr{
    return switch type{
      case TAbstract(type,params) :
        var tval = type.get();
        log.debug(tval.name);
        switch(tval.name){
          case "Int"    : macro function(int:Int):Int return int;
          case "Float"  : macro function(float:Float):Float return float;
          case "Bool"   : macro function(bool:Bool):Bool return bool;
          default       : macro function(x:Dynamic):Dynamic {throw stx.Positions.here(); return x;};
        }
      case TInst(type,params) :
        var tval = type.get();
        log(tval.pack);
        switch(tval.name){
          case "String" : macro function(str:String):String return str;
          case "Array"  :
            var generic = forType(params[0]);
            var ct      = Context.toComplexType(params[0]);
            macro function(arr:std.Array<$ct>):std.Array<$ct>{
              var arrn = [];
              for(val in arr){
                arrn.push($generic(val));
              }
              return arrn;
            };
          case "List"   :
            var generic = forType(params[0]);
            var ct      = Context.toComplexType(params[0]);
            macro function(ls:std.List<$ct>):std.List<$ct>{
              var lsn = new std.List();
              for(val in ls){
                lsn.add($generic(val));
              }
              return lsn;
            };
          default       : macro function(x:Dynamic):Dynamic {throw "Error Inst"; return x;};
        }
      case TAnonymous(ref) :
        var tval = ref.get();
        var fields = tval.fields.map(forField);
        macro function(x:Dynamic):Dynamic {throw "Error TAnonymous"; return x;};
      default :
        log(type);
        macro function(x:Dynamic):Dynamic {throw "Error Type"; return x;};
    }
  }
  public function builder(e:Expr):ExprOf<CloneAssignment>{
    var type  = Context.typeof(e);
    var out : CloneAssignment = switch(e.expr){
      case EConst(CInt(i))    : PrimitiveImmutable(type,None);
      case EConst(CString(i)) : PrimitiveImmutable(type,None);
      case EConst(CFloat(i))  : PrimitiveImmutable(type,None);
      case EConst(CIdent(i))  : forTypeAssignment(type);
      default :
        ErrorAssignment('Unimplemented');
    }
    var o2 = interpreter(out);
    log.info(p.printExpr(o2));
    return o2;
  }
  static public macro function build(e:Expr):ExprOf<CloneAssignment>{
    var c = new Clone();
    return c.builder(e);
  }
  function interpreter(e:CloneAssignment){
    function pather(next,?path){
      return path == null ? next : '$path.$next';
    }
    function inner(e:CloneAssignment,?path){
      return switch(e){
        case ErrorAssignment(cause,pos)           : macro throw $i{cause};
        case PrimitiveImmutable(type,name)        : macro {};
        case DeepAssignment(subs,root)            :
          switch(root){
            case PrimitiveImmutable(TAnonymous(type),name):
              var name        = name.valOrC(genName());
              var things      = subs.map(
                function(sub){
                  var pth  = pather(path,name);
                  var sub0 = inner(sub,pth);
                  log(sub);
                  return macro $i{pth} :
                }
              );
              log.debug(p.printExprs(things,"\n"));
            default:
          }
          //var sub = subs.map(inner.bind(_,path));
          macro {};
      }
    }
    var name        = genName();
    var assignments = inner(e,[name]);
    var o           =  assignments;

    log.debug(p.printExpr(o));
    return macro {};
  }
  function genName(){
    return "_" + stx.Strings.uuid('xxxx');
  }
  function forField(field:ClassField){
    var fn = forType(field.type);
    return null;
  }
  public function applier(e:Expr){
    log.debug(p.printExpr(e));

    var fn = switch(e.expr){
      case EConst(CInt(i))    : macro function(int:Int):Int return int;
      case EConst(CString(i)) : macro function(str:String):String return str;
      case EConst(CFloat(i))  : macro function(float:Float):Float return float;
      case EConst(CIdent(i))  :
        var type = Context.typeof(e);
        return forType(type);
      //case EArrayDecl(v)      :
      default                 :
        log.debug(e.expr);
        macro function(x:Dynamic):Dynamic {throw "error 1";return x;}
    }
    return fn;
  }
  static public macro function apply(e:Expr){
    var clone = new Clone();
    return clone.applier(e);
  }
}
