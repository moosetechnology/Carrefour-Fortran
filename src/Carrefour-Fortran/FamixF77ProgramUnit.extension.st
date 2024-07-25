Extension { #name : 'FamixF77ProgramUnit' }

{ #category : '*Carrefour-Fortran' }
FamixF77ProgramUnit >> bindFASTModel [
	| fastModel |
	self assert: self sourceAnchor isNotNil.
	fastModel := self importFASTModel
		metamodel: CRFFModel metamodel;
		yourself.
	self bindFastModel: fastModel .
	^ fastModel
]

{ #category : '*Carrefour-Fortran' }
FamixF77ProgramUnit >> bindFastModel: fastModel [
	self carrefourBinder
		bindFastModel: fastModel toFamixEntity: self
]

{ #category : '*Carrefour-Fortran' }
FamixF77ProgramUnit >> carrefourASTGenerator [
	^FortranProjectImporter defaultInstance
]

{ #category : '*Carrefour-Fortran' }
FamixF77ProgramUnit >> carrefourBinder [
	^CRFFortranProgramUnitBinderVisitor new
]

{ #category : '*Carrefour-Fortran' }
FamixF77ProgramUnit >> importFASTModel [
	| fastRootNode |
	self assert: self sourceAnchor isNotNil.

	fastRootNode := (self carrefourASTGenerator
		getFASTFor: self sourceAnchor sourceText)
		first.

	self fast: fastRootNode.
	^fastRootNode mooseModel
]
