package stx.macro;

using Lambda;

import haxe.ds.StringMap;
import haxe.macro.Type;
import haxe.macro.Expr;

using tink.CoreApi;

import stx.macro.alias.*;


#if macro
  using stx.macro.Lift;

  using haxe.macro.Tools;
  using tink.MacroApi;

  import tink.typecrawler.*;

  import haxe.macro.Context; 
  import haxe.macro.Context.*;

  import stx.macro.core.Package;
  import stx.macro.Package;
  import stx.macro.type.Package;
  import stx.macro.expr.Package;

  using stx.macro.Lift;
#end

import tink.typecrawler.FieldInfo;
import tink.typecrawler.Generator;

import stx.core.head.Data;

import stx.core.Package;
import stx.fn.Package;
import stx.fp.Package;
import stx.ds.Package;


using stx.core.Lift;
using stx.fn.Lift;
using stx.ds.Lift;
using stx.assert.Lift;
using stx.reflect.Lift;
using stx.log.Lift;


using stx.macro.core.body.Errors;