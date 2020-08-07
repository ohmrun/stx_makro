package stx.makro;

using StringTools;


import haxe.macro.Compiler;
import haxe.macro.Type;
import haxe.macro.ExprTools;
import haxe.macro.MacroStringTools;

import stx.makro.alias.StdType;
//import stx.makro.type.Package;

//using stx.core.Lift;
//using stx.log.Lift;

//using stx.makro.Lift;

/**
  
**/
class Plugin{

  static public macro function use(){
    //#if (test||debug)
      __.log().trace('stx.makro.Plugin.use');
    //#end
    var args          = Sys.args();
    var gen_location  = Sys.getCwd() + 'src/gen/haxe';
    
    Compiler.addClassPath(gen_location);
    Context.onAfterTyping(module);
    return macro {};
  }
  static function module(arr:Array<ModuleType>){
    //__.log().trace('onAfterTyping');
    #if make
      method(arr.map(
        (mt) -> switch(mt){
          case TClassDecl(c)     : TInst(c,[]);
          case TEnumDecl(e)      : TEnum(e,[]);
          case TTypeDecl(t)      : TType(t,[]);
          case TAbstract(a)      : TAbstract(a,[]);
        }
      ));
    #end
  }
  static function method(arr:Array<StdType>){
    for(t in arr){
      var type    = t.makro();
      var base    = __.option(type.getBaseType()).force();
      var entries = base.meta.get().filter(
          (mde) -> mde.name.startsWith(":stx.")
      );
      for(entry in entries){
        var body      = entry.name.split(".");
            body[0]   = body[0].substr(1);
        var method    = body.pop();
        var params    = entry.params.map(parameter.bind(type)).prj();
        var path      = body.join(".");
        

        var clazz     = stx.ext.alias.StdType.resolveClass(body.join("."));
        if(clazz == null){
          #if (test || debug)
            #if (!stfu)
              Context.warning('${path.split(".").last().fudge()} not imported. Anything relying on "${path}#${method}($params)" will fail.',Context.currentPos());
            #end
          #end
        }
        for (clazz in __.option(clazz)){
          var value = stx.ext.alias.StdType.createInstance(clazz,[]);
          Reflect.callMethod(value,Reflect.field(value,method),params);
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