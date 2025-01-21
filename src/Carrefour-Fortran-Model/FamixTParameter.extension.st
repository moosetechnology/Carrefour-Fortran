Extension { #name : 'FamixTParameter' }

{ #category : '*Carrefour-Fortran-Model-accessing' }
FamixTParameter >> fastParameter [
	"Relation named: #fastParameter type: #FASTFortranScalarVariable opposite: #famixParameter"

	<generated>
	<FMProperty: #fastParameter type: #FASTFortranScalarVariable opposite: #famixParameter>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #fastParameter ifAbsent: [ nil ]
]

{ #category : '*Carrefour-Fortran-Model-accessing' }
FamixTParameter >> fastParameter: anObject [

	<generated>
	(self attributeAt: #fastParameter ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self fastParameter.
		self attributeAt: #fastParameter put: anObject.
		otherSide famixParameter: nil ]
	ifNotNil: [ 
		self attributeAt: #fastParameter put: anObject.
		anObject famixParameter: self ]
]
