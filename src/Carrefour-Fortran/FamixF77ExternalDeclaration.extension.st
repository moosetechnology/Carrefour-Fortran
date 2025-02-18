Extension { #name : 'FamixF77ExternalDeclaration' }

{ #category : '*Carrefour-Fortran' }
FamixF77ExternalDeclaration >> fastDeclaration: anObject [
	"because of the lack of this message for famixExternalDeclaration
	used here 'CRFFortranProgramUnitBinderVisitor >> visitFASTFortranVariableDeclarationStatement:'
	"
	self fast: anObject
]
