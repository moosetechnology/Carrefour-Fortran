Class {
	#name : 'CRFFBindVariableDeclarationTest',
	#superclass : 'CRFFAbstractBindTest',
	#category : 'Carrefour-Fortran-Tests',
	#package : 'Carrefour-Fortran-Tests'
}

{ #category : 'tests' }
CRFFBindVariableDeclarationTest >> testVariableDeclarationReal [

	| entities fmx fast |
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
	fmx := entities anyOne.
	fast := fmx fastDeclaration.

	self assert: fast isNotNil.
	self assert: fast class equals: FASTFortranVariableDeclarator.
	self assert: fast name equals: fmx name

]
