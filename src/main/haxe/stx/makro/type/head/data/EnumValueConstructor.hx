package stx.makro.type.head.data;

import stx.makro.type.pack.TFunParamArray in TFunParamArrayT;

typedef EnumValueConstructor = {
  var type  : EnumType;
  var ref   : MethodRef;
  var args  : TFunParamArrayT;
}