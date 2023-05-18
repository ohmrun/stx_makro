package stx.assert.makro.expr.ord;

import stx.makro.expr.HTypeDefKind as HTypeDefKindT;

class HTypeDefKind extends OrdCls<HTypeDefKindT>{
  public function new(){}
  public function comply(lhs:HTypeDefKindT,rhs:HTypeDefKindT){
    return switch([lhs,rhs]){
      case [TDEnum,TDEnum] : NotLessThan;
      case [TDStructure,TDStructure] : NotLessThan; 
      case [TDClass(superClassI,interfacesI, isInterfaceI, isFinalI, isAbstractI),TDClass(superClassII,interfacesII, isInterfaceII, isFinalII, isAbstractII)]:
        var ord = Ord.NullOr(new HTypePath()).comply(superClassI,superClassII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Cluster(new HTypePath())).comply(interfacesI,interfacesII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Bool()).comply(isInterfaceI,isInterfaceII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Bool()).comply(isFinalI,isFinalII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Bool()).comply(isAbstractI,isAbstractII);
        }
        ord;
      case [TDAlias(tI),TDAlias(tII)] : 
        new HComplexType().comply(tI,tII);
      case [TDAbstract( tthisI, fromI, toI),TDAbstract( tthisII, fromII, toII)] : 
        var ord = Ord.NullOr(new HComplexType()).comply(tthisI,tthisII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Cluster(new HComplexType())).comply(fromI,fromII);
        }
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Cluster(new HComplexType())).comply(toI,toII);
        }
        ord;
      case [TDField(kindI,accessI),TDField(kindII,accessII)]:
        var ord = new HFieldType().comply(kindI,kindII);
        if(ord.is_not_less_than()){
          ord = Ord.NullOr(Ord.Cluster(new HAccess())).comply(accessI,accessII);
        }
        ord;
      default :
        Ord.EnumValueIndex().comply(lhs,rhs);
    }
  }
}