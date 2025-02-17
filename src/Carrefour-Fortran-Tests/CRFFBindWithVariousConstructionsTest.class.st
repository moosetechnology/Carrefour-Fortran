Class {
	#name : 'CRFFBindWithVariousConstructionsTest',
	#superclass : 'CRFFAbstractBindTest',
	#category : 'Carrefour-Fortran-Tests',
	#package : 'Carrefour-Fortran-Tests'
}

{ #category : 'as yet unclassified' }
CRFFBindWithVariousConstructionsTest >> testExternalStatement [

	| entities fmx |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"./srcCodeOrigin.f"},"program_units":[{"anno":[],"arguments":null,"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:18)","statement":{"anno":[],"span":"(2:7)-(2:18)","tag":"external","vars":{"anno":[],"list":[{"anno":[],"span":"(2:16)-(2:18)","tag":"value","value":{"contents":"fct","tag":"variable"}}],"span":"(2:16)-(2:18)"}},"tag":"statement"}],"name":"blah","options":[null,null],"span":"(1:7)-(3:9)","subprograms":null,"tag":"subroutine"}]}'
		forCode:
'      subroutine blah
      EXTERNAL fct
      end
'.

	(famixModel entityNamed: 'blah') bindFastModel: fastModel.

	entities := famixModel allWithType: FamixF77PUSubroutine.

	self assert: entities size equals: 1.
	fmx := entities anyOne.

	self assert: fmx fast isNotNil.
]
