Extension { #name : #FASTFortranDeclarationStatement }

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FASTFortranDeclarationStatement >> famixVariable [
	"Relation named: #famixVariable type: #FamixTStructuralEntity opposite: #fastDeclaration"

	<generated>
	<FMProperty: #famixVariable type: #FamixTStructuralEntity opposite: #fastDeclaration>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #famixVariable ifAbsent: [ nil ]
]

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FASTFortranDeclarationStatement >> famixVariable: anObject [

	<generated>
	self attributeAt: #famixVariable put: (FMMultivalueLink on: self update: #fastDeclaration from: self famixVariable to: anObject).
]
