typedef EnumField = {
  var name:String;
  var type:Type;
  
  var params:Array<TypeParameter>;
  var doc:Null<String>;
  var meta:MetaAccess;

  var index:Int;
  
  


  var pos:Expr.Position;
}
