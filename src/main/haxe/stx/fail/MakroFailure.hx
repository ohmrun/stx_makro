package stx.fail;

enum MakroFailure{
  UnexpectedMacroCondition;
  ImplementationNotFound(type:String,where:String);
}