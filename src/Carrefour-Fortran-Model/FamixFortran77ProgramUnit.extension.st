Extension { #name : #FamixFortran77ProgramUnit }

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FamixFortran77ProgramUnit >> fast [
	"Relation named: #fast type: #FASTFortranProgramUnit opposite: #famixPU"

	<generated>
	<FMProperty: #fast type: #FASTFortranProgramUnit opposite: #famixPU>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #fast ifAbsent: [ nil ]
]

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FamixFortran77ProgramUnit >> fast: anObject [

	<generated>
	(self attributeAt: #fast ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self fast.
		self attributeAt: #fast put: anObject.
		otherSide famixPU: nil ]
	ifNotNil: [ 
		self attributeAt: #fast put: anObject.
		anObject famixPU: self ]
]
