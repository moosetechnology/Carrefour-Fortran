Extension { #name : 'FamixF77IncludedFile' }

{ #category : '*Carrefour-Fortran' }
FamixF77IncludedFile >> bindFastModel: fastModel [
	self flag: '#FIXME: how to deal with includedFile ? '
	
]

{ #category : '*Carrefour-Fortran' }
FamixF77IncludedFile >> importFASTModel [
	| fortranCode tempModel |

	self flag: '#FIXME: Do we need to ask for fast model in case of includedFile?'.
	self assert: self sourceAnchor isNotNil.

	sourceAnchor endLine: sourceAnchor endLine + 1.

	fortranCode := String streamContents:  [  :aStream | 
		FortranProjectImporter new 
			writeFakeEsopeProgramUnit: self name
			from: self sourceAnchor sourceText
			on: aStream
	].
	
	tempModel := FASTFortranImporter onSourceString: fortranCode.

	"We do not want a fake subroutine in the model, it is just for convenience for the parser to do its job."
	tempModel remove: (tempModel allWithType: FASTFortranSubroutine) first.

	^tempModel
]

{ #category : '*Carrefour-Fortran' }
FamixF77IncludedFile >> isIncludedFile [

	^ true
]
