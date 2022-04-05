package stx.makro;

using Lambda;


import haxe.ds.StringMap;
import haxe.io.Path;

import haxe.macro.Type;
import haxe.macro.Expr;

using tink.CoreApi;

using stx.Pico;
using stx.Nano;

import stx.makro.alias.StdExprDef;
import stx.makro.alias.StdConstant;
import stx.makro.alias.StdType;

using stx.Fn;
using stx.Fp;
using stx.Ds;
using stx.Log;

import stx.makro.alias.*;

using stx.makro.Core;
import stx.Makro;
import stx.makro.Type;

#if macro
  import tink.macro.Member;
  
  using stx.makro.Expr;
  using stx.makro.Def;
  
  import stx.makro.alias.*;

  import haxe.macro.Context; 
  import haxe.macro.Context.*;

  using haxe.macro.Tools;

  using tink.MacroApi;

#end