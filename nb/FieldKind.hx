enum FieldKind {
	FVar(read:VarAccess, write:VarAccess);
	FMethod(k:MethodKind);
}