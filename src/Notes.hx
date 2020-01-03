// package src;

// class Notes{
//    static public function build(){
//     #if macro
//       trace("BUILD");
//       Context.onAfterTyping(
//         function(x){
//           var t:Array<ModuleType> = x.map(function(x):ModuleType return x);
//           for(val in t){
//               //trace(val.getMeta());
//               var eqs = val.getMeta().filter(
//                 (x) -> x.name == ":stx.assert.Eq"
//               );
//               for(v in eqs){
//                 //trace(val.getIdentity().toString());
//               }
//           }
//         }
//       );
//     #end
//   }
// }
// @:stx.assert.Eq
// class TestEq{
//   public function new(){}
// }