Extension { #name : 'FamixF77IncludedFile' }

{ #category : '*Carrefour-Fortran' }
FamixF77IncludedFile >> importFASTModel [
	| fortranCode tempFastModel |

	self assert: self sourceAnchor isNotNil.

	fortranCode := String streamContents:  [  :aStream | 
		FortranProjectImporter new 
			writeFakeEsopeProgramUnit: self name
			from: self sourceAnchor sourceText
			on: aStream
	].

	tempFastModel := self mooseModel fastImporter onSourceString: fortranCode.

	tempFastModel cleanupFakeIncludeSubroutine.

	^tempFastModel
]

{ #category : '*Carrefour-Fortran' }
FamixF77IncludedFile >> isIncludedFile [

	^ true
]
