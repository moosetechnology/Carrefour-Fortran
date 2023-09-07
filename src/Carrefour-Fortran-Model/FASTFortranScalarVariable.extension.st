Extension { #name : #FASTFortranScalarVariable }

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FASTFortranScalarVariable >> famixParameter [
	"Relation named: #famixParameter type: #FamixFortran77Parameter opposite: #fast"

	<generated>
	<derived>
	<FMProperty: #famixParameter type: #FamixFortran77Parameter opposite: #fast>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #famixParameter ifAbsent: [ nil ]
]

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FASTFortranScalarVariable >> famixParameter: anObject [

	<generated>
	(self attributeAt: #famixParameter ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self famixParameter.
		self attributeAt: #famixParameter put: anObject.
		otherSide fast: nil ]
	ifNotNil: [ 
		self attributeAt: #famixParameter put: anObject.
		anObject fast: self ]
]

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
