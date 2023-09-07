Class {
	#name : #CRFFBindingTest,
	#superclass : #TestCase,
	#instVars : [
		'famixModel',
		'fastModel'
	],
	#category : #'Carrefour-Fortran-Tests'
}

{ #category : #running }
CRFFBindingTest >> createFASTModel: jsonSource [

	| visitor |
	visitor := FASTFortranJsonVisitor new.

	visitor visitProgramFile:
		(NeoJSONReader fromString: jsonSource).
	fastModel := visitor model
]

{ #category : #running }
CRFFBindingTest >> createFamixModel: jsonSource [

	| iastModel visitor |
	iastModel := JsonToIASTVisitor new
		visitProgramFile: (NeoJSONReader fromString: jsonSource).

	visitor := IASTToFortranVisitor new.
	iastModel accept: visitor.
	^famixModel := visitor model
]

{ #category : #running }
CRFFBindingTest >> createModels: jsonSource [
	
	self createFamixModel: jsonSource.
	self createFASTModel: jsonSource.
]

{ #category : #running }
CRFFBindingTest >> createModels: jsonSource forCode: fortranCode [
	"Ugly to have to pass both fortran AND json code
	 But avoids having to call external parser"

	'./fortran77.f' asFileReference writeStreamDo: [ :st | st << fortranCode ].

	self createFamixModel: jsonSource.
	self createFASTModel: jsonSource.
]

{ #category : #tests }
CRFFBindingTest >> testEmptyFunctionWithArguments [

	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"./fortran77.f"},"program_units":[{"anno":[],"arguments":{"anno":[],"list":[{"anno":[],"span":"(1:30)-(1:30)","tag":"value","value":{"contents":"i","tag":"variable"}},{"anno":[],"span":"(1:32)-(1:32)","tag":"value","value":{"contents":"j","tag":"variable"}}],"span":"(1:30)-(1:32)"},"blocks":[],"name":"hello","result":null,"span":"(1:7)-(2:9)","subprograms":null,"tag":"function","type":{"anno":[],"base_type":"integer","selector":null,"span":"(1:7)-(1:13)"}}]}'
		forCode:
'      integer function hello(i,j)
      end
'.

	(famixModel entityNamed: 'hello') bindFastModel: fastModel.

	self assert: (famixModel allWithType: FamixFortran77Parameter) size equals: 2.
	(famixModel allWithType: FamixFortran77Parameter) do: [ :fmx |
		self assert: fmx fast class equals: FASTFortranScalarVariable.
		self assert: fmx name equals: fmx fast name
	].


]
