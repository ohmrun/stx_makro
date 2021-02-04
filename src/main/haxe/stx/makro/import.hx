package stx.makro;

using Lambda;


import haxe.ds.StringMap;
import haxe.io.Path;

import haxe.macro.Type;
import haxe.macro.Expr;

using tink.CoreApi;

import stx.makro.Core;


using stx.Pico;
using stx.Nano;

import stx.makro.alias.StdExprDef;
import stx.makro.alias.StdConstant;
import stx.makro.alias.StdType;

using stx.Fn;
using stx.Fp;
using stx.Ds;
using stx.Log;

#if macro
  import tink.macro.Member;
  
  import stx.makro.alias.*;

  import haxe.macro.Context; 
  import haxe.macro.Context.*;

  using haxe.macro.Tools;

  using tink.MacroApi;

  using stx.makro.Core;
  using stx.Makro;
  using stx.makro.Type;
  using stx.makro.Expr;
#end
