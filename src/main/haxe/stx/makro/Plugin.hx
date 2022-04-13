package stx.makro;

using stx.makro.Logging;
using stx.Sys;
using StringTools;

import haxe.macro.Compiler;
import haxe.macro.Type;
import haxe.macro.ExprTools;
import haxe.macro.MacroStringTools;

import haxe.macro.Type as StdType;

class Plugin{
  static public macro function use(){
    //#if (test||debug)
    trace('stx.makro.Plugin.use');
    //#end
    var args          = __.sys().args();
    var gen_location  = Way.fromPath(new haxe.io.Path(__.sys().cwd().get())).concat(['src','gen','haxe']);
    
    Compiler.addClassPath(gen_location.toOsString());
    Context.onAfterTyping(module);
    return macro {};
  }
  static function module(arr:Cluster<ModuleType>){
    //__.log().trace('onAfterTyping');
    // #if make
      method(arr.map_filter(
        (mt) -> switch(mt){
          case TClassDecl(c)     : Some(TInst(c,[]));
          case TEnumDecl(e)      : Some(TEnum(e,[]));
          case TTypeDecl(t)      : Some(TType(t,[]));
          case TAbstract(a)      : Some(TAbstract(a,[]));
          default                : None;
        }
      ));
    // #end
  }
  static function method(arr:Cluster<StdType>){
    for(t in arr){
      var type    = HType._.makro(t);
      var base    = __.option(type.getBaseType()).force();
      var entries = base.meta.get().filter(
          (mde) -> mde.name.startsWith(":stx.")//TODO -> too general
      );
      //__.log().trace(_ -> _.pure(entries));
      for(entry in entries){
        var body      = entry.name.split(".");
            body[0]   = body[0].substr(1);
        //trace(body);
        var method    = body.pop();
        var params    = entry.params.map(parameter.bind(type)).prj();
        var path      = body.join(".");
        
        //trace(body.join("."));
        var clazz     = stx.StdType.resolveClass(path);
        //__.log().trace(_ -> _.pure(clazz));
        if(clazz == null){
          #if (test || debug)
            #if (!stfu)
              Context.warning('${path.split(".").last().fudge()} not imported. Anything relying on "${path}#${method}($params)" will fail.',Context.currentPos());
            #end
          #end
        }
        for (clazz in __.option(clazz)){
          var value       = std.Type.createInstance(clazz,[]);
          //trace(value);
          var method_ref  = std.Reflect.field(value,method);
          //trace(method_ref);
          Reflect.callMethod(value,method_ref,params);
        }
      }
    }
  }
  static function parameter(type:HType,e:Expr):Dynamic{
    return switch(e.expr){
      case EConst(CIdent("__")) : type;
      default                   : ExprTools.getValue(e);
    }
  }
}