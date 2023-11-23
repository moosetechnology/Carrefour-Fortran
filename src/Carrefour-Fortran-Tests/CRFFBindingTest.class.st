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
CRFFBindingTest >> createFASTModel: jsonSource fromFortranSource: fortranCode [

	| visitor |
	visitor := FASTFortranJsonVisitor new.
	visitor initLineSizes: fortranCode.
	visitor visitProgramFile: (NeoJSONReader fromString: jsonSource).
	fastModel := visitor model
]

{ #category : #running }
CRFFBindingTest >> createFamixModel: jsonSource [

	| iastModel visitor |
	iastModel := JsonToIASTVisitor new
		visitProgramFile: (NeoJSONReader fromString: jsonSource).

	visitor := IASTToFamixFortranVisitor new.
	iastModel accept: visitor.
	famixModel := visitor model.

	(FamixFortran77Resolver on: famixModel)
		resolve.

	^famixModel
]

{ #category : #running }
CRFFBindingTest >> createModels: jsonSource forCode: fortranCode [
	"Ugly to have to pass both fortran AND json code
	 But avoids having to call external parser"

	self createFamixModel: jsonSource.
	self createFASTModel: jsonSource fromFortranSource: fortranCode.
]

{ #category : #tests }
CRFFBindingTest >> testEmptyFunctionWithArguments [

	| entities |
	self
		createModels:
		'{"meta":{"miVersion":"fortran77","miFilename":"./fortran77.f"},"program_units":[{"anno":[],"arguments":{"anno":[],"list":[{"anno":[],"span":"(1:30)-(1:30)","tag":"value","value":{"contents":"i","tag":"variable"}},{"anno":[],"span":"(1:32)-(1:32)","tag":"value","value":{"contents":"j","tag":"variable"}}],"span":"(1:30)-(1:32)"},"blocks":[],"name":"hello","result":null,"span":"(1:7)-(2:9)","subprograms":null,"tag":"function","type":{"anno":[],"base_type":"integer","selector":null,"span":"(1:7)-(1:13)"}}]}'
		forCode: '      integer function hello(i,j)
      end
'.

	(famixModel entityNamed: 'hello') bindFastModel: fastModel.

	entities := famixModel allWithType: FamixF77Parameter.
	self assert: entities size equals: 2.
	entities do: [ :fmx |
		self assert: fmx fastParameter class equals: FASTFortranScalarVariable.
		self assert: fmx fastParameter name equals: fmx name ]
]

{ #category : #tests }
CRFFBindingTest >> testEmptyFunctionWithDeclaredArguments [

	| entities |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"FastTmp/fortran77.f"},"program_units":[{"anno":[],"arguments":{"anno":[],"list":[{"anno":[],"span":"(1:30)-(1:33)","tag":"value","value":{"contents":"name","tag":"variable"}},{"anno":[],"span":"(1:35)-(1:37)","tag":"value","value":{"contents":"age","tag":"variable"}}],"span":"(1:30)-(1:37)"},"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:23)","statement":{"anno":[],"attributes":null,"declarators":{"anno":[],"list":[{"anno":[],"initial":null,"length":null,"span":"(2:20)-(2:23)","type":"scalar","variable":{"anno":[],"span":"(2:20)-(2:23)","tag":"value","value":{"contents":"name","tag":"variable"}}}],"span":"(2:20)-(2:23)"},"span":"(2:7)-(2:23)","tag":"declaration","type":{"anno":[],"base_type":"character","selector":{"anno":[],"kind":null,"length":{"anno":[],"span":"(2:17)-(2:18)","tag":"value","value":{"contents":["50",null],"tag":"integer"}},"span":"(2:16)-(2:18)"},"span":"(2:7)-(2:18)"}},"tag":"statement"},{"anno":[],"label":null,"span":"(3:7)-(3:17)","statement":{"anno":[],"attributes":null,"declarators":{"anno":[],"list":[{"anno":[],"initial":null,"length":null,"span":"(3:15)-(3:17)","type":"scalar","variable":{"anno":[],"span":"(3:15)-(3:17)","tag":"value","value":{"contents":"age","tag":"variable"}}}],"span":"(3:15)-(3:17)"},"span":"(3:7)-(3:17)","tag":"declaration","type":{"anno":[],"base_type":"integer","selector":null,"span":"(3:7)-(3:13)"}},"tag":"statement"}],"name":"hello","result":null,"span":"(1:7)-(4:9)","subprograms":null,"tag":"function","type":{"anno":[],"base_type":"integer","selector":null,"span":"(1:7)-(1:13)"}}]}'
		forCode:
'      integer function hello(name,age)
      character*50 name
      integer age
      end
'.

	(famixModel entityNamed: 'hello') bindFastModel: fastModel.

	entities := (fastModel allWithType: FASTFortranScalarVariable).
	self assert: entities size equals: 2.
	entities do: [ :fast || famix |
		famix := fast famixParameter.

		self assert: famix isNotNil.
		self assert: famix class equals: FamixF77Parameter.
		self assert: famix name equals: fast name
	].

	entities := (fastModel allWithType: FASTFortranVariableDeclarator).
	self assert: entities size equals: 2.
	entities do: [ :fast || famix |
		famix := fast famixDeclaration.

		self assert: famix isNotNil.
		self assert: famix class equals: FamixF77Parameter.
		self assert: famix name equals: fast variable
	].


]

{ #category : #tests }
CRFFBindingTest >> testVariableDeclarationReal [

	| entities |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"./fortran77.f"},"program_units":[{"anno":[],"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:12)","statement":{"anno":[],"attributes":null,"declarators":{"anno":[],"list":[{"anno":[],"initial":null,"length":null,"span":"(2:12)-(2:12)","type":"scalar","variable":{"anno":[],"span":"(2:12)-(2:12)","tag":"value","value":{"contents":"c","tag":"variable"}}}],"span":"(2:12)-(2:12)"},"span":"(2:7)-(2:12)","tag":"declaration","type":{"anno":[],"base_type":"real","selector":null,"span":"(2:7)-(2:10)"}},"tag":"statement"}],"name":"main","span":"(1:7)-(3:9)","subprograms":null,"tag":"main"}]}'
		forCode:
'      program main
      real c
      end
'.

	(famixModel entityNamed: 'main') bindFastModel: fastModel.

	entities := famixModel allWithType: FamixF77Variable.

	self assert: entities size equals: 1.
	entities do: [ :fmx |
		self assert: fmx fastDeclaration class equals: FASTFortranVariableDeclarator.
		self assert: fmx fastDeclaration variable equals: fmx name
	].


]
