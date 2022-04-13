enum GComplexTypeSum{                                               enum GTypeDefKindSum {
	GTPath(p:GTypePath);                                                GTDEnum;
	GTFunction(args:Cluster<GComplexType>,ret:GComplexType);            GTDStructure;
	GTAnonymous(fields:Cluster<GField>);                                GTDClass(?superClass:GTypePath,?interfaces:Cluster<GTypePath>,?isInterface,?isFinal:Bool,?isAbstract:Bool);
	GTParent(t:GComplexType);                                           GTDAlias(t:ComplexType); // ignore TypeDefinition.fields
	GTExtend(p:Cluster<GTypePath>,fields:Cluster<GField>);              GTDAbstract(tthis:Null<GComplexType>,?from:Cluster<GComplexType>,?to: Cluster<GComplexType>);
	GTOptional(t:GComplexType);                                         GTDField(kind:GFieldType,?access:Cluster<GAccess>);
	GTNamed(n:String,t:GComplexType);                                 }
	GTIntersection(tl:Cluster<GComplexType>);                                               
}
enum GFieldTypeSum {                                                                              GFunctionArgDef = name ?type:GCT,?opt ?value:GExpr ?meta
	GFVar(t:Null<GComplexType>,?e:Null<GExpr>);                                                     GTypePathDef = name pack ?sub ?params
	GFFun(f:GFunction);                                                                             GFieldDef = name kind:GFieldType ?access:Cluster<GAccess> ?meta ?doc
	GFProp(get:GPropAccess,set:GPropAccess,?t:Null<GComplexType>,?e:Null<GExpr>);       
}
GTypeDefinitionDef = name pack kind:GTypeDefKind fields:Cluster<GField> ?params:Cluster<GTypeParamDecl> ?meta ?isExtern ?doc
GTypeParamDeclDef = name ?constraints:Cluster<GComplexType> ?params:Cluster<GTypeParamDecl> ?meta ?defaultType:Null<GComplexType>;
GFieldKind { Normal; Safe; }
GAccessSum =  GAPublic	GAPrivate	GAStatic	GAOverride	GADynamic	GAInline	GAMacro	GAFinal	GAExtern	GAAbstract	GAOverload