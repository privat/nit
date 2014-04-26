# Raw AST node hierarchy.
# This file was generated by SableCC (http://www.sablecc.org/).
module parser_abs

import location

class TEol
	super Token
end
class TComment
	super Token
end
class TKwpackage
	super Token
end
class TKwmodule
	super Token
end
class TKwimport
	super Token
end
class TKwclass
	super Token
end
class TKwabstract
	super Token
end
class TKwinterface
	super Token
end
class TKwenum
	super Token
end
class TKwend
	super Token
end
class TKwmeth
	super Token
end
class TKwtype
	super Token
end
class TKwinit
	super Token
end
class TKwredef
	super Token
end
class TKwis
	super Token
end
class TKwdo
	super Token
end
class TKwreadable
	super Token
end
class TKwwritable
	super Token
end
class TKwvar
	super Token
end
class TKwintern
	super Token
end
class TKwextern
	super Token
end
class TKwpublic
	super Token
end
class TKwprotected
	super Token
end
class TKwprivate
	super Token
end
class TKwintrude
	super Token
end
class TKwif
	super Token
end
class TKwthen
	super Token
end
class TKwelse
	super Token
end
class TKwwhile
	super Token
end
class TKwloop
	super Token
end
class TKwfor
	super Token
end
class TKwin
	super Token
end
class TKwand
	super Token
end
class TKwor
	super Token
end
class TKwnot
	super Token
end
class TKwimplies
	super Token
end
class TKwreturn
	super Token
end
class TKwcontinue
	super Token
end
class TKwbreak
	super Token
end
class TKwabort
	super Token
end
class TKwassert
	super Token
end
class TKwnew
	super Token
end
class TKwisa
	super Token
end
class TKwonce
	super Token
end
class TKwsuper
	super Token
end
class TKwself
	super Token
end
class TKwtrue
	super Token
end
class TKwfalse
	super Token
end
class TKwnull
	super Token
end
class TKwas
	super Token
end
class TKwnullable
	super Token
end
class TKwisset
	super Token
end
class TKwlabel
	super Token
end
class TKwdebug
	super Token
end
class TOpar
	super Token
end
class TCpar
	super Token
end
class TObra
	super Token
end
class TCbra
	super Token
end
class TComma
	super Token
end
class TColumn
	super Token
end
class TQuad
	super Token
end
class TAssign
	super Token
end
class TPluseq
	super Token
end
class TMinuseq
	super Token
end
class TDotdotdot
	super Token
end
class TDotdot
	super Token
end
class TDot
	super Token
end
class TPlus
	super Token
end
class TMinus
	super Token
end
class TStar
	super Token
end
class TSlash
	super Token
end
class TPercent
	super Token
end
class TEq
	super Token
end
class TNe
	super Token
end
class TLt
	super Token
end
class TLe
	super Token
end
class TLl
	super Token
end
class TGt
	super Token
end
class TGe
	super Token
end
class TGg
	super Token
end
class TStarship
	super Token
end
class TBang
	super Token
end
class TAt
	super Token
end
class TClassid
	super Token
end
class TId
	super Token
end
class TAttrid
	super Token
end
class TNumber
	super Token
end
class THexNumber
	super Token
end
class TFloat
	super Token
end
class TString
	super Token
end
class TStartString
	super Token
end
class TMidString
	super Token
end
class TEndString
	super Token
end
class TChar
	super Token
end
class TBadString
	super Token
end
class TBadChar
	super Token
end
class TExternCodeSegment
	super Token
end
class EOF
	super Token
end
class AError
	super EOF
end
class ALexerError
	super AError
end
class AParserError
	super AError
end

class AModule super Prod end
class AModuledecl super Prod end
class AImport super Prod end
class AVisibility super Prod end
class AClassdef super Prod end
class AClasskind super Prod end
class AFormaldef super Prod end
class ASuperclass super Prod end
class APropdef super Prod end
class AAble super Prod end
class AMethid super Prod end
class ASignature super Prod end
class AParam super Prod end
class AType super Prod end
class ALabel super Prod end
class AExpr super Prod end
class AExprs super Prod end
class AAssignOp super Prod end
class AModuleName super Prod end
class AExternCalls super Prod end
class AExternCall super Prod end
class AInLanguage super Prod end
class AExternCodeBlock super Prod end
class AQualified super Prod end
class ADoc super Prod end
class AAnnotations super Prod end
class AAnnotation super Prod end
class AAtArg super Prod end
class AAtid super Prod end

class AModule
	super AModule
    var n_moduledecl: nullable AModuledecl = null
    var n_imports: List[AImport] = new List[AImport]
    var n_extern_code_blocks: List[AExternCodeBlock] = new List[AExternCodeBlock]
    var n_classdefs: List[AClassdef] = new List[AClassdef]
end
class AModuledecl
	super AModuledecl
    var n_doc: nullable ADoc = null
    var n_kwmodule: TKwmodule
    var n_name: AModuleName
    var n_annotations: nullable AAnnotations = null
end
class AStdImport
	super AImport
    var n_visibility: AVisibility
    var n_kwimport: TKwimport
    var n_name: AModuleName
    var n_annotations: nullable AAnnotations = null
end
class ANoImport
	super AImport
    var n_visibility: AVisibility
    var n_kwimport: TKwimport
    var n_kwend: TKwend
end
class APublicVisibility
	super AVisibility
end
class APrivateVisibility
	super AVisibility
    var n_kwprivate: TKwprivate
end
class AProtectedVisibility
	super AVisibility
    var n_kwprotected: TKwprotected
end
class AIntrudeVisibility
	super AVisibility
    var n_kwintrude: TKwintrude
end
class AStdClassdef
	super AClassdef
    var n_doc: nullable ADoc = null
    var n_kwredef: nullable TKwredef = null
    var n_visibility: AVisibility
    var n_classkind: AClasskind
    var n_id: nullable TClassid = null
    var n_formaldefs: List[AFormaldef] = new List[AFormaldef]
    var n_annotations: nullable AAnnotations = null
    var n_extern_code_block: nullable AExternCodeBlock = null
    var n_superclasses: List[ASuperclass] = new List[ASuperclass]
    var n_propdefs: List[APropdef] = new List[APropdef]
    var n_kwend: TKwend
end
class ATopClassdef
	super AClassdef
    var n_propdefs: List[APropdef] = new List[APropdef]
end
class AMainClassdef
	super AClassdef
    var n_propdefs: List[APropdef] = new List[APropdef]
end
class AConcreteClasskind
	super AClasskind
    var n_kwclass: TKwclass
end
class AAbstractClasskind
	super AClasskind
    var n_kwabstract: TKwabstract
    var n_kwclass: TKwclass
end
class AInterfaceClasskind
	super AClasskind
    var n_kwinterface: TKwinterface
end
class AEnumClasskind
	super AClasskind
    var n_kwenum: TKwenum
end
class AExternClasskind
	super AClasskind
    var n_kwextern: TKwextern
    var n_kwclass: nullable TKwclass = null
end
class AFormaldef
	super AFormaldef
    var n_id: TClassid
    var n_type: nullable AType = null
    var n_annotations: nullable AAnnotations = null
end
class ASuperclass
	super ASuperclass
    var n_kwsuper: TKwsuper
    var n_type: AType
    var n_annotations: nullable AAnnotations = null
end
class AAttrPropdef
	super APropdef
    var n_doc: nullable ADoc = null
    var n_readable: nullable AAble = null
    var n_writable: nullable AAble = null
    var n_kwredef: nullable TKwredef = null
    var n_visibility: AVisibility
    var n_kwvar: TKwvar
    var n_id: nullable TAttrid = null
    var n_id2: nullable TId = null
    var n_type: nullable AType = null
    var n_annotations: nullable AAnnotations = null
    var n_expr: nullable AExpr = null
end
class AMethPropdef
	super APropdef
    var n_doc: nullable ADoc = null
    var n_kwredef: nullable TKwredef = null
    var n_visibility: AVisibility
    var n_methid: nullable AMethid = null
    var n_signature: ASignature
end
class ADeferredMethPropdef
	super APropdef
    var n_doc: nullable ADoc = null
    var n_kwredef: nullable TKwredef = null
    var n_visibility: AVisibility
    var n_kwmeth: TKwmeth
    var n_methid: AMethid
    var n_signature: ASignature
    var n_annotations: nullable AAnnotations = null
end
class AInternMethPropdef
	super APropdef
    var n_doc: nullable ADoc = null
    var n_kwredef: nullable TKwredef = null
    var n_visibility: AVisibility
    var n_kwmeth: TKwmeth
    var n_methid: AMethid
    var n_signature: ASignature
