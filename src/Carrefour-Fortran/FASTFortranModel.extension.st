Extension { #name : 'FASTFortranModel' }

{ #category : '*Carrefour-Fortran' }
FASTFortranModel >> carrefourBinderCleaner [

	^ CRFFBindingCleaner new
]

{ #category : '*Carrefour-Fortran' }
FASTFortranModel >> carrefourBinderVisitor [

	^ CRFFortranProgramUnitBinderVisitor new
]

{ #category : '*Carrefour-Fortran' }
FASTFortranModel >> cleanupFakeIncludeSubroutine [

	| fakeSubrtn includedFile |
	fakeSubrtn := (self allWithType: FASTFortranSubroutine) first.
	includedFile := self newIncludedFile.

	includedFile name: fakeSubrtn name.
	includedFile statementBlock: fakeSubrtn statementBlock.
	fakeSubrtn declarations copy do: [ :decl | includedFile addDeclaration: decl ].

	fakeSubrtn statementBlock: nil.
	fakeSubrtn programFile: nil.

	self remove: fakeSubrtn.

]

{ #category : '*Carrefour-Fortran' }
FASTFortranModel >> setMetamodelToCarrefour [

	self metamodel: CRFFModel metamodel
]
