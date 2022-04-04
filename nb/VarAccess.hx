enum VarAccess {
	AccNormal;
	AccNo;
	AccNever;
	AccResolve;
	AccCall;
	AccInline;
	AccRequire(r:String, ?msg:String);
	AccCtor;
}