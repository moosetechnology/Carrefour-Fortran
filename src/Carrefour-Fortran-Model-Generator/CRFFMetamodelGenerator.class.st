Class {
	#name : 'CRFFMetamodelGenerator',
	#superclass : 'FamixMetamodelGenerator',
	#instVars : [
		'famixProgramUnit',
		'fastProgramUnit',
		'fastAssignment',
		'fastScalarVariable',
		'famixParameter',
		'fastVariableDeclarator',
		'famixStatementFunction',
		'fastStatementFunction',
		'famixFunction',
		'fastFunction',
		'famixInvocation',
		'fastExternalStatement',
		'famixProgramFile',
		'fastProgramFile',
		'fastTWithArguments',
		'famixTStructuralEntity',
		'fastArrayVariable',
		'famixExternalDeclaration',
		'famixAccess',
		'famixIncludedFile',
		'fastIncludedFile'
	],
	#category : 'Carrefour-Fortran-Model-Generator',
	#package : 'Carrefour-Fortran-Model-Generator'
}

{ #category : 'accessing' }
CRFFMetamodelGenerator class >> packageName [
	<ignoreForCoverage>
	^ 'Carrefour-Fortran-Model'
]

{ #category : 'accessing' }
CRFFMetamodelGenerator class >> prefix [
	<ignoreForCoverage>
	^ #CRFF
]

{ #category : 'accessing' }
CRFFMetamodelGenerator class >> submetamodels [

	^ {
		  FASTMetamodelGenerator.
		  FASTFortranGenerator.
		  FamixFortran77Generator.
		  FamixGenerator.
		  FamixEsopeGenerator 
		}
]

{ #category : 'definition' }
CRFFMetamodelGenerator >> defineClasses [
	super defineClasses.

	famixFunction := self remoteEntity: #PUFunction withPrefix: #FamixF77.
	famixExternalDeclaration := self remoteEntity: #ExternalDeclaration withPrefix: #FamixF77.
	famixParameter := self remoteTrait: #TParameter withPrefix: #Famix.
	famixProgramFile := self remoteEntity: #ProgramFile withPrefix: #FamixF77.
	famixProgramUnit := self remoteEntity: #ProgramUnit withPrefix: #FamixF77.
	famixStatementFunction := self remoteEntity: #StatementFunction withPrefix: #FamixF77.
	famixTStructuralEntity := self remoteTrait: #TStructuralEntity withPrefix: #Famix.
	famixInvocation := self remoteEntity: #Invocation withPrefix: #FamixF77.
	famixAccess := self remoteEntity: #Access withPrefix: #FamixF77.
	famixIncludedFile := self remoteEntity: #IncludedFile withPrefix: #FamixF77.

	fastArrayVariable := self remoteEntity: #ArrayVariable withPrefix: #FASTFortran.
	fastAssignment := self remoteEntity: #AssignmentStatement withPrefix: #FASTFortran.
	fastExternalStatement := self remoteEntity: #ExternalStatement withPrefix: #FASTFortran.
	fastFunction := self remoteEntity: #Function withPrefix: #FASTFortran.
	fastProgramFile := self remoteEntity: #ProgramFile withPrefix: #FASTFortran.
	fastProgramUnit := self remoteEntity: #Entity withPrefix: #FASTFortran.
	fastScalarVariable := self remoteEntity: #ScalarVariable withPrefix: #FASTFortran.
	fastStatementFunction := self remoteEntity: #FunctionStatement withPrefix: #FASTFortran.
	fastVariableDeclarator := self remoteEntity: #VariableDeclarator withPrefix: #FASTFortran.
	fastIncludedFile := self remoteEntity: #IncludedFile withPrefix: #FASTFortran.

	fastTWithArguments := self remoteTrait: #TWithArguments withPrefix: #FAST.
]

{ #category : 'definition' }
CRFFMetamodelGenerator >> defineRelations [
	super defineRelations.

	(famixProgramUnit property: #fast) - (fastProgramUnit property: #famix).

	(famixProgramFile property: #fast) - (fastProgramFile property: #famix).

	(famixTStructuralEntity property: #fastDeclaration) - (fastVariableDeclarator property: #famixDeclaration).
	(famixTStructuralEntity property: #fastUses) -* (fastScalarVariable property: #famixVariable).
	(famixTStructuralEntity property: #fastUses) -* (fastArrayVariable property: #famixVariable).
	"Parameters may have 2 FAST entities: FASTProgramUnit>>#parameters and DeclarationStatement"
	"(famixParameter property: #fastParameter) - (fastScalarVariable property: #famixParameter)"

	(famixStatementFunction property: #fast) - (fastStatementFunction property: #famix).
	(famixFunction property: #fast) - (fastFunction property: #famix).
	(famixExternalDeclaration property: #fast) - (fastExternalStatement property: #famix).

	"FASTTWithArguments regroup both calls: CallStatement and FunctionCall"
	(famixInvocation property: #fast) - (fastTWithArguments property: #famix).
	(famixAccess property: #fast) - (fastAssignment property: #famix).

	(famixIncludedFile property: #fast) - (fastIncludedFile property: #famix).

]
