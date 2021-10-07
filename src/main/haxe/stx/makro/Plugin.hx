package stx.makro;

using stx.Sys;
using StringTools;


import haxe.macro.Compiler;
import haxe.macro.Type;
import haxe.macro.ExprTools;
import haxe.macro.MacroStringTools;

import haxe.macro.Type as StdType;
//import stx.makro.type.Package;

//using stx.core.Lift;
//using stx.log.Lift;

//using stx.makro.Lift;

/**
  
**/
class Plugin{
  static public macro function use(){
    //#if (test||debug)
    trace('stx.makro.Plugin.use');
    //#end
    var args          = __.sys().args();
    var gen_location  = Way.fromString(__.sys().cwd().get()).concat(['src','gen','haxe']);
    
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
      var type    = Type._.makro(t);
      var base    = __.option(type.getBaseType()).force();
      var entries = base.meta.get().filter(
          (mde) -> mde.name.startsWith(":stx.")
      );
      for(entry in entries){
        var body      = entry.name.split(".");
            body[0]   = body[0].substr(1);
        //trace(body);
        var method    = body.pop();
        var params    = entry.params.map(parameter.bind(type)).prj();
        var path      = body.join(".");
        
        //trace(body.join("."));
        var clazz     = stx.StdType.resolveClass(path);
        //trace(clazz);
        if(clazz == null){
          #if (test || debug)
            #if (!stfu)
              Context.warning('${path.split(".").last().fudge()} not imported. Anything relying on "${path}#${method}($params)" will fail.',Context.currentPos());
            #end
          #end
        }
        for (clazz in __.option(clazz)){
          var value = stx.StdType.createInstance(clazz,[]);
          var method_ref  = Reflect.field(value,method);
          Reflect.callMethod(value,method_ref,params);
        }
      }
    }
  }
  static function parameter(type:Type,e:Expr):Dynamic{
    return switch(e.expr){
      case EConst(CIdent("__")) : type;
      default                   : ExprTools.getValue(e);
    }
  }
}