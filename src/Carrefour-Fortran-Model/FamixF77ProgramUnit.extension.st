Extension { #name : #FamixF77ProgramUnit }

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FamixF77ProgramUnit >> fast [
	"Relation named: #fast type: #FASTFortranEntity opposite: #famix"

	<generated>
	<FMProperty: #fast type: #FASTFortranEntity opposite: #famix>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #fast ifAbsent: [ nil ]
]

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FamixF77ProgramUnit >> fast: anObject [

	<generated>
	(self attributeAt: #fast ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self fast.
		self attributeAt: #fast put: anObject.
		otherSide famix: nil ]
	ifNotNil: [ 
		self attributeAt: #fast put: anObject.
		anObject famix: self ]
]
