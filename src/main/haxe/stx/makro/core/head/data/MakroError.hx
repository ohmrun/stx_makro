package stx.makro.core.head.data;

enum MakroError{
  UnexpectedMacroCondition;
  ImplementationNotFound(type:String,where:String);
}