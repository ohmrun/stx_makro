package stx.makro.type;

class Constructors{
    static public function arity(type:Type):Int{
      return switch (type) {
        case TInst(ref,params) :
          var constructor_ref = ref.get().constructor;
          if(constructor_ref == null){
            return -1;
          }

          function unpack(t:Type){
            return switch (t) {
              case TLazy(t) : unpack(t());
              default       : t;
            }
          }
          var constructor = unpack(constructor_ref.get().type);
          return switch (constructor) {
            case TFun(args,_) : args.length;
            default : -1;
          }
        default :
          return -1;
      }
      return -1;
    }
}