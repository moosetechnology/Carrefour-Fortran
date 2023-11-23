Class {
	#name : #CRFFMetamodelGenerator,
	#superclass : #FamixMetamodelGenerator,
	#instVars : [
		'famixProgramUnit',
		'fastProgramUnit',
		'fastAssignment',
		'fastScalarVariable',
		'famixStructuralEntity',
		'famixParameter',
		'fastVariableDeclarator'
	],
	#category : #'Carrefour-Fortran-Model-Generator'
}

{ #category : #accessing }
CRFFMetamodelGenerator class >> packageName [
	<ignoreForCoverage>
	^ 'Carrefour-Fortran-Model'
]

{ #category : #accessing }
CRFFMetamodelGenerator class >> prefix [
	<ignoreForCoverage>
	^ #CRFF
]

{ #category : #accessing }
CRFFMetamodelGenerator class >> submetamodels [
	^ {FASTMetamodelGenerator.
	FASTFortranGenerator.
	FamixFortran77Generator.
	FamixGenerator }
]

{ #category : #definition }
CRFFMetamodelGenerator >> defineClasses [
	super defineClasses.
	famixProgramUnit := self remoteEntity: #ProgramUnit withPrefix: #FamixF77.
	fastProgramUnit := self remoteEntity: #Entity withPrefix: #FASTFortran.

	famixStructuralEntity := self remoteTrait: #TStructuralEntity withPrefix: #Famix.
	famixParameter := self remoteTrait: #TParameter withPrefix: #Famix.
	fastScalarVariable := self remoteEntity: #ScalarVariable withPrefix: #FASTFortran.
	fastVariableDeclarator := self remoteEntity: #VariableDeclarator withPrefix: #FASTFortran.

	fastAssignment := self remoteEntity: #AssignmentStatement withPrefix: #FASTFortran.

]

{ #category : #definition }
CRFFMetamodelGenerator >> defineRelations [
	super defineRelations.
	(famixProgramUnit property: #fast) - (fastProgramUnit property: #famix).

	(famixStructuralEntity property: #fastDeclaration) - (fastVariableDeclarator property: #famixDeclaration).
	"Parameters appear in FASTProgramUnit >> #parameters and in DeclarationStatement"
	(famixParameter property: #fastParameter) - (fastScalarVariable property: #famixParameter).
	(famixStructuralEntity property: #fastAssignment) -* (fastAssignment property: #famixVariable).

]