end
class AExternMethPropdef
	super APropdef
    var n_doc: nullable ADoc = null
    var n_kwredef: nullable TKwredef = null
    var n_visibility: AVisibility
    var n_kwmeth: TKwmeth
    var n_methid: AMethid
    var n_signature: ASignature
    var n_extern: nullable TString = null
    var n_extern_calls: nullable AExternCalls = null
    var n_extern_code_block: nullable AExternCodeBlock = null
end
class AConcreteMethPropdef
	super APropdef
    var n_doc: nullable ADoc = null
    var n_kwredef: nullable TKwredef = null
    var n_visibility: AVisibility
    var n_kwmeth: TKwmeth
    var n_methid: nullable AMethid = null
    var n_signature: ASignature
    var n_annotations: nullable AAnnotations = null
    var n_block: nullable AExpr = null
end
class AConcreteInitPropdef
	super APropdef
    var n_doc: nullable ADoc = null
    var n_kwredef: nullable TKwredef = null
    var n_visibility: AVisibility
    var n_kwinit: TKwinit
    var n_methid: nullable AMethid = null
    var n_signature: ASignature
    var n_annotations: nullable AAnnotations = null
    var n_block: nullable AExpr = null
end
class AExternInitPropdef
	super APropdef
    var n_doc: nullable ADoc = null
    var n_kwredef: nullable TKwredef = null
    var n_visibility: AVisibility
    var n_kwnew: TKwnew
    var n_methid: nullable AMethid = null
    var n_signature: ASignature
    var n_extern: nullable TString = null
    var n_extern_calls: nullable AExternCalls = null
    var n_extern_code_block: nullable AExternCodeBlock = null
end
class AMainMethPropdef
	super APropdef
    var n_kwredef: nullable TKwredef = null
    var n_block: nullable AExpr = null
end
class ATypePropdef
	super APropdef
    var n_doc: nullable ADoc = null
    var n_kwredef: nullable TKwredef = null
    var n_visibility: AVisibility
    var n_kwtype: TKwtype
    var n_id: TClassid
    var n_type: AType
    var n_annotations: nullable AAnnotations = null
end
class AReadAble
	super AAble
    var n_kwredef: nullable TKwredef = null
    var n_kwreadable: TKwreadable
end
class AWriteAble
	super AAble
    var n_kwredef: nullable TKwredef = null
    var n_visibility: nullable AVisibility = null
    var n_kwwritable: TKwwritable
end
class AIdMethid
	super AMethid
    var n_id: TId
end
class APlusMethid
	super AMethid
    var n_plus: TPlus
end
class AMinusMethid
	super AMethid
    var n_minus: TMinus
end
class AStarMethid
	super AMethid
    var n_star: TStar
end
class ASlashMethid
	super AMethid
    var n_slash: TSlash
end
class APercentMethid
	super AMethid
    var n_percent: TPercent
end
class AEqMethid
	super AMethid
    var n_eq: TEq
end
class ANeMethid
	super AMethid
    var n_ne: TNe
end
class ALeMethid
	super AMethid
    var n_le: TLe
end
class AGeMethid
	super AMethid
    var n_ge: TGe
end
class ALtMethid
	super AMethid
    var n_lt: TLt
end
class AGtMethid
	super AMethid
    var n_gt: TGt
end
class ALlMethid
	super AMethid
    var n_ll: TLl
end
class AGgMethid
	super AMethid
    var n_gg: TGg
end
class ABraMethid
	super AMethid
    var n_obra: TObra
    var n_cbra: TCbra
end
class AStarshipMethid
	super AMethid
    var n_starship: TStarship
end
class AAssignMethid
	super AMethid
    var n_id: TId
    var n_assign: TAssign
end
class ABraassignMethid
	super AMethid
    var n_obra: TObra
    var n_cbra: TCbra
    var n_assign: TAssign
end
class ASignature
	super ASignature
    var n_opar: nullable TOpar = null
    var n_params: List[AParam] = new List[AParam]
    var n_cpar: nullable TCpar = null
    var n_type: nullable AType = null
end
class AParam
	super AParam
    var n_id: TId
    var n_type: nullable AType = null
    var n_dotdotdot: nullable TDotdotdot = null
    var n_annotations: nullable AAnnotations = null
