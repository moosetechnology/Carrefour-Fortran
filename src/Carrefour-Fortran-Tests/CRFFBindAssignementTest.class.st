Class {
	#name : 'CRFFBindAssignementTest',
	#superclass : 'CRFFAbstractBindTest',
	#category : 'Carrefour-Fortran-Tests',
	#package : 'Carrefour-Fortran-Tests'
}

{ #category : 'as yet unclassified' }
CRFFBindAssignementTest >> testVariableDeclarationReal [

	| entities fmx fast |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"./srcCodeOrigin.f"},"program_units":[{"anno":[],"arguments":null,"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:14)","statement":{"anno":[],"expression":{"anno":[],"span":"(2:11)-(2:14)","tag":"value","value":{"contents":[{"exponent":{"letter":"e","num":"0"},"significand":"12.5"},null],"tag":"real"}},"span":"(2:7)-(2:14)","tag":"assign_expression","target":{"anno":[],"span":"(2:7)-(2:7)","tag":"value","value":{"contents":"c","tag":"variable"}}},"tag":"statement"}],"name":"tester","options":[null,null],"span":"(1:7)-(3:9)","subprograms":null,"tag":"subroutine"}]}'
		forCode:
'      subroutine tester
      c = 12.5
      end
'.

	(famixModel entityNamed: 'tester') bindFastModel: fastModel.

	entities := famixModel allWithType: FamixF77Variable.

	self assert: entities size equals: 1.

	fmx := entities anyOne.
	fast := fmx fastAssignment.

	self assert: fast isNotEmpty.
	self assert: fast size equals: 1.
	self assert: fast anyOne class equals: FASTFortranAssignmentStatement.
	self assert: fast anyOne variable name equals: fmx name

]
