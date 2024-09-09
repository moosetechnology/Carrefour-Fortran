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

{ #category : 'tests' }
CRFFBindPUDeclarationTest >> testPUMainDeclaration [

	| entities fmx fast |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"/home/anquetil/Pharo/images/crf-fortran/srcCode.f"},"program_units":[{"anno":[],"blocks":[],"name":"main","span":"(2:7)-(3:9)","subprograms":null,"tag":"main"}]}'
		forCode:
'      program main
      end
'.

	(famixModel entityNamed: 'main') bindFastModel: fastModel.

	entities := famixModel allWithType: FamixF77PUMain.

	self assert: entities size equals: 1.
	fmx := entities anyOne.
	fast := fmx fast.

	self assert: fast isNotNil.
	self assert: fast class equals: FASTFortranProgramMain.
	self assert: fast name equals: fmx name

]

{ #category : 'tests' }
CRFFBindPUDeclarationTest >> testPUSubroutineDeclaration [

	| entities fmx fast |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"/home/anquetil/Pharo/images/crf-fortran/srcCode.f"},"program_units":[{"anno":[],"arguments":null,"blocks":[],"name":"blah","options":[null,null],"span":"(1:7)-(2:9)","subprograms":null,"tag":"subroutine"}]}'
		forCode:
'      subroutine blah
      end
'.

	(famixModel entityNamed: 'blah') bindFastModel: fastModel.

	entities := famixModel allWithType: FamixF77PUSubroutine.

	self assert: entities size equals: 1.
	fmx := entities anyOne.
	fast := fmx fast.

	self assert: fast isNotNil.
	self assert: fast class equals: FASTFortranSubroutine.
	self assert: fast name equals: fmx name

]
