package stx.makro.pack;

import stx.assert.Package;
import stx.fp.pack.State;

using stx.core.Lift;
using stx.makro.Lift;

import stx.fn.pack.Y2;
import stx.fp.pack.Monoid;
import stx.makro.type.body.EnumTypes;

class EqualsMonoids{
  static public function unit():Monoid<EqualsValueT>{
    return {
      prior : () -> Map.make(Comparables.string()),
      batch : (l,r) -> l.union(r)
    };
  }
}
typedef EqualsDescriptor = {
  var name  : String;
  var expr  : HExpr;
}
typedef EqualsValueT = Map<String,EqualsDescriptor>;

class EqualsData{
  public var rest   : EqualsValueT;
  public var errors : Array<Errors>;

  public function new(rest){
    this.rest = rest;
  }
  static public function make(rest){
    return new EqualsData(rest);
  }
  public function prior(){
    return make(
      Map.make(Comparables.string())
    );
  }
 /* public function get(type:Type):HExpr{
    var id = Equals.get_id(type);
    return if(id == null){
      Equals.express(type);
    }else{
      var reference = this.rest.get(id).name;
      return 
    }
    return HExpr.UNIT;
  }*/
  public function batch(that:EqualsData){
    return make(
      this.rest.union(that.rest)
    );
  }
}
class Equals{
  static public function get_id(t:Type){
    return tink.macro.Types.getID(t);
  }
  /*
  static function replace_head_ref(head:HExpr,e:HExpr){
    return switch(head.expr){
      case ECall(e, [{ expr :}])://ARG1 ARG2
    }
  }
  static public function to_macro_atess(type:Type,data:EqualsData):Outcome<HExpr,stx.Error>{
    var id = get_id(type);
    return if(id == null){
      switch(type){
        case TAnonymous(a)  :

        default             : 
          Failure(Errors.implementation_not_found('$type','Equals'));
      }
    }
  }*/
  static public function apply(type:Type){
    var ftc = Y.run(
      EqualsMonoids.unit(),
      type
    );
    var out = ftc(
      function rec(ftc){
        return function(m,type){
          function f(monoid,type) return ftc(rec)(monoid,type);
          var id = get_id(type);

          if(id == null){

          }else{
            if(m.prior().has(id)){
              return m.prior();
            }
          }
          return switch(type){
            case TInst(t, params) :
              m = m.into(type,f);
              t.get().fields.get().map(
                (cf:ClassField) -> {
                  var prior       = m.prior();
                  var name        = cf.name;
                  //var expr        = prior.get(cf.type);    
                }
              );
              m.prior();
            default : m.prior();
          }
          return m.prior();
        }
      }
    );
    $type(out);
  }  
}