end
class AType
	super AType
    var n_kwnullable: nullable TKwnullable = null
    var n_id: TClassid
    var n_types: List[AType] = new List[AType]
    var n_annotations: nullable AAnnotations = null
end
class ALabel
	super ALabel
    var n_kwlabel: TKwlabel
    var n_id: TId
end
class ABlockExpr
	super AExpr
    var n_expr: List[AExpr] = new List[AExpr]
    var n_kwend: nullable TKwend = null
end
class AVardeclExpr
	super AExpr
    var n_kwvar: TKwvar
    var n_id: TId
    var n_type: nullable AType = null
    var n_assign: nullable TAssign = null
    var n_expr: nullable AExpr = null
    var n_annotations: nullable AAnnotations = null
end
class AReturnExpr
	super AExpr
    var n_kwreturn: nullable TKwreturn = null
    var n_expr: nullable AExpr = null
end
class ABreakExpr
	super AExpr
    var n_kwbreak: TKwbreak
    var n_label: nullable ALabel = null
    var n_expr: nullable AExpr = null
end
class AAbortExpr
	super AExpr
    var n_kwabort: TKwabort
end
class AContinueExpr
	super AExpr
    var n_kwcontinue: nullable TKwcontinue = null
    var n_label: nullable ALabel = null
    var n_expr: nullable AExpr = null
end
class ADoExpr
	super AExpr
    var n_kwdo: TKwdo
    var n_block: nullable AExpr = null
    var n_label: nullable ALabel = null
end
class AIfExpr
	super AExpr
    var n_kwif: TKwif
    var n_expr: AExpr
    var n_then: nullable AExpr = null
    var n_else: nullable AExpr = null
end
class AIfexprExpr
	super AExpr
    var n_kwif: TKwif
    var n_expr: AExpr
    var n_kwthen: TKwthen
    var n_then: AExpr
    var n_kwelse: TKwelse
    var n_else: AExpr
end
class AWhileExpr
	super AExpr
    var n_kwwhile: TKwwhile
    var n_expr: AExpr
    var n_kwdo: TKwdo
    var n_block: nullable AExpr = null
    var n_label: nullable ALabel = null
end
class ALoopExpr
	super AExpr
    var n_kwloop: TKwloop
    var n_block: nullable AExpr = null
    var n_label: nullable ALabel = null
end
class AForExpr
	super AExpr
    var n_kwfor: TKwfor
    var n_ids: List[TId] = new List[TId]
    var n_expr: AExpr
    var n_kwdo: TKwdo
    var n_block: nullable AExpr = null
    var n_label: nullable ALabel = null
end
class AAssertExpr
	super AExpr
    var n_kwassert: TKwassert
    var n_id: nullable TId = null
    var n_expr: AExpr
    var n_else: nullable AExpr = null
end
class AOnceExpr
	super AExpr
    var n_kwonce: TKwonce
    var n_expr: AExpr
end
class ASendExpr
	super AExpr
    var n_expr: AExpr
end
class ABinopExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class AOrExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class AAndExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class AOrElseExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class AImpliesExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class ANotExpr
	super AExpr
    var n_kwnot: TKwnot
    var n_expr: AExpr
end
class AEqExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class ANeExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class ALtExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class ALeExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class ALlExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class AGtExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class AGeExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class AGgExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class AIsaExpr
	super AExpr
    var n_expr: AExpr
    var n_type: AType
end
class APlusExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class AMinusExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class AStarshipExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class AStarExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class ASlashExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class APercentExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
end
class AUminusExpr
	super AExpr
    var n_minus: TMinus
    var n_expr: AExpr
end
class ANewExpr
	super AExpr
    var n_kwnew: TKwnew
    var n_type: AType
    var n_id: nullable TId = null
    var n_args: AExprs
end
class AAttrExpr
	super AExpr
    var n_expr: AExpr
    var n_id: TAttrid
end
class AAttrAssignExpr
	super AExpr
    var n_expr: AExpr
    var n_id: TAttrid
    var n_assign: TAssign
    var n_value: AExpr
end
class AAttrReassignExpr
	super AExpr
    var n_expr: AExpr
    var n_id: TAttrid
    var n_assign_op: AAssignOp
    var n_value: AExpr
end
class ACallExpr
	super AExpr
    var n_expr: AExpr
    var n_id: TId
    var n_args: AExprs
