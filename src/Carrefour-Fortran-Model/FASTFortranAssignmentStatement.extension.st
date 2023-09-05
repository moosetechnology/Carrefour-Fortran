Extension { #name : #FASTFortranAssignmentStatement }

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FASTFortranAssignmentStatement >> famixVariable [
	"Relation named: #famixVariable type: #FamixTStructuralEntity opposite: #fastAssignment"

	<generated>
	<FMProperty: #famixVariable type: #FamixTStructuralEntity opposite: #fastAssignment>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #famixVariable ifAbsent: [ nil ]
]

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FASTFortranAssignmentStatement >> famixVariable: anObject [

	<generated>
	self attributeAt: #famixVariable put: (FMMultivalueLink on: self update: #fastAssignment from: self famixVariable to: anObject).
]
