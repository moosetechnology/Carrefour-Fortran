Class {
	#name : 'CRFFBindParameterTest',
	#superclass : 'CRFFAbstractBindTest',
	#category : 'Carrefour-Fortran-Tests',
	#package : 'Carrefour-Fortran-Tests'
}

{ #category : 'tests' }
CRFFBindParameterTest >> testEmptyFunctionWithDeclaredParameters [

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
		self assert: famix name equals: fast name
	].


]

{ #category : 'tests' }
CRFFBindParameterTest >> testEmptyFunctionWithParameters [

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
	entities do: [ :fmx || fast |
		fast := fmx fastParameter.

		self assert: fast isNotNil.
		self assert: fast class equals: FASTFortranScalarVariable.
		self assert: fast name equals: fmx name
	]
]
