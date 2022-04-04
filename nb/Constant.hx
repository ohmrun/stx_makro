enum Constant {
	CInt(v:String, ?s:String);
	CFloat(f:String, ?s:String);
	CString(s:String, ?kind:StringLiteralKind);
	CIdent(s:String);
	CRegexp(r:String, opt:String);
}