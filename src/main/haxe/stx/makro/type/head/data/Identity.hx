package stx.makro.type.head.data;

import stx.makro.type.pack.Identity in IdentityA;
import stx.makro.core.pack.Module in ModuleA;

enum Identity {
	TAwkward;
  TLambda(args:Array<Field<IdentityA>>,ret:IdentityA);
	TAnon(arr:Array<Field<IdentityA>>);
	TParametrised(t:IdentityA, params:Array<IdentityA>);
	TIdentity(ident:ModuleA);
	TComposed(first:IdentityA, other:IdentityA);
}
