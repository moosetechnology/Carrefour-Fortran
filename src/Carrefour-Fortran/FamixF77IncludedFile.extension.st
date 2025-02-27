Extension { #name : 'FamixF77IncludedFile' }

{ #category : '*Carrefour-Fortran' }
FamixF77IncludedFile >> bindFastModel: fastModel [

	self flag: '#FIXME: how to deal with includedFile ? '.
	fastModel carrefourBinderVisitor 
		bindFastModel: fastModel
		toFamixEntity: self
]

{ #category : '*Carrefour-Fortran' }
FamixF77IncludedFile >> importFASTModel [
	| fortranCode tempModel |

	self assert: self sourceAnchor isNotNil.

	fortranCode := String streamContents:  [  :aStream | 
		FortranProjectImporter new 
			writeFakeEsopeProgramUnit: self name
			from: self sourceAnchor sourceText
			on: aStream
	].

	tempModel := self mooseModel fastImporter onSourceString: fortranCode.

	tempModel cleanupFakeIncludeSubroutine.

	^tempModel
]

{ #category : '*Carrefour-Fortran' }
FamixF77IncludedFile >> isIncludedFile [

	^ true
]
