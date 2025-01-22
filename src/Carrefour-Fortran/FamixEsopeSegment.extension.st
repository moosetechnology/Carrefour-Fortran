Extension { #name : 'FamixEsopeSegment' }

{ #category : '*Carrefour-Fortran' }
FamixEsopeSegment >> bindFASTModel [

	| fastModel |
	self assert: self sourceAnchor isNotNil.

	fastModel := self importFASTModel
		             metamodel: CRFFModel metamodel;
		             yourself.

	self bindFastModel: fastModel.

	^ fastModel
]

{ #category : '*Carrefour-Fortran' }
FamixEsopeSegment >> bindFastModel: fastModel [

	CRFEsopeBinderVisitor new
		bindFastModel: fastModel
		toFamixEntity: self
]

{ #category : '*Carrefour-Fortran' }
FamixEsopeSegment >> importFASTModel [

	| fortranCode tempModel segmentSource |
	self assert: self sourceAnchor isNotNil.
	
	segmentSource := 'c@_   ', self sourceAnchor sourceText.

	fortranCode := String streamContents:  [  :aStream | 
		FortranProjectImporter new 
			writeFakeEsopeProgramUnit: 'fakesubroutine' 
			from: segmentSource
			on: aStream
	].

	tempModel := FASTFortranImporter onSourceString: fortranCode.

	tempModel remove: (tempModel allWithType: FASTFortranSubroutine) first.
	
	^tempModel

]
