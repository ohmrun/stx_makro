package stx.makro.type;

@:using(stx.makro.type.EnumType.EnumTypeLift)
@:forward abstract EnumType(StdEnumType) from StdEnumType{
  static public var _(default,never) = EnumTypeLift;
  public function new(self){
    this = self;
  }
}
class EnumTypeLift{
  @:noUsing static public function getSimpleBinaryCases(e0,e1,uses:TFunParamArray->TFunParamArray->Option<HExpr>,pos){
    function prep(str:String,p:TFunParam):TFunParam return  { name : '${str}${p.name}', opt : p.opt, t : p.t };
    
    return getBinaryCases(
      e0,e1,
      function(lc:EnumValueConstructor,rc:EnumValueConstructor){
        var lhs = HExprDef.ECall(
          LiftMethodRefToHExpr.toHExpr(lc.ref,pos),
          lc.args
          .map(prep.bind("l"))
          .map(
            (tfa) -> LiftConstantToHExpr.toHExpr(Constant.CIdent(tfa.name))
          )
        ).expr(pos);
        var rhs = HExprDef.ECall(
          LiftHExpr.MethodRef.toHExpr(rc.ref,pos),
          rc.args
          .map(prep.bind("r"))
          .map(
            (tfa) -> LiftConstantToHExpr.toHExpr(Constant.CIdent(tfa.name))
          )
        ).expr(pos);

        return uses(lc.args,rc.args).map(
          function (e):Case return { values : [lhs.toExpr(),rhs.toExpr()],  expr : e.toExpr() }
        ).map(v->[v]).def(()->[]);
      },
      pos 
    );
  }
  @:noUsing static public function getModule(e:EnumType):Module{
    return {
      name    : e.name,
      pack    : e.pack,
      module  : new haxe.io.Path(e.module)
    };
  }
  @:noUsing static public function getBinaryCases(e0,e1,gen:EnumValueConstructor->EnumValueConstructor->Array<Case>,pos){
    var lparams = getConstructors(e0);
    var rparams = getConstructors(e1);
    var e0id    = getModule(e0);
    var e1id    = getModule(e1);

    var consl = lparams.toIter().map(
      (tp) -> EnumValueConstructor.make(e0,e0id.call(tp.fst()),tp.snd())
    );
    var consr = rparams.toIter().map(
      (tp) -> EnumValueConstructor.make(e0,e1id.call(tp.fst()),tp.snd())
    );

    var next = consl.map(
      (l) -> consr.map(
        (r) -> gen(l,r)
      )
    ).fold(
      (next,memo) -> next.fold(
        (next0,memo1:Array<Case>) -> memo1.concat(next0),
        memo
      ),
      []
    );
    HExprDef.ESwitch(
      HExprDef.EArrayDecl([HExpr.mark(pos),HExpr.mark(pos)]).expr(pos),
      next.prj(),
      HExpr.unit(pos)
    ).expr(pos);
  }
  @:noUsing static public function getSwitch(e:EnumType,gen:Unary<EnumValueConstructor,Array<Case>>,pos):HExpr{
    var cons  = getConstructors(e);    
    var cases = cons.toIter().map(Field.fromCouple).map(
          (c:Field<TFunParamArray>) -> EnumValueConstructor.make(e,getModule(e).call(c.key),c.val)
        ).map(gen).fold(
          (next,memo:Array<Case>) ->  memo.concat(next),
          []
        );
    return HExprDef.ESwitch(
      HExpr.mark(pos),
      cases,
      HExpr.unit(pos)
    ).expr(pos);
  }
  @:noUsing static public function getSimpleSwitch(e:EnumType,gen:TFunParamArray->Option<HExpr>,pos):HExpr{
    return getSwitch(e,
      function(cons){
        var args = HExprArray.lift(cons.args.map(
          (tfp) -> {
            return LiftConstantToHExpr.toHExpr(Constant.CIdent(tfp.name));
          }
        ));
        trace(cons.ref);
        var call = HExprDef.ECall(
          LiftHExpr.MethodRef.toHExpr(cons.ref,pos),
          args
        ).expr(pos);
        trace(call.show());

        var expr = gen(cons.args);

        return expr.map(
          function(case_expr):Case{
            return {
              values : [call.toExpr()],
              expr   : case_expr.toExpr()
            }
          }
        ).map((c) -> [c]).def(() -> []);
      }
    ,pos
    );
  }
  /**
   * Creates a switch for EnumType e, use the names of the TFunParamArray to access the variables from HExpr
   * ref will be the $x in
   *  switch($x)...
   * HExpr will be the $expr in 
   *  case SomeEnumValue(a,b) : $expr
   * @param e 
   * @param handler 
   * @return StringMap<U>
   */
  @:noUsing static public function switcher<U>(e:EnumType,handler:Array<TFunParam>->HExpr,pos,def):HExpr->HExpr{
    var each = constructorHandler(e,
      handler.fn().split((x)->x)
    );
    var next = [];
    for(key => val in each){
      var case_call_source = val.snd();
      var case_call : HExprArray = case_call_source.map(
        (v:TFunParam) -> LiftMakro.toModule(v.name).map(x -> LiftModuleToHExpr.toHExpr(x,pos)).force()
      );
      var head  = LiftModuleToHExpr.toHExpr(LiftMakro.toModule(key).force(),pos);
      var value = !case_call.is_defined() ? head : HExprDef.ECall(head,case_call).expr(pos);
      var case_ : Case = {
        expr    : val.fst().toExpr(),
        values  : [value.toExpr()]
      }
      next.push(case_);
    }
    return (ref) -> HExprDef.ESwitch(
        ref,next,def
      ).expr(pos);
  }
  @:noUsing static public function getConstructors(e:EnumType):Map<String,TFunParamArray>{
    return e.constructs.toArrayKV().fold(
      (next,memo:Map<String,TFunParamArray>) -> next.into(
        (k,v) -> switch v.type {
          case TFun(args,_) : 
            memo.set(k,(args:TFunParamArray));
            memo;
          default           : 
            memo.set(k,[]);
            memo;
        }
      ),
      __.nano().Map().String()
    );
  } 
  @:noUsing static public function constructorHandler<U>(e:EnumType,handler:Array<TFunParam>->U):StringMap<U>{
    var next = new StringMap();
    for(key => val in e.constructs){
      switch(val.type){
        case TFun(args,_)     : next.set(key,handler(args));
        default               : next.set(key,handler([]));
      }
    }
    return next;
  }   
  @:noUsing static public function constructorOf(e:EnumType,name:String){
    var out = None;
    for(key => val in e.constructs){
      if(key == name){
        out = Some(val.type);
      }
    }
    return out;
  }
}