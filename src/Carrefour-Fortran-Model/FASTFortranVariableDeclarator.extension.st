Extension { #name : 'FASTFortranVariableDeclarator' }

{ #category : '*Carrefour-Fortran-Model-accessing' }
FASTFortranVariableDeclarator >> famixDeclaration [
	"Relation named: #famixDeclaration type: #FamixTStructuralEntity opposite: #fastDeclaration"

	<generated>
	<derived>
	<FMProperty: #famixDeclaration type: #FamixTStructuralEntity opposite: #fastDeclaration>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #famixDeclaration ifAbsent: [ nil ]
]

{ #category : '*Carrefour-Fortran-Model-accessing' }
FASTFortranVariableDeclarator >> famixDeclaration: anObject [

	<generated>
	(self attributeAt: #famixDeclaration ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self famixDeclaration.
		self attributeAt: #famixDeclaration put: anObject.
		otherSide fastDeclaration: nil ]
	ifNotNil: [ 
		self attributeAt: #famixDeclaration put: anObject.
		anObject fastDeclaration: self ]
]
