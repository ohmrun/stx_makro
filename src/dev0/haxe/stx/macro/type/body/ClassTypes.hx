package stx.macro.type.body;

class ClassTypes{
    #if macro
    static public function ancestors(classtype:ClassType):Array<{ t : Ref<ClassType>, params :Array<Type> }>{
        var ancestors   = [];
        var head        = classtype;
        var cursor      = null;

        while(head!=null){
            cursor = head.superClass;
            if(cursor!=null){
                head = cursor.t.get();
                ancestors.push(cursor);
            }else{
                break;
            }
        }
        return ancestors;
    }
    static public function eqR(l:ClassType,r:ClassType,eq:Type->Type->Bool):Bool{
        return false;   
    }
    #end
}