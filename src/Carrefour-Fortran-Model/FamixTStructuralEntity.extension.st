Extension { #name : 'FamixTStructuralEntity' }

{ #category : '*Carrefour-Fortran-Model-accessing' }
FamixTStructuralEntity >> fastAssignment [
	"Relation named: #fastAssignment type: #FASTFortranAssignmentStatement opposite: #famixVariable"

	<generated>
	<derived>
	<FMProperty: #fastAssignment type: #FASTFortranAssignmentStatement opposite: #famixVariable>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #fastAssignment ifAbsentPut: [ FMMultivalueLink on: self opposite: #famixVariable: ]
]

{ #category : '*Carrefour-Fortran-Model-accessing' }
FamixTStructuralEntity >> fastAssignment: anObject [

	<generated>
	self fastAssignment value: anObject
]

{ #category : '*Carrefour-Fortran-Model-accessing' }
FamixTStructuralEntity >> fastDeclaration [
	"Relation named: #fastDeclaration type: #FASTFortranVariableDeclarator opposite: #famixDeclaration"

	<generated>
	<FMProperty: #fastDeclaration type: #FASTFortranVariableDeclarator opposite: #famixDeclaration>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #fastDeclaration ifAbsent: [ nil ]
]

{ #category : '*Carrefour-Fortran-Model-accessing' }
FamixTStructuralEntity >> fastDeclaration: anObject [

	<generated>
	(self attributeAt: #fastDeclaration ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self fastDeclaration.
		self attributeAt: #fastDeclaration put: anObject.
		otherSide famixDeclaration: nil ]
	ifNotNil: [ 
		self attributeAt: #fastDeclaration put: anObject.
		anObject famixDeclaration: self ]
]
