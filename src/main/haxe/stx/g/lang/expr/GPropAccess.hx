package stx.g.lang.expr;

@:using(stx.g.lang.expr.GPropAccess.GPropAccessLift)
enum GPropAccess{
  GPAccFn;
  GPAccDefault;
  GPAccNull;
  GPAccNever;
}
class GPropAccessLift{
  static public function getting(self:GPropAccess){
    return switch(self){
      case GPAccFn       : 'get';
      case GPAccDefault  : 'default';
      case GPAccNull     : 'null';
      case GPAccNever    : 'never';
    }
  }
  static public function setting(self:GPropAccess){
    return switch(self){
      case GPAccFn       : 'set';
      case GPAccDefault  : 'default';
      case GPAccNull     : 'null';
      case GPAccNever    : 'never';
    }
  }
}