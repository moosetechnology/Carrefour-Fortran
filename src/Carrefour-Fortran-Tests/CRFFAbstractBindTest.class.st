Class {
	#name : 'CRFFAbstractBindTest',
	#superclass : 'TestCase',
	#instVars : [
		'famixModel',
		'fastModel'
	],
	#category : 'Carrefour-Fortran-Tests',
	#package : 'Carrefour-Fortran-Tests'
}

{ #category : 'running' }
CRFFAbstractBindTest >> createFASTModel: jsonSource fromFortranSource: fortranCode [

	| visitor |
	visitor := self jsonImporterClass new.
	visitor initLineSizes: fortranCode.
	visitor visitProgramFile: (NeoJSONReader fromString: jsonSource).
	fastModel := visitor model
]

{ #category : 'running' }
CRFFAbstractBindTest >> createFamixModel: jsonSource [

	| iastModel visitor |
	iastModel := JsonToIASTVisitor new
		visitProgramFile: (NeoJSONReader fromString: jsonSource).

	visitor := IASTToFamixFortranVisitor new model: famixModel.
	iastModel accept: visitor.

	(FamixEsopeResolver on: famixModel)
		resolve.
]

{ #category : 'running' }
CRFFAbstractBindTest >> createModels: jsonSource forCode: fortranCode [
	"Not nice to have to give both fortran and json code
	 but avoids having to call external parser"

	self createFamixModel: jsonSource.
	self createFASTModel: jsonSource fromFortranSource: fortranCode.
]

{ #category : 'running' }
CRFFAbstractBindTest >> jsonImporterClass [

	^FASTFortranJsonVisitor
]

{ #category : 'running' }
CRFFAbstractBindTest >> newFamixModel [

	^ FamixF77Model new
]

{ #category : 'running' }
CRFFAbstractBindTest >> setUp [
	super setUp.

	famixModel := self newFamixModel.
	famixModel rootFolder: '.'
]
