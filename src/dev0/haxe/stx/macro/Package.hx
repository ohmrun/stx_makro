package stx.macro;

import stx.macro.core.Package;

#if macro
  typedef Exprs           = stx.macro.expr.body.Exprs;
  typedef Functions       = stx.macro.expr.body.Functions;

  typedef Types           = stx.macro.type.body.Types;

  typedef Entype          = stx.macro.core.pack.Entype;
#end