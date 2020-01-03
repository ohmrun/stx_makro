class Main{
  static public function main(){
    #if test
      #if macro   
        utest.UTest.run(stx.makro.Package.macro_tests());
      #else
        utest.UTest.run(stx.makro.Package.tests());
      #end       
    #end
  }
}