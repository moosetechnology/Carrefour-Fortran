Extension { #name : #FASTFortranScalarVariable }

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FASTFortranScalarVariable >> famixVariable [
	"Relation named: #famixVariable type: #FamixTStructuralEntity opposite: #fastAccesses"

	<generated>
	<FMProperty: #famixVariable type: #FamixTStructuralEntity opposite: #fastAccesses>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #famixVariable ifAbsent: [ nil ]
]

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FASTFortranScalarVariable >> famixVariable: anObject [

	<generated>
	self attributeAt: #famixVariable put: (FMMultivalueLink on: self update: #fastAccesses from: self famixVariable to: anObject).
]
