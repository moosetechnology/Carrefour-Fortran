Class {
	#name : #CRFFMetamodelGenerator,
	#superclass : #FamixMetamodelGenerator,
	#instVars : [
		'famixProgramUnit',
		'fastProgramUnit',
		'famixStructuralEntity',
		'fastVariableExpression',
		'fastVariableDeclaration',
		'fastAssignment'
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
	famixProgramUnit := self remoteEntity: #ProgramUnit withPrefix: #FamixFortran77.
	fastProgramUnit := self remoteEntity: #Entity withPrefix: #FASTFortran.

	famixStructuralEntity := self remoteTrait: #TStructuralEntity withPrefix: #'Famix'.
	fastVariableDeclaration := self remoteEntity: #DeclarationStatement withPrefix: #FASTFortran.
	fastVariableExpression := self remoteEntity: #ScalarVariable withPrefix: #FASTFortran.
	fastAssignment := self remoteEntity: #AssignmentStatement withPrefix: #FASTFortran.

]

{ #category : #definition }
CRFFMetamodelGenerator >> defineRelations [
	super defineRelations.
	(famixProgramUnit property: #fast) - (fastProgramUnit property: #famix).

	(famixStructuralEntity property: #fastAssignment) -* (fastAssignment property: #famixVariable).
	(famixStructuralEntity property: #fastDeclaration) -* (fastVariableDeclaration property: #famixVariable).
	
	(famixStructuralEntity property: #fastAccesses) -* (fastVariableExpression property: #famixVariable).

]
