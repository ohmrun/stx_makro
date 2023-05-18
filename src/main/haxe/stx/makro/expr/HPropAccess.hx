package stx.makro.expr;

enum abstract HPropAccessSum(String) from String{
  var PAccFn        = "get";
  var PAccDefault   = "default";
  var PAccNull      = "null";
  var PAccNever     = "never";

  public function toString():String{
    return this;
  }
}
@:using(stx.makro.expr.HPropAccess.HPropAccessLift)
@:forward abstract HPropAccess(HPropAccessSum) from HPropAccessSum to HPropAccessSum{
  static public var _(default,never) = HPropAccessLift;
  public inline function new(self:HPropAccessSum) this = self;
  @:noUsing static inline public function lift(self:HPropAccessSum):HPropAccess return new HPropAccess(self);

  public function prj():HPropAccessSum return this;
  private var self(get,never):HPropAccess;
  private function get_self():HPropAccess return lift(this);

  @:from static public function fromString(self:String){
    return _.getting(self);
  }
  @:to public function toString():String{
    return this.toString();
  }
}
class HPropAccessLift{
  static public inline function lift(self:HPropAccessSum):HPropAccess{
    return HPropAccess.lift(self);
  }
  static public function getting(self:HPropAccess){
    return switch(self){
      case PAccFn       : 'get';
      case PAccDefault  : 'default';
      case PAccNull     : 'null';
      case PAccNever    : 'never';
      default           : throw 'unsupported HPropAcess "#${self}"';
    }
  }
  static public function setting(self:HPropAccess){
    return switch(self){
      case PAccFn       : 'set';
      case PAccDefault  : 'default';
      case PAccNull     : 'null';
      case PAccNever    : 'never';
      default           : throw 'unsupported HPropAcess "#${self}"';
    }
  }
}