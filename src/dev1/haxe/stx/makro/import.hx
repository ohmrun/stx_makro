package stx.makro;

using Lambda;

using tink.CoreApi;

import haxe.ds.StringMap;
import haxe.macro.Type;
import haxe.macro.Expr;

import stx.makro.alias.*;

#if macro
  import tink.typecrawler.FieldInfo;
  import tink.typecrawler.Generator;
  import tink.typecrawler.*;

  import haxe.macro.Context; 
  import haxe.macro.Context.*;


  import stx.makro.core.Package;
  import stx.makro.Package;
  import stx.makro.type.Package;
  import stx.makro.expr.Package;

  using haxe.macro.Tools;
  using tink.MacroApi;
  using stx.makro.Lift;
#end

import stx.core.head.Data;

import stx.core.Package;
import stx.fn.Package;
import stx.fp.Package;
import stx.ds.Package;
import stx.log.Package;
import stx.fp.Package;

using stx.core.Lift;
using stx.fn.Lift;
using stx.ds.Lift;
using stx.assert.Lift;
using stx.reflect.Lift;
using stx.log.Lift;