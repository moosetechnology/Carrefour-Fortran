Extension { #name : 'FamixF77StatementFunction' }

{ #category : '*Carrefour-Fortran-Model-accessing' }
FamixF77StatementFunction >> fast [
	"Relation named: #fast type: #FASTFortranFunctionStatement opposite: #famix"

	<generated>
	<FMProperty: #fast type: #FASTFortranFunctionStatement opposite: #famix>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #fast ifAbsent: [ nil ]
]

{ #category : '*Carrefour-Fortran-Model-accessing' }
FamixF77StatementFunction >> fast: anObject [

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
