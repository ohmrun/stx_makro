package stx.makro.type.body;

class ClassKinds{
  @:noUsing static public function types(ck:ClassKind):Array<Type>{
    switch (ck) {
      case KNormal:
      case KTypeParameter(constraints):
      case KExtension(cl, params):
      case KExpr(expr):
      case KGeneric:
      case KGenericInstance(cl, params):
      case KMacroType:
      case KAbstractImpl(a):
      case KGenericBuild:
    }
    return [];
  }
}