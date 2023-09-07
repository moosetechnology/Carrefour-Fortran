Extension { #name : #FamixFortran77ProgramUnit }

{ #category : #'*Carrefour-Fortran' }
FamixFortran77ProgramUnit >> bindFASTModel [
	| fastModel |
	self assert: self sourceAnchor isNotNil.
	fastModel := self importFASTModel
		metamodel: CRFFModel metamodel;
		yourself.
	self bindFastModel: fastModel .
	^ fastModel
]

{ #category : #'*Carrefour-Fortran' }
FamixFortran77ProgramUnit >> bindFastModel: fastModel [
	self carrefourBinder
		bindFastModel: fastModel toFamixEntity: self
]

{ #category : #'*Carrefour-Fortran' }
FamixFortran77ProgramUnit >> carrefourBinder [
	^CRFFortranProgramUnitBinderVisitor new
]

{ #category : #'*Carrefour-Fortran' }
FamixFortran77ProgramUnit >> importFASTModel [
	| fastModel |
	self assert: self sourceAnchor isNotNil.

	fastModel := (FortranProjectImporter new
		getFASTFor: self sourceAnchor sourceText)
		first.

	self fast: fastModel.
	^fastModel 
]
