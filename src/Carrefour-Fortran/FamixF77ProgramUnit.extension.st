Extension { #name : 'FamixF77ProgramUnit' }

{ #category : '*Carrefour-Fortran' }
FamixF77ProgramUnit >> bindFASTModel [
	| fastModel |
	self assert: self sourceAnchor isNotNil.

	fastModel := self importFASTModel
		metamodel: CRFFModel metamodel;
		yourself.

	self bindFastModel: fastModel.

	^ fastModel
]

{ #category : '*Carrefour-Fortran' }
FamixF77ProgramUnit >> bindFastModel: fastModel [
	CRFFortranProgramUnitBinderVisitor new
		bindFastModel: fastModel toFamixEntity: self
]

{ #category : '*Carrefour-Fortran' }
FamixF77ProgramUnit >> importFASTModel [

	self assert: self sourceAnchor isNotNil.

	^FASTFortranImporter onSourceString: self sourceAnchor sourceText

]

{ #category : '*Carrefour-Fortran' }
FamixF77ProgramUnit >> isIncludedFile [

	^false
]
