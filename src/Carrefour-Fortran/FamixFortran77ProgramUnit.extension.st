Extension { #name : #FamixFortran77ProgramUnit }

{ #category : #'*Carrefour-Fortran' }
FamixFortran77ProgramUnit >> getFASTModel [
	^	FortranProjectImporter new
		getFASTFor: self sourceAnchor sourceText
]
