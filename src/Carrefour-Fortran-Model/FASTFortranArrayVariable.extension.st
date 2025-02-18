Extension { #name : 'FASTFortranArrayVariable' }

{ #category : '*Carrefour-Fortran-Model-accessing' }
FASTFortranArrayVariable >> famixVariable [
	"Relation named: #famixVariable type: #FamixTStructuralEntity opposite: #fastUses"

	<generated>
	<FMProperty: #famixVariable type: #FamixTStructuralEntity opposite: #fastUses>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #famixVariable ifAbsent: [ nil ]
]

{ #category : '*Carrefour-Fortran-Model-accessing' }
FASTFortranArrayVariable >> famixVariable: anObject [

	<generated>
	self attributeAt: #famixVariable put: (FMMultivalueLink on: self update: #fastUses from: self famixVariable to: anObject).
]
