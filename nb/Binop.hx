enum Binop {
	OpAdd;//`+`
	OpMult;//`*`
	OpDiv;//`/`
	OpSub;//`-`
	OpAssign;//`=`
	OpEq;//`==`
	OpNotEq;//`!=`
	OpGt;//`>`
	OpGte;//`>=`
	OpLt;//`<`
	OpLte;//`<=`
	OpAnd;//`&`
	OpOr;//`|`
	OpXor;//`^`
	OpBoolAnd;//`&&`
	OpBoolOr;//`||`
	OpShl;//`<<`
	OpShr;//`>>`
	OpUShr;//`>>>`
	OpMod;//`%`
	OpAssignOp(op:Binop);//		`+=` `-=` `/=` `*=` `<<=` `>>=` `>>>=` `|=` `&=` `^=` `%=`
	OpInterval;//`...`
	OpArrow;//`=>`
	OpIn;//`in`
	OpNullCoal;//`??`
}