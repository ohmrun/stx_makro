While it's sort of germain to the [typed metadata discussion](https://github.com/HaxeFoundation/haxe-evolution/pull/111), it seems rude to jump on the thread with a radically different idea of is so here's my notes.

One of the problems for macro usage is that `Expr` and `Type` are bound, so if you want to handle types you also have to handle expressions.

They are bound in `MetadataEntry'

```haxe
typedef MetadataEntry = {
	var name:String;
	var ?params:Array<Expr>;
	var pos:Position;
}
```

Also `Expr` is found in `ComplexType` so that to handle type annotations you have to start with expressions. 

This can be fixed with a small AST for literals like clojure's [`EDN`](https://github.com/edn-format/edn), something like:

```haxe
enum EDN{
	PLabel(name:String);// :object_key
	PApply(name:String);// #do_something_with_this
	PGroup(list:LinkedList<PExpr<T>>);//(parens)
	PArray(array:Cluster<PExpr<T>>);//[array]
	PValue(value:Atom);//primitive
	PEmpty;//ZERO
	PAssoc(map:Cluster<Tup2<PExpr<T>,PExpr<T>>>);//Map
	PSet(arr:Cluster<PExpr<T>>);//Set
}
enum Atom{//Data, Eq, Show, Typeable)
  AnSym(s:Symbol);
  B(b:Bool);
  N(fl:Num);
  Str(str:String);
  Nul;
} 
```
Then `Type` and `Expr` are separate and you can build a little type description for literals by itself and use some simple mechanism to match these up

An array of a map of string and atom
```clj
(TPArray (TPAssoc PLabel TPAtom)))
([{:some_key 1 :keying true} {:other 2}])
```

Do a survey of what `Metadata` there is in the wild, vanishing little of it is more complicated than `Array<String>`

`EDN` is perfect because it is a superset of most data formats, it can handle XML and Json structures and anything else.

You could, for example constrain it to a Json like shape for runtime and allow a larger subset in macros.

It's probably a macro.