package ah.macro;

import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.Expr;

using tink.macro.tools.MacroTools;
using tink.core.types.Outcome;

class Metadata {
  macro static public function use():Void {
    Context.onGenerate(checkTags);
  }
  var types:Array<Type>;
  var tags:Hash<{ pos: Position, normalize:Position->Array<Expr>->Array<Expr> }>;
  
  function new(types) {
    this.types = types;
    this.tags = new Hash();
    getTags();
    runCheck();
  }
  function checkMeta(meta:MetaAccess) {
    for (m in meta.get()) 
      if (tags.exists(m.name)) {
        meta.remove(m.name);
        meta.add(m.name, tags.get(m.name).normalize(m.pos, m.params), m.pos);
      }
  }
  function runCheck() {
    for (type in types) 
      switch (type.reduce()) {
        case TEnum(t, _):
          var t = t.get();
          checkMeta(t.meta);
          for (c in t.constructs)
            checkMeta(c.meta);
        case TInst(t, _):
          var t = t.get();
          checkMeta(t.meta);
          for (f in t.fields.get().concat(t.statics.get()))
            checkMeta(f.meta);
        case TAnonymous(a):
          for (f in a.get().fields)
            checkMeta(f.meta);          
        default:
      }
  }
  static function match(e:Expr, argList:Array<ClassField>) {
    var first = argList.shift();
    return 
      if (first == null) e.pos.error('argument mismatch');
      else switch (ECheckType(e, first.type.toComplex()).at(e.pos).typeof()) {
        case Success(_): { 
          expr: e,
          field: first.name
        }
        case Failure(r): 
          if (first.meta.has(':optional')) match(e, argList);
          else Failure(r).sure();
      }
  }
  function fieldNormalizer(fields:Array<ClassField>, single:ComplexType) {
    function mapParams(pos, params:Array<Expr>) {
      var expected = fields.copy(),
        found = [];
      for (p in params)
        found.push(match(p, expected));
      return EObjectDecl(found).at(pos);
    }
    return function (pos:Position, params:Array<Expr>) {
      var oLit =
        if (params.length == 1) 
          switch (params[0].expr) {
            case EObjectDecl(_): params[0];
            default: mapParams(pos, params);
          }
        else mapParams(pos, params);
      ECheckType(oLit, single).at(oLit.pos).typeof().sure();
      return [oLit];
    }
  }
  function getTags() {
    for (type in types) 
      switch (type) {
        case TType(t, _): 
          var t = t.get();
          if (t.meta.has(':tag')) {
            if (t.params.length > 0)
              t.pos.error('tag definitions may not contain type parameters');
              
            var tag = t.meta.get().getValues(':tag');
            var nameParam = tag[0][0];
            
            var name = 
              if (nameParam == null) t.name;
              else nameParam.getName().sure();
            if (tags.exists(name))
              t.pos.error('redefinition of tag ' + name + ' previously defined at ' + Std.string(tags.get(name).pos));
            else {
              var normalize = 
                switch (t.type) {
                  case TDynamic(_): function (_, params) return params;
                  case TAnonymous(a): 
                    fieldNormalizer(a.get().fields, type.toComplex(true));
                  default: 
                    t.pos.error('tag definition must be anonymous type or Dynamic');
                }
              tags.set(name, {
                pos: t.pos,
                normalize: normalize
              });
            }
          }
        default:
      }   
  }
  static function checkTags(types) {
    new TagChecker(types);
  }
  
}