package stx.g;

class Lang{
  static public function g(wildcard:Wildcard){
    return new stx.g.lang.Module();  
  }
}

typedef GAccess             = stx.g.lang.GAccess;
typedef GAccessSum          = stx.g.lang.GAccess.GAccessSum;
typedef GAccessCtr          = stx.g.lang.GAccess.GAccessCtr;

typedef GBinop              = stx.g.lang.GBinop;
typedef GBinopSum           = stx.g.lang.GBinop.GBinopSum;

typedef GCase               = stx.g.lang.GCase;
typedef GCaseDef            = stx.g.lang.GCase.GCaseDef;
typedef GCaseCtr            = stx.g.lang.GCase.GCaseCtr;

typedef GCatch              = stx.g.lang.GCatch;
typedef GCatchDef           = stx.g.lang.GCatch.GCatchDef;
typedef GCatchCtr           = stx.g.lang.GCatch.GCatchCtr;

typedef GComplexType        = stx.g.lang.GComplexType;
typedef GComplexTypeSum     = stx.g.lang.GComplexType.GComplexTypeSum;
typedef GComplexTypeCtr     = stx.g.lang.GComplexType.GComplexTypeCtr;

typedef GConstant           = stx.g.lang.GConstant;
typedef GConstantSum        = stx.g.lang.GConstant.GConstantSum;
typedef GConstantCtr        = stx.g.lang.GConstant.GConstantCtr;

typedef GExpr               = stx.g.lang.GExpr;
typedef GExprSum            = stx.g.lang.GExpr.GExprSum;
typedef GExprCtr            = stx.g.lang.GExpr.GExprCtr;

typedef GField              = stx.g.lang.GField;
typedef GFieldDef           = stx.g.lang.GField.GFieldDef;
typedef GFieldCtr           = stx.g.lang.GField.GFieldCtr;


typedef GFieldKind          = stx.g.lang.GFieldKind;

typedef GFieldType          = stx.g.lang.GFieldType;
typedef GFieldTypeSum       = stx.g.lang.GFieldType.GFieldTypeSum;
typedef GFieldTypeCtr       = stx.g.lang.GFieldType.GFieldTypeCtr;

typedef GFunction           = stx.g.lang.GFunction;
typedef GFunctionDef        = stx.g.lang.GFunction.GFunctionDef;
typedef GFunctionCtr        = stx.g.lang.GFunction.GFunctionCtr;

typedef GFunctionArg        = stx.g.lang.GFunctionArg;
typedef GFunctionArgDef     = stx.g.lang.GFunctionArg.GFunctionArgDef;
typedef GFunctionArgCtr     = stx.g.lang.GFunctionArg.GFunctionArgCtr;

typedef GMetadata           = stx.g.lang.GMetadata;

typedef GMetadataEntry      = stx.g.lang.GMetadataEntry;
typedef GMetadataEntryDef   = stx.g.lang.GMetadataEntry.GMetadataEntryDef;
typedef GMetadataEntryCtr   = stx.g.lang.GMetadataEntry.GMetadataEntryCtr;

typedef GObjectField        = stx.g.lang.GObjectField;
typedef GObjectFieldDef     = stx.g.lang.GObjectField.GObjectFieldDef;
typedef GObjectFieldCtr     = stx.g.lang.GObjectField.GObjectFieldCtr;

typedef GPropAccess         = stx.g.lang.GPropAccess;

typedef GQuoteStatus        = stx.g.lang.GQuoteStatus;

typedef GSource             = stx.g.lang.GSource;

typedef GStringLiteralKind  = stx.g.lang.GStringLiteralKind;

typedef GTypeDefinition     = stx.g.lang.GTypeDefinition;
typedef GTypeDefinitionDef  = stx.g.lang.GTypeDefinition.GTypeDefinitionDef;
typedef GTypeDefinitionCtr  = stx.g.lang.GTypeDefinition.GTypeDefinitionCtr;

typedef GTypeDefKind        = stx.g.lang.GTypeDefKind;
typedef GTypeDefKindSum     = stx.g.lang.GTypeDefKind.GTypeDefKindSum;
typedef GTypeDefKindCtr     = stx.g.lang.GTypeDefKind.GTypeDefKindCtr;

typedef GTypeParam          = stx.g.lang.GTypeParam;
typedef GTypeParamSum       = stx.g.lang.GTypeParam.GTypeParamSum;
typedef GTypeParamCtr       = stx.g.lang.GTypeParam.GTypeParamCtr;

typedef GTypeParamDecl      = stx.g.lang.GTypeParamDecl;
typedef GTypeParamDeclDef   = stx.g.lang.GTypeParamDecl.GTypeParamDeclDef;
typedef GTypeParamDeclCtr   = stx.g.lang.GTypeParamDecl.GTypeParamDeclCtr;

typedef GTypePath           = stx.g.lang.GTypePath;
typedef GTypePathDef        = stx.g.lang.GTypePath.GTypePathDef;
typedef GTypePathCtr        = stx.g.lang.GTypePath.GTypePathCtr;

typedef GUnop               = stx.g.lang.GUnop;
typedef GUnopSum            = stx.g.lang.GUnop.GUnopSum;

typedef GVar                = stx.g.lang.GVar;
typedef GVarDef             = stx.g.lang.GVar.GVarDef;
typedef GVarCtr             = stx.g.lang.GVar.GVarCtr;
