package stx.g.lang.expr;

enum GBinopSum{
  GOpAdd;//`+`
  GOpMult;//`*`
  GOpDiv;//`/`
  GOpSub;//`-`
  GOpAssign;//`=`
  GOpEq;//`==`
  GOpNotEq;//`!=`
  GOpGt;//`>`
  GOpGte;//`>=`
  GOpLt;//`<`
  GOpLte;//`<=`
  GOpAnd;//`&`
  GOpOr;//`|`
  GOpXor;//`^`
  GOpBoolAnd;//`&&`
  GOpBoolOr;//`||`
  GOpShl;//`<<`
  GOpShr;//`>>`
  GOpUShr;//`>>>`
  GOpMod;//`%`
  GOpAssignOp(op:GBinop);//		`+=` `-=` `/=` `*=` `<<=` `>>=` `>>>=` `|=` `&=` `^=` `%=`
  GOpInterval;//`...`
  GOpArrow;//`=>`
  GOpIn;//`in`
  GOpNullCoal;//`??`
 }
 @:using(stx.g.lang.expr.GBinop.GBinopLift)
 abstract GBinop(GBinopSum) from GBinopSum to GBinopSum{
   public function new(self) this = self;
   static public function lift(self:GBinopSum):GBinop return new GBinop(self);
 
   public function prj():GBinopSum return this;
   private var self(get,never):GBinop;
   private function get_self():GBinop return lift(this);

   public function toSource():GSource{
		return Printer.ZERO.printBinop(this);
	}
 }
 class GBinopLift{
  static public function to_macro_at(self:GBinop,pos:Position):Binop{
    return switch(self){
      case GOpAdd             : OpAdd;
      case GOpMult            : OpMult;
      case GOpDiv             : OpDiv;
      case GOpSub             : OpSub;
      case GOpAssign          : OpAssign;
      case GOpEq              : OpEq;
      case GOpNotEq           : OpNotEq;
      case GOpGt              : OpGt;
      case GOpGte             : OpGte;
      case GOpLt              : OpLt;
      case GOpLte             : OpLte;
      case GOpAnd             : OpAnd;
      case GOpOr              : OpOr;
      case GOpXor             : OpXor;
      case GOpBoolAnd         : OpBoolAnd;
      case GOpBoolOr          : OpBoolOr;
      case GOpShl             : OpShl;
      case GOpShr             : OpShr;
      case GOpUShr            : OpUShr;
      case GOpMod             : OpMod;
      case GOpAssignOp(op)    : OpAssignOp(to_macro_at(op,pos));
      case GOpInterval        : OpInterval;
      case GOpArrow           : OpArrow;
      case GOpIn              : OpIn;
      case GOpNullCoal        : OpNullCoal;
    }
  } 
 }