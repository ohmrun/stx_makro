package stx.makro;

using Lambda;


import haxe.ds.StringMap;
import haxe.io.Path;
import haxe.macro.Type;
import haxe.macro.Expr;

using tink.CoreApi;

import stx.makro.core.head.Data;


using stx.Pico;
using stx.Nano;

import stx.makro.alias.StdExprDef;
import stx.makro.alias.StdConstant;
import stx.makro.alias.StdType;

using stx.Fn;
using stx.Fp;
using stx.Ds;
using stx.Log;
using stx.ASys;
using stx.Arw;
using stx.Ext;

#if macro
  import tink.macro.Member;
  import stx.makro.type.head.Data;
  
  import stx.makro.alias.*;

  import haxe.macro.Context; 
  import haxe.macro.Context.*;

  using haxe.macro.Tools;

  using tink.MacroApi;
  using stx.makro.Lift;

  import stx.makro.core.Package;
  import stx.makro.Package;
  import stx.makro.type.Package;
  import stx.makro.expr.Package;
  import stx.makro.gen.Package;
#end
