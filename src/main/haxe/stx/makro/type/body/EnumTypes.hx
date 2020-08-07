package stx.makro.type.body;

class EnumTypes{
  @:noUsing static public function getSimpleBinaryCases(e0,e1,uses:TFunParamArray->TFunParamArray->Option<Expr>,pos){
    function prep(str:String,p:TFunParam):TFunParam return  { name : '${str}${p.name}', opt : p.opt, t : p.t };
    
    return getBinaryCases(
      e0,e1,
      function(lc:EnumValueConstructor,rc:EnumValueConstructor){
        var lhs = ExprDefs.ECall(
          lc.ref.expr(pos),
          lc.args
          .map(prep.bind("l"))
          .map(
            (tfa) -> Constants.CIdent(tfa.name).expr(pos)
          )
        ).expr(pos);
        var rhs = ExprDefs.ECall(
          rc.ref.expr(pos),
          rc.args
          .map(prep.bind("r"))
          .map(
            (tfa) -> Constants.CIdent(tfa.name).expr(pos)
          )
        ).expr(pos);

        return uses(lc.args,rc.args).map(
          function (e):Case return { values : [lhs,rhs],  expr : e }
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
    ExprDefs.ESwitch(
      ExprDefs.EArrayDecl([Exprs.mark(pos).prj(),Exprs.mark(pos).prj()]).expr(pos),
      next.prj(),
      Exprs.unit(pos).prj()
    ).expr(pos);
  }
  @:noUsing static public function getSwitch(e:EnumType,gen:Unary<EnumValueConstructor,Array<Case>>,pos):Expr{
    var cons  = getConstructors(e);    
    var cases = cons.toIter().map(
          (c) -> EnumValueConstructor.make(e,getModule(e).call(c.key),c.val)
        ).map(gen).fold(
          (next,memo:Array<Case>) ->  memo.concat(next),
          []
        );
    return ExprDefs.ESwitch(
      Exprs.mark(pos),
      cases,
      Exprs.unit(pos)
    ).expr(pos);
  }
  @:noUsing static public function getSimpleSwitch(e:EnumType,gen:TFunParamArray->Option<Expr>,pos):Expr{
    return getSwitch(e,
      function(cons){
        var args = cons.args.map(
          (tfp) -> {
            return Constants.CIdent(tfp.name).expr(pos);
          }
        );
        trace(cons.ref);
        var call = ExprDefs.ECall(
          cons.ref.expr(pos),
          args
        ).expr(pos);
        trace(call.show());

        var expr = gen(cons.args);

        return expr.map(
          function(case_expr):Case{
            return {
              values : [call.prj()],
              expr   : case_expr
            }
          }
        ).map((c) -> [c]).def(() -> []);
      }
    ,pos
    );
  }
  /**
   * Creates a switch for EnumType e, use the names of the TFunParamArray to access the variables from Expr
   * ref will be the $x in
   *  switch($x)...
   * Expr will be the $expr in 
   *  case SomeEnumValue(a,b) : $expr
   * @param e 
   * @param handler 
   * @return StringMap<U>
   */
  @:noUsing static public function switcher<U>(e:EnumType,handler:Array<TFunParam>->Expr,pos,def):Expr->Expr{
    var each = constructorHandler(e,
      handler.fn().split((x)->x)
    );
    var next = [];
    for(key => val in each){
      var case_call_source = val.snd();
      var case_call : Array<StdExpr> = case_call_source.map(
        (v:TFunParam) -> v.name.toModule().map(x -> x.expr(pos)).force()
      );
      var head  = key.toModule().force().expr(pos);
      var value = !case_call.is_defined() ? head : ExprDefs.ECall(head,case_call.prj()).expr(pos);
      var case_ : Case = {
        expr    : val.fst(),
        values  : [value]
      }
      next.push(case_);
    }
    return (ref) -> ExprDefs.ESwitch(
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
      __.core().Map().String()
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