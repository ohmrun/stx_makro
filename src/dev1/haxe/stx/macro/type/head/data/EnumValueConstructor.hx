package stx.macro.type.head.data;

import stx.macro.type.pack.TFunParamArray in TFunParamArrayT;

typedef EnumValueConstructor = {
  var type  : EnumType;
  var ref   : MethodRef;
  var args  : TFunParamArrayT;
}