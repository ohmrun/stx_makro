package stx.g.lang;

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
 abstract GBinop(GBinopSum) from GBinopSum to GBinopSum{
   public function new(self) this = self;
   static public function lift(self:GBinopSum):GBinop return new GBinop(self);
 
   public function prj():GBinopSum return this;
   private var self(get,never):GBinop;
   private function get_self():GBinop return lift(this);
 }