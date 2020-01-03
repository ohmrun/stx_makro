/**
 * Intended to create an enum from classes to nbavigate through
 * **/
class Window{
  #if macro
    static public function apply(t:Type){
      var ident   = Types.identify(t);
      var fields  = Types.getFields(t)
      .filter(
        (cf) -> switch(cf.type){
          case TFun(_) : false;
          default : true;
        }
      );
      var window_ident = {
        pack : ident.pack,
        name : '${ident.name}Window'
      }
      var tdef : TypeDefinition = {
        pack : window_ident.pack,
        name : window_ident.name,
        pos  : Context.currentPos(),
        kind : TDEnum,
        fields : fields.map(classFieldToEnumField)
      }; 
      trace(new Printer().printTypeDefinition(tdef));
      Context.defineType(tdef);
    }
    static function classFieldToEnumField(cf:ClassField):Field{
      var func : Function = Functions.unit();
      var arg : FunctionArg = {
        name : 'v',
        type : TKTypes.toComplex(cf.type)
      }
        func.args = [arg];
      var field : Field = {
        pos : Context.currentPos(),
        name : cf.name,
        kind : FFun(func),
        access : [APublic]
      };
      return field;
    }
  #end
}