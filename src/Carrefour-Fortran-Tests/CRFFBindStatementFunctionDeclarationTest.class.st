Class {
	#name : 'CRFFBindStatementFunctionDeclarationTest',
	#superclass : 'CRFFAbstractBindTest',
	#category : 'Carrefour-Fortran-Tests',
	#package : 'Carrefour-Fortran-Tests'
}

{ #category : 'tests' }
CRFFBindStatementFunctionDeclarationTest >> testStatementFunction [

	| entities fmx fast |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"/home/anquetil/Pharo/images/crf-fortran/srcCode.f"},"program_units":[{"anno":[],"arguments":null,"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:16)","statement":{"anno":[],"arguments":{"anno":[],"list":[{"anno":[],"span":"(2:9)-(2:9)","tag":"value","value":{"contents":"x","tag":"variable"}}],"span":"(2:9)-(2:9)"},"body":{"anno":[],"left":{"anno":[],"span":"(2:14)-(2:14)","tag":"value","value":{"contents":["2",null],"tag":"integer"}},"op":{"tag":"multiplication"},"right":{"anno":[],"span":"(2:16)-(2:16)","tag":"value","value":{"contents":"x","tag":"variable"}},"span":"(2:14)-(2:16)","tag":"binary"},"name":{"anno":[],"span":"(2:7)-(2:7)","tag":"value","value":{"contents":"f","tag":"variable"}},"span":"(2:7)-(2:16)","tag":"function"},"tag":"statement"}],"name":"hello","result":null,"span":"(1:7)-(3:9)","subprograms":null,"tag":"function","type":{"anno":[],"base_type":"integer","selector":null,"span":"(1:7)-(1:13)"}}]}'
		forCode:
'      integer function hello()
      f(x) = 2*x
      end
'.

	(famixModel entityNamed: 'hello') bindFastModel: fastModel.

	entities := famixModel allWithType: FamixF77StatementFunction.

	self assert: entities size equals: 1.
	fmx := entities anyOne.
	fast := fmx fast.

	self assert: fast isNotNil.
	self assert: fast class equals: FASTFortranFunctionStatement.
	self assert: fast name equals: fmx name

]
