Class {
	#name : #CRFFortranMetamodelGenerator,
	#superclass : #FamixMetamodelGenerator,
	#instVars : [
		'famixProgramUnit',
		'fastProgramUnit'
	],
	#category : #'Carrefour-Fortran-Model-Generator'
}

{ #category : #accessing }
CRFFortranMetamodelGenerator class >> packageName [
	<ignoreForCoverage>
	^ 'Carrefour-Fortran-Model'
]

{ #category : #accessing }
CRFFortranMetamodelGenerator class >> prefix [
	<ignoreForCoverage>
	^ #CRFFortran
]

{ #category : #accessing }
CRFFortranMetamodelGenerator class >> submetamodels [
	^ {FASTMetamodelGenerator.
	FASTFortranGenerator.
	FamixFortran77Generator.
	FamixGenerator }
]

{ #category : #definition }
CRFFortranMetamodelGenerator >> defineClasses [
	super defineClasses.
	famixProgramUnit := self remoteEntity: #ProgramUnit withPrefix: #FamixFortran77.

	fastProgramUnit := self remoteEntity: #ProgramUnit withPrefix: #FASTFortran.
]

{ #category : #definition }
CRFFortranMetamodelGenerator >> defineHierarchy [
	super defineHierarchy
]

{ #category : #definition }
CRFFortranMetamodelGenerator >> defineRelations [
	super defineRelations.
	(famixProgramUnit property: #fast) - (fastProgramUnit property: #famixPU).
]
