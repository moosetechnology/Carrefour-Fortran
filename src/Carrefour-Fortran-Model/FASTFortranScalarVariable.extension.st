Extension { #name : 'FASTFortranScalarVariable' }

{ #category : '*Carrefour-Fortran-Model-accessing' }
FASTFortranScalarVariable >> famixParameter [
	"Relation named: #famixParameter type: #FamixTParameter opposite: #fastParameter"

	<generated>
	<derived>
	<FMProperty: #famixParameter type: #FamixTParameter opposite: #fastParameter>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #famixParameter ifAbsent: [ nil ]
]

{ #category : '*Carrefour-Fortran-Model-accessing' }
FASTFortranScalarVariable >> famixParameter: anObject [

	<generated>
	(self attributeAt: #famixParameter ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self famixParameter.
		self attributeAt: #famixParameter put: anObject.
		otherSide fastParameter: nil ]
	ifNotNil: [ 
		self attributeAt: #famixParameter put: anObject.
		anObject fastParameter: self ]
]
