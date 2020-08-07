package stx.makro.type.body;

import stx.makro.type.head.data.Identity in IdentityT;
import stx.fp.pack.Monoid;

import stx.makro.pack.Type in MType;

class Identities{
  static public function monoid():Monoid<Identity> {
		return {
			unit: function() return TAwkward,
			plus: function(l, r) return TComposed(l, r)
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
    function rec(ftc:Y<Couple<Monoid<Identity>, MType>, Identity>):Couple<Monoid<Identity>,MType>->Identity {
			return function(tp:Couple<Monoid<Identity>,MType>):Identity {
				return tp.decouple(
					(m:Monoid<Identity>, type:MType) -> {
						function f(t:Type):Identity
							return ftc(rec)(__.couple(m, t));
						return switch (type) {
							case TInst(t, []):
								type.getModule().map(TIdentity).defv(TAwkward);
							case TInst(t, arr):
								type.getModule().map(
									TIdentity.fn().then(TParametrised.bind(_,arr.map(f))).prj()
								).defv(TAwkward);
							case TAbstract(t, []):
								var sigl = Context.signature(type);
								var abs = t.get();
								var sigr = Context.signature(abs.type);
								if (sigl == sigr) {
									type.getModule().map(TIdentity).defv(TAwkward);
								} else {
									type.getModule().map(
										TIdentity.fn().then(TComposed.bind(_,f(abs.type))).prj()
									).defv(TAwkward);
								}
							case TAbstract(t, arr):
								var sigl = Context.signature(type);
								var abs = t.get();
								var sigr = Context.signature(abs.type);
								if (sigl == sigr) {
									type.getModule().map(
										TIdentity.fn().then(TParametrised.bind(_,arr.map(f))).prj()
									).defv(TAwkward);
								} else {
									type.getModule().map(
										TIdentity.fn().then(
											TComposed.bind(_,f(abs.type))
										).then(
											TParametrised.bind(_,arr.map(f))
										).prj()
									).defv(TAwkward);
								}
							case TEnum(t, []):
								type.getModule().map(TIdentity).defv(TAwkward);
							case TEnum(t, arr):
								type.getModule().map(
									TIdentity.fn().then(TParametrised.bind(_,arr.map(f))).prj()
								).defv(TAwkward);
							case TFun(args, ret):
								var arr : Array<Field<Identity>> = 
									args
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
								TAnon(o.fields.map((cf) -> __.couple(cf.name, f(cf.type)).toField() ));
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
											m.unit();
										}else{
											f(next);
										}
									case a: f(a);
								}
							case TType(t, []):
								type.getModule().map(TIdentity).defv(TAwkward);
							case TType(t, arr):
								type.getModule().map(
									TIdentity.fn().then(TParametrised.bind(_,arr.map(f)))
								).defv(TAwkward);
						}
					}
				);
			}
		};
		var nxt = rec(rec);
		var out = nxt(__.couple(Identities.monoid(), t));
    return out;
  }


	static public function getModuleIdentity(t:ModuleType):Identity{
		return TIdentity(BaseTypes.getModule(ModuleTypes.getBaseType(t)));
  }
}