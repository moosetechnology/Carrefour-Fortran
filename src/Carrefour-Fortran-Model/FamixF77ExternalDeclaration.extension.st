Extension { #name : 'FamixF77ExternalDeclaration' }

{ #category : '*Carrefour-Fortran-Model-accessing' }
FamixF77ExternalDeclaration >> fast [
	"Relation named: #fast type: #FASTFortranExternalFunctionDeclarationStatement opposite: #famix"

	<generated>
	<FMProperty: #fast type: #FASTFortranExternalFunctionDeclarationStatement opposite: #famix>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #fast ifAbsent: [ nil ]
]

{ #category : '*Carrefour-Fortran-Model-accessing' }
FamixF77ExternalDeclaration >> fast: anObject [

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