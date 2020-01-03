package types;

enum EnumSelfRecurseSimple{
  SelfRecurse(e:EnumSelfRecurseSimple);
  SelfRecurseTip;
}