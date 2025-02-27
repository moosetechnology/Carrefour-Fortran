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
	| fortranCode tempModel includedFile fakeSubrtn |

	self assert: self sourceAnchor isNotNil.

	fortranCode := String streamContents:  [  :aStream | 
		FortranProjectImporter new 
			writeFakeEsopeProgramUnit: self name
			from: self sourceAnchor sourceText
			on: aStream
	].

	tempModel := self mooseModel fastImporter onSourceString: fortranCode.

	fakeSubrtn := (tempModel allWithType: FASTFortranSubroutine) first.
	includedFile := tempModel newIncludedFile.

	fakeSubrtn statementBlock statements copy do: [ :stmt | includedFile  addStatement: stmt ].
	fakeSubrtn declarations copy do: [ :decl | includedFile addDeclaration: decl ].

	fakeSubrtn statementBlock: nil.
	fakeSubrtn programFile: nil.

	tempModel remove: fakeSubrtn.

	^tempModel
]

{ #category : '*Carrefour-Fortran' }
FamixF77IncludedFile >> isIncludedFile [

	^ true
]
