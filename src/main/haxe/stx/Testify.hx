package stx;

#if macro
  using stx.makro.Lift;
#end

class Testify{
  public function new(){}
  #if macro
    public function apply(t:stx.makro.alias.StdType,str:String){
      //var tdef = stx.makro.expr.TypeDefinition.create("a.b.OH3");
      //stx.Makro.build.publish(tdef);
    }
  #end
}