package stx.makro.type;

class HStdType{
  static public function ensure(self:HType){
    return switch(self){
      // case TEnum(t,params)        :
      case TInst(t,params) if ((t.get().name == "String") && (t.get().pack.length == 0))        :
        trace('string');
        return TInst(
          {
            get : function(){
              final type = t.get();
                    type.pack = ['std'];
              return type;
            },
            toString : function(){
              final type = t.get();
              return Ident.make(type.name,type.pack).canonical();
            }
          },
          params
        );
        //Context.getType('stx.alias.StdString');
      case TInst(t,params)                : 
        trace(t.get().name);
        trace(t.get().pack);
        self;
      // case TType(t,params)        :
      // case TFun(args, ret)        :
      // case TAnonymous(a)          :
      // case TDynamic(t)            :
      // case TLazy(f)               :
      // case TAbstract(t, params)   :
      default : self;
    }
  }
}