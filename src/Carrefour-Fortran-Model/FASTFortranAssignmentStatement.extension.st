Extension { #name : 'FASTFortranAssignmentStatement' }

{ #category : '*Carrefour-Fortran-Model-accessing' }
FASTFortranAssignmentStatement >> famix [
	"Relation named: #famix type: #FamixF77Access opposite: #fast"

	<generated>
	<derived>
	<FMProperty: #famix type: #FamixF77Access opposite: #fast>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #famix ifAbsent: [ nil ]
]

{ #category : '*Carrefour-Fortran-Model-accessing' }
FASTFortranAssignmentStatement >> famix: anObject [

	<generated>
	(self attributeAt: #famix ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self famix.
		self attributeAt: #famix put: anObject.
		otherSide fast: nil ]
	ifNotNil: [ 
		self attributeAt: #famix put: anObject.
		anObject fast: self ]
]

{ #category : '*Carrefour-Fortran-Model-accessing' }
FASTFortranAssignmentStatement >> famixVariable [
	"Relation named: #famixVariable type: #FamixTStructuralEntity opposite: #fastAssignment"

	<generated>
	<FMProperty: #famixVariable type: #FamixTStructuralEntity opposite: #fastAssignment>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #famixVariable ifAbsent: [ nil ]
]

{ #category : '*Carrefour-Fortran-Model-accessing' }
FASTFortranAssignmentStatement >> famixVariable: anObject [

	<generated>
	self attributeAt: #famixVariable put: (FMMultivalueLink on: self update: #fastAssignment from: self famixVariable to: anObject).
]