end
class ACallAssignExpr
	super AExpr
    var n_expr: AExpr
    var n_id: TId
    var n_args: AExprs
    var n_assign: TAssign
    var n_value: AExpr
end
class ACallReassignExpr
	super AExpr
    var n_expr: AExpr
    var n_id: TId
    var n_args: AExprs
    var n_assign_op: AAssignOp
    var n_value: AExpr
end
class ASuperExpr
	super AExpr
    var n_qualified: nullable AQualified = null
    var n_kwsuper: TKwsuper
    var n_args: AExprs
end
class AInitExpr
	super AExpr
    var n_expr: AExpr
    var n_kwinit: TKwinit
    var n_args: AExprs
end
class ABraExpr
	super AExpr
    var n_expr: AExpr
    var n_args: AExprs
end
class ABraAssignExpr
	super AExpr
    var n_expr: AExpr
    var n_args: AExprs
    var n_assign: TAssign
    var n_value: AExpr
end
class ABraReassignExpr
	super AExpr
    var n_expr: AExpr
    var n_args: AExprs
    var n_assign_op: AAssignOp
    var n_value: AExpr
end
class AVarExpr
	super AExpr
    var n_id: TId
end
class AVarAssignExpr
	super AExpr
    var n_id: TId
    var n_assign: TAssign
    var n_value: AExpr
end
class AVarReassignExpr
	super AExpr
    var n_id: TId
    var n_assign_op: AAssignOp
    var n_value: AExpr
end
class ARangeExpr
	super AExpr
    var n_expr: AExpr
    var n_expr2: AExpr
    var n_annotations: nullable AAnnotations = null
end
class ACrangeExpr
	super AExpr
    var n_obra: TObra
    var n_expr: AExpr
    var n_expr2: AExpr
    var n_cbra: TCbra
    var n_annotations: nullable AAnnotations = null
end
class AOrangeExpr
	super AExpr
    var n_obra: TObra
    var n_expr: AExpr
    var n_expr2: AExpr
    var n_cbra: TObra
    var n_annotations: nullable AAnnotations = null
end
class AArrayExpr
	super AExpr
    var n_exprs: AExprs
    var n_annotations: nullable AAnnotations = null
end
class ASelfExpr
	super AExpr
    var n_kwself: TKwself
    var n_annotations: nullable AAnnotations = null
end
class AImplicitSelfExpr
	super AExpr
end
class ATrueExpr
	super AExpr
    var n_kwtrue: TKwtrue
    var n_annotations: nullable AAnnotations = null
end
class AFalseExpr
	super AExpr
    var n_kwfalse: TKwfalse
    var n_annotations: nullable AAnnotations = null
end
class ANullExpr
	super AExpr
    var n_kwnull: TKwnull
    var n_annotations: nullable AAnnotations = null
end
class ADecIntExpr
	super AExpr
    var n_number: TNumber
    var n_annotations: nullable AAnnotations = null
end
class AHexIntExpr
	super AExpr
    var n_hex_number: THexNumber
    var n_annotations: nullable AAnnotations = null
end
class AFloatExpr
	super AExpr
    var n_float: TFloat
    var n_annotations: nullable AAnnotations = null
end
class ACharExpr
	super AExpr
    var n_char: TChar
    var n_annotations: nullable AAnnotations = null
end
class AStringExpr
	super AExpr
    var n_string: TString
    var n_annotations: nullable AAnnotations = null
end
class AStartStringExpr
	super AExpr
    var n_string: TStartString
end
class AMidStringExpr
	super AExpr
    var n_string: TMidString
end
class AEndStringExpr
	super AExpr
    var n_string: TEndString
end
class ASuperstringExpr
	super AExpr
    var n_exprs: List[AExpr] = new List[AExpr]
    var n_annotations: nullable AAnnotations = null
end
class AParExpr
	super AExpr
    var n_opar: TOpar
    var n_expr: AExpr
    var n_cpar: TCpar
    var n_annotations: nullable AAnnotations = null
end
class AAsCastExpr
	super AExpr
    var n_expr: AExpr
    var n_kwas: TKwas
    var n_opar: nullable TOpar = null
    var n_type: AType
    var n_cpar: nullable TCpar = null
