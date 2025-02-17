Class {
	#name : 'CRFFBindPUDeclarationTest',
	#superclass : 'CRFFAbstractBindTest',
	#category : 'Carrefour-Fortran-Tests',
	#package : 'Carrefour-Fortran-Tests'
}

{ #category : 'tests' }
CRFFBindPUDeclarationTest >> testPUExternalFunction [

	| entities fmx fast |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"./srcCode.f"},"program_units":[{"anno":[],"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:20)","statement":{"anno":[],"span":"(2:7)-(2:20)","tag":"external","vars":{"anno":[],"list":[{"anno":[],"span":"(2:16)-(2:20)","tag":"value","value":{"contents":"myfct","tag":"variable"}}],"span":"(2:16)-(2:20)"}},"tag":"statement"}],"name":"main","span":"(1:7)-(3:9)","subprograms":null,"tag":"main"}]}'
		forCode:
'      program main
      external myfct
      end
'.

	(famixModel entityNamed: 'main') bindFastModel: fastModel.

	entities := famixModel allWithType: FamixF77ExternalDeclaration.

	self assert: entities size equals: 1.
	fmx := entities anyOne.
	fast := fmx fast.

	self assert: fast isNotNil.
	self assert: fast class equals: FASTFortranExternalStatement.
	self assert: fast name equals: fmx name

]

{ #category : 'as yet unclassified' }
CRFFBindPUDeclarationTest >> testPUFunctionDeclaration [

	| entities fmx fast |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"./srcCodeOrigin.f"},"program_units":[{"anno":[],"arguments":null,"blocks":[],"name":"hello","result":null,"span":"(1:7)-(2:9)","subprograms":null,"tag":"function","type":{"anno":[],"base_type":"integer","selector":null,"span":"(1:7)-(1:13)"}}]}'
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

{ #category : 'as yet unclassified' }
CRFFBindPUDeclarationTest >> testPUMainDeclaration [

	| entities fmx fast |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"./srcCodeOrigin.f"},"program_units":[{"anno":[],"blocks":[],"name":"main","span":"(2:7)-(3:9)","subprograms":null,"tag":"main"}]}'
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

{ #category : 'as yet unclassified' }
CRFFBindPUDeclarationTest >> testPUSubroutineDeclaration [

	| entities fmx fast |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"./srcCodeOrigin.f"},"program_units":[{"anno":[],"arguments":null,"blocks":[],"name":"blah","options":[null,null],"span":"(1:7)-(2:9)","subprograms":null,"tag":"subroutine"}]}'
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
