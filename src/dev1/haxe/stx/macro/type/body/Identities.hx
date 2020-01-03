package stx.macro.type.body;

import stx.macro.type.head.data.Identity in IdentityT;
import stx.fp.pack.Monoid;

import stx.macro.pack.Type in MType;

class Identities{
  static public function monoid():Monoid<Identity> {
		return {
			prior: function() return TAwkward,
			batch: function(l, r) return TComposed(l, r)
		}
	}
	static public function toUniquePath(v:Identity):String{
		var f = toUniquePath;
		return switch(v){
			case TAwkward: "Awkward";
			case TLambda(args,ret): 
				var id 		= toString(v);
				var name 	= stx.Macro.anons.get(id);
				'Func_$name';
			case TAnon(arr):
				var id 		= toString(v);
				var name 	= stx.Macro.anons.get(id);
				'Anon_$name';
			case TParametrised(id,rst):
				var ags = rst.map(f).join("_");
				'${f(id)}_$ags';
			case TIdentity(id):
				Modules.toName(id);
			case TComposed(first,other):
				'${f(first)}_${f(other)}';
				
		}
	}
	static var dlm : String = "__X__";
  static public function toString(v:Identity):String {
		return switch (v) {
			case TAwkward:
				"?";
      case TLambda(args, ret):
        var nxt = args.map(
          (kv) -> '${kv.key}:${toString(kv.val)}'
        ).join(",");
        var lst = toString(ret);
				'function(${nxt}):$lst';
			case TAnon(arr):
        var nxt = arr.map(
          (kv) -> '${kv.key}:${toString(kv.val)}'
        );
				'{${nxt.join(",")}}';
			case TParametrised(t, params):
				'${toString(t)}<${params.map(toString).join(',')}>';
			case TIdentity(ident):
				Modules.toString(ident);
			case TComposed(first, other):
				'${toString(first)}${toString(other)}';
		}
	}
	static public function toRuntimeString(v:Identity):Option<String>{
		return switch (v) {
			case TAwkward							: None;
			case TLambda(_,_)					: None;
			case TAnon(_)							: None;
			case TParametrised(t,_)		: Some('$t');
			case TIdentity(id)				: Some('$id');
			case TComposed(fst,_)			: toRuntimeString(fst);
		}
	}
  static public function getTypeIdentity(t:MType):Identity{
    function rec(ftc:Y2<Monoid<Identity>, MType, Identity>):Monoid<Identity>->MType->Identity {
			return function(m:Monoid<Identity>, type:MType):Identity {
				function f(t:Type):Identity
					return ftc(rec)(m, t);
				return switch (type) {
					case TInst(t, []):
						TIdentity(type.getModule());
					case TInst(t, arr):
						TParametrised(TIdentity(type.getModule()), arr.map(f));
					case TAbstract(t, []):
						var sigl = Context.signature(type);
						var abs = t.get();
						var sigr = Context.signature(abs.type);
						if (sigl == sigr) {
							TIdentity(type.getModule());
						} else {
							TComposed(TIdentity(type.getModule()), f(abs.type));
						}
					case TAbstract(t, arr):
						var sigl = Context.signature(type);
						var abs = t.get();
						var sigr = Context.signature(abs.type);
						if (sigl == sigr) {
							TParametrised(TIdentity(type.getModule()), arr.map(f));
						} else {
							TParametrised(TComposed(TIdentity(type.getModule()), f(abs.type)), arr.map(f));
						}
					case TEnum(t, []):
						TIdentity(type.getModule());
					case TEnum(t, arr):
						TParametrised(TIdentity(type.getModule()), arr.map(f));
					case TFun(args, ret):
            var arr : Array<Field<Identity>> = 
              args.ds()
							.map(
								function (arg):Field<Identity>{
									return Field.create(arg.name,f(arg.t));
								}
              );
						TLambda(
              arr, 
              f(ret)
            );
					case TAnonymous(t):
						var o = t.get();
						TAnon(o.fields.map((cf) -> tuple2(cf.name, f(cf.type)).toField() ));
					case TDynamic(null):
						f(type.follow());
					case TDynamic(v):
						f(v);
					case TLazy(fn):
						f(fn());
					case TMono(t):
						switch (t.get()) {
							case null:
                var next = type.follow();
                var lsig = Context.signature(type);
                var rsig = Context.signature(next);
                if(lsig == rsig){
                  m.prior();
                }else{
                  f(next);
                }
							case a: f(a);
						}
					case TType(t, []):
						TIdentity(type.getModule());
					case TType(t, arr):
						TParametrised(TIdentity(type.getModule()), arr.map(f));
				}
			}
		};
		var nxt = rec(rec);
		var out = nxt(Identities.monoid(), t);
    return out;
  }


	static public function getModuleIdentity(t:ModuleType):Identity{
		return TIdentity(BaseTypes.getModule(ModuleTypes.getBaseType(t)));
  }
}