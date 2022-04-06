typedef MetadataEntry = {
	var name:String;
	var ?params:Array<Expr>;
	var pos:Position;
}

typedef Metadata = Array<MetadataEntry>;