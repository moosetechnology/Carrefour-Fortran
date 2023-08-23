Extension { #name : #FASTFortranProgramUnit }

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FASTFortranProgramUnit >> famixPU [
	"Relation named: #famixPU type: #FamixFortran77ProgramUnit opposite: #fast"

	<generated>
	<derived>
	<FMProperty: #famixPU type: #FamixFortran77ProgramUnit opposite: #fast>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #famixPU ifAbsent: [ nil ]
]

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FASTFortranProgramUnit >> famixPU: anObject [

	<generated>
	(self attributeAt: #famixPU ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self famixPU.
		self attributeAt: #famixPU put: anObject.
		otherSide fast: nil ]
	ifNotNil: [ 
		self attributeAt: #famixPU put: anObject.
		anObject fast: self ]
]
