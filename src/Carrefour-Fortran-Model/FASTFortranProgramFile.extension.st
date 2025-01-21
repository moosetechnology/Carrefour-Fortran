Extension { #name : 'FASTFortranProgramFile' }

{ #category : '*Carrefour-Fortran-Model-accessing' }
FASTFortranProgramFile >> famix [
	"Relation named: #famix type: #FamixF77ProgramFile opposite: #fast"

	<generated>
	<derived>
	<FMProperty: #famix type: #FamixF77ProgramFile opposite: #fast>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #famix ifAbsent: [ nil ]
]

{ #category : '*Carrefour-Fortran-Model-accessing' }
FASTFortranProgramFile >> famix: anObject [

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
