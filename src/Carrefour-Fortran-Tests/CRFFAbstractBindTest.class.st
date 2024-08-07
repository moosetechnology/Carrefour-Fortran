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
CRFFAbstractBindTest >> createFASTModel: jsonSource [

	| visitor |
	visitor := FASTFortranJsonVisitor new.

	visitor visitProgramFile: (NeoJSONReader fromString: jsonSource).
	fastModel := visitor model
]

{ #category : 'running' }
CRFFAbstractBindTest >> createFASTModel: jsonSource fromFortranSource: fortranCode [

	| visitor |
	visitor := FASTFortranJsonVisitor new.
	visitor initLineSizes: fortranCode.
	visitor visitProgramFile: (NeoJSONReader fromString: jsonSource).
	fastModel := visitor model
]

{ #category : 'running' }
CRFFAbstractBindTest >> createFamixModel: jsonSource [

	| iastModel visitor |
	iastModel := JsonToIASTVisitor new
		visitProgramFile: (NeoJSONReader fromString: jsonSource).

	visitor := IASTToFamixFortranVisitor new.
	iastModel accept: visitor.
	famixModel := visitor model.

	(FamixEsopeResolver on: famixModel)
		resolve.

	^famixModel
]

{ #category : 'running' }
CRFFAbstractBindTest >> createModels: jsonSource forCode: fortranCode [
	"Not nice to have to give both fortran and json code
	 but avoids having to call external parser"

	self createFamixModel: jsonSource.
	self createFASTModel: jsonSource fromFortranSource: fortranCode.
]
