Extension { #name : #FamixFortran77Parameter }

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FamixFortran77Parameter >> fast [
	"Relation named: #fast type: #FASTFortranScalarVariable opposite: #famixParameter"

	<generated>
	<FMProperty: #fast type: #FASTFortranScalarVariable opposite: #famixParameter>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #fast ifAbsent: [ nil ]
]

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FamixFortran77Parameter >> fast: anObject [

	<generated>
	(self attributeAt: #fast ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self fast.
		self attributeAt: #fast put: anObject.
		otherSide famixParameter: nil ]
	ifNotNil: [ 
		self attributeAt: #fast put: anObject.
		anObject famixParameter: self ]
]
