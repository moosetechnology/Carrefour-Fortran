Extension { #name : 'FamixF77ProgramUnit' }

{ #category : '*Carrefour-Fortran' }
FamixF77ProgramUnit >> bindFASTModel [
	| fastModel |
	self assert: self sourceAnchor isNotNil.

	fastModel := self importFASTModel
		setMetamodelToCarrefour ;
		yourself.

	self bindFastModel: fastModel.

	^ fastModel
]

{ #category : '*Carrefour-Fortran' }
FamixF77ProgramUnit >> bindFastModel: fastModel [

	fastModel carrefourBinderVisitor
		bindFastModel: fastModel
		toFamixEntity: self
]

{ #category : '*Carrefour-Fortran' }
FamixF77ProgramUnit >> importFASTModel [

	self assert: self sourceAnchor isNotNil.

	^self mooseModel fastImporter onSourceString: self sourceAnchor sourceText

]

{ #category : '*Carrefour-Fortran' }
FamixF77ProgramUnit >> isIncludedFile [

	^false
]
