package stx.macro.type;


class Params{
    static public function eqR(params0:Array<Type>,params1:Array<Type>,eq:Type->Type->Bool):Bool{
        return params0.zip(params1).all(
          function(tp){
            return eq(tp._0,tp._1);
          }
        );
    }
}