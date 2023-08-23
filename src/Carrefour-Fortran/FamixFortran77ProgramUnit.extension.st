Extension { #name : #FamixFortran77ProgramUnit }

{ #category : #'*Carrefour-Fortran' }
FamixFortran77ProgramUnit >> getFASTModel [
	^FASTFortranCamfortImporter new
		getFASTFor: self sourceAnchor sourceText
]
