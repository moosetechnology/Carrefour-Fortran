Class {
	#name : 'CRFFBindPUDeclarationTest',
	#superclass : 'CRFFAbstractBindTest',
	#category : 'Carrefour-Fortran-Tests',
	#package : 'Carrefour-Fortran-Tests'
}

{ #category : 'tests' }
CRFFBindPUDeclarationTest >> testPUFunctionDeclaration [

	| entities fmx fast |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"/home/anquetil/Pharo/images/crf-fortran/srcCode.f"},"program_units":[{"anno":[],"arguments":null,"blocks":[],"name":"hello","result":null,"span":"(1:7)-(2:9)","subprograms":null,"tag":"function","type":{"anno":[],"base_type":"integer","selector":null,"span":"(1:7)-(1:13)"}}]}'
		forCode:
'      integer function hello()
      end
'.

	(famixModel entityNamed: 'hello') bindFastModel: fastModel.

	entities := famixModel allWithType: FamixF77PUFunction.

	self assert: entities size equals: 1.
	fmx := entities anyOne.
	fast := fmx fast.

	self assert: fast isNotNil.
	self assert: fast class equals: FASTFortranFunction.
	self assert: fast name equals: fmx name

]
