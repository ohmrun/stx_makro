package stx;

#if macro
  using stx.Makro;
#end

class Testify{
  public function new(){}
  #if macro
    public function apply(t:stx.makro.alias.StdMacroType,str:String){
      //var tdef = stx.makro.expr.TypeDefinition.create("a.b.OH3");
      //stx.Makro.build.publish(tdef);
    }
  #end
}