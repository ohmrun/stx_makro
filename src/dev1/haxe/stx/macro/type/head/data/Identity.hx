package stx.macro.type.head.data;

import stx.macro.type.pack.Identity in IdentityA;
import stx.macro.core.pack.Module in ModuleA;

enum Identity {
	TAwkward;
  TLambda(args:Array<Field<IdentityA>>,ret:IdentityA);
	TAnon(arr:Array<Field<IdentityA>>);
	TParametrised(t:IdentityA, params:Array<IdentityA>);
	TIdentity(ident:ModuleA);
	TComposed(first:IdentityA, other:IdentityA);
}
