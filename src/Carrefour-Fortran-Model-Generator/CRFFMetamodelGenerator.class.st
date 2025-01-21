Class {
	#name : 'CRFFMetamodelGenerator',
	#superclass : 'FamixMetamodelGenerator',
	#instVars : [
		'famixProgramUnit',
		'fastProgramUnit',
		'fastAssignment',
		'fastScalarVariable',
		'famixStructuralEntity',
		'famixParameter',
		'fastVariableDeclarator',
		'famixStatementFunction',
		'fastStatementFunction',
		'famixFunction',
		'fastFunction',
		'famixInvocation',
		'fastCallStatement',
		'famixExternalFunction',
		'fastExternalStatement',
		'famixProgramFile',
		'fastProgramFile'
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
	famixExternalFunction := self remoteEntity: #ExternalDeclaration withPrefix: #FamixF77.
	famixParameter := self remoteTrait: #TParameter withPrefix: #Famix.
	famixProgramFile := self remoteEntity: #ProgramFile withPrefix: #FamixF77.
	famixProgramUnit := self remoteEntity: #ProgramUnit withPrefix: #FamixF77.
	famixStatementFunction := self remoteEntity: #StatementFunction withPrefix: #FamixF77.
	famixStructuralEntity := self remoteTrait: #TStructuralEntity withPrefix: #Famix.
	famixInvocation := self remoteEntity: #Invocation withPrefix: #FamixF77.

	fastAssignment := self remoteEntity: #AssignmentStatement withPrefix: #FASTFortran.
	fastCallStatement := self remoteEntity: #CallStatement withPrefix: #FASTFortran.
	fastExternalStatement := self remoteEntity: #ExternalStatement withPrefix: #FASTFortran.
	fastFunction := self remoteEntity: #Function withPrefix: #FASTFortran.
	fastProgramFile := self remoteEntity: #ProgramFile withPrefix: #FASTFortran.
	fastProgramUnit := self remoteEntity: #Entity withPrefix: #FASTFortran.
	fastScalarVariable := self remoteEntity: #ScalarVariable withPrefix: #FASTFortran.
	fastStatementFunction := self remoteEntity: #FunctionStatement withPrefix: #FASTFortran.
	fastVariableDeclarator := self remoteEntity: #VariableDeclarator withPrefix: #FASTFortran.


]

{ #category : 'definition' }
CRFFMetamodelGenerator >> defineRelations [
	super defineRelations.

	(famixProgramUnit property: #fast) - (fastProgramUnit property: #famix).
	
	(famixProgramFile property: #fast) - (fastProgramFile property: #famix).

	(famixStructuralEntity property: #fastDeclaration) - (fastVariableDeclarator property: #famixDeclaration).
	(famixStructuralEntity property: #fastAssignment) -* (fastAssignment property: #famixVariable).
	"Parameters may have 2 FAST entities: FASTProgramUnit>>#parameters and DeclarationStatement"
	(famixParameter property: #fastParameter) - (fastScalarVariable property: #famixParameter).

	(famixStatementFunction property: #fast) - (fastStatementFunction property: #famix).
	(famixFunction property: #fast) - (fastFunction property: #famix).
	(famixExternalFunction property: #fast) - (fastExternalStatement property: #famix).
	(famixInvocation property: #fast) - (fastCallStatement property: #famix)

]