end
class AAsNotnullExpr
	super AExpr
    var n_expr: AExpr
    var n_kwas: TKwas
    var n_opar: nullable TOpar = null
    var n_kwnot: TKwnot
    var n_kwnull: TKwnull
    var n_cpar: nullable TCpar = null
end
class AIssetAttrExpr
	super AExpr
    var n_kwisset: TKwisset
    var n_expr: AExpr
    var n_id: TAttrid
end
class ADebugTypeExpr
	super AExpr
    var n_kwdebug: TKwdebug
    var n_kwtype: TKwtype
    var n_expr: AExpr
    var n_type: AType
end
class AListExprs
	super AExprs
    var n_exprs: List[AExpr] = new List[AExpr]
end
class AParExprs
	super AExprs
    var n_opar: TOpar
    var n_exprs: List[AExpr] = new List[AExpr]
    var n_cpar: TCpar
end
class ABraExprs
	super AExprs
    var n_obra: TObra
    var n_exprs: List[AExpr] = new List[AExpr]
    var n_cbra: TCbra
end
class APlusAssignOp
	super AAssignOp
    var n_pluseq: TPluseq
end
class AMinusAssignOp
	super AAssignOp
    var n_minuseq: TMinuseq
end
class AModuleName
	super AModuleName
    var n_quad: nullable TQuad = null
    var n_path: List[TId] = new List[TId]
    var n_id: TId
end
class AExternCalls
	super AExternCalls
    var n_kwimport: TKwimport
    var n_extern_calls: List[AExternCall] = new List[AExternCall]
end
class AExternCall
	super AExternCall
end
class ASuperExternCall
	super AExternCall
    var n_kwsuper: TKwsuper
end
class ALocalPropExternCall
	super AExternCall
    var n_methid: AMethid
end
class AFullPropExternCall
	super AExternCall
    var n_type: AType
    var n_dot: nullable TDot = null
    var n_methid: AMethid
end
class AInitPropExternCall
	super AExternCall
    var n_type: AType
end
class ACastAsExternCall
	super AExternCall
    var n_from_type: AType
    var n_dot: nullable TDot = null
    var n_kwas: TKwas
    var n_to_type: AType
end
class AAsNullableExternCall
	super AExternCall
    var n_type: AType
    var n_kwas: TKwas
    var n_kwnullable: TKwnullable
end
class AAsNotNullableExternCall
	super AExternCall
    var n_type: AType
    var n_kwas: TKwas
    var n_kwnot: TKwnot
    var n_kwnullable: TKwnullable
end
class AInLanguage
	super AInLanguage
    var n_kwin: TKwin
    var n_string: TString
end
class AExternCodeBlock
	super AExternCodeBlock
    var n_in_language: nullable AInLanguage = null
    var n_extern_code_segment: TExternCodeSegment
end
class AQualified
	super AQualified
    var n_id: List[TId] = new List[TId]
    var n_classid: nullable TClassid = null
end
class ADoc
	super ADoc
    var n_comment: List[TComment] = new List[TComment]
end
class AAnnotations
	super AAnnotations
    var n_at: nullable TAt = null
    var n_opar: nullable TOpar = null
    var n_items: List[AAnnotation] = new List[AAnnotation]
    var n_cpar: nullable TCpar = null
end
class AAnnotation
	super AAnnotation
    var n_atid: AAtid
    var n_opar: nullable TOpar = null
    var n_args: List[AAtArg] = new List[AAtArg]
    var n_cpar: nullable TCpar = null
    var n_annotations: nullable AAnnotations = null
end
class ATypeAtArg
	super AAtArg
    var n_type: AType
end
class AExprAtArg
	super AAtArg
    var n_expr: AExpr
end
class AAtAtArg
	super AAtArg
    var n_annotations: AAnnotations
end
class AIdAtid
	super AAtid
    var n_id: TId
end
class AKwexternAtid
	super AAtid
    var n_id: TKwextern
end
class AKwinternAtid
	super AAtid
    var n_id: TKwintern
end
class AKwreadableAtid
	super AAtid
    var n_id: TKwreadable
end
class AKwwritableAtid
	super AAtid
    var n_id: TKwwritable
end
class AKwimportAtid
	super AAtid
    var n_id: TKwimport
end

class Start
	super Prod
    var n_base: nullable AModule
    var n_eof: EOF
    init(
        nbase: nullable AModule,
        neof: EOF)
    do
        n_base = nbase
        n_eof = neof
    end

end
