package stx.g.lang;

class Module extends Clazz{
  public function expr(){
    return GExpr.__;
  }  
  public function type(){
    return GTypeDefinition.__;
  }
  public function field(){
    return GField.__;
  }
  public function field_type(){
    return GFieldType.__;
  }
  public function function_arg(){
    return GFunctionArg.__;
  }
  public function complex_type(){
    return GComplexType.__;
  }
}