Class {
	#name : 'CRFFBindCallStatementTest',
	#superclass : 'CRFFAbstractBindTest',
	#category : 'Carrefour-Fortran-Tests',
	#package : 'Carrefour-Fortran-Tests'
}

{ #category : 'tests' }
CRFFBindCallStatementTest >> testCallUnknownSubroutine [

	| entities fmx fast |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"/home/anquetil/Pharo/images/crf-fortran/srcCode.f"},"program_units":[{"anno":[],"blocks":[{"anno":[],"label":null,"span":"(3:7)-(3:17)","statement":{"anno":[],"arguments":{"anno":[],"list":[],"span":"(3:16)-(3:17)"},"function":{"anno":[],"span":"(3:12)-(3:15)","tag":"value","value":{"contents":"blah","tag":"variable"}},"span":"(3:7)-(3:17)","tag":"call"},"tag":"statement"}],"name":"main","span":"(2:7)-(4:9)","subprograms":null,"tag":"main"}]}'
		forCode:
'      program main
      call blah()
      end
'.

	(famixModel entityNamed: 'main') bindFastModel: fastModel.


	entities := famixModel allWithType: FamixF77Invocation.

	self assert: entities size equals: 1.
	fmx := entities anyOne.
	fast := fmx fast.

	self assert: fast isNotNil.
	self assert: fast class equals: FASTFortranCallStatement.
	self assert: fast name equals: fmx signature

]
