Extension { #name : #FASTFortranScalarVariable }

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FASTFortranScalarVariable >> famixDeclaration [
	"Relation named: #famixDeclaration type: #FamixTStructuralEntity opposite: #fastDeclaration"

	<generated>
	<derived>
	<FMProperty: #famixDeclaration type: #FamixTStructuralEntity opposite: #fastDeclaration>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #famixDeclaration ifAbsent: [ nil ]
]

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FASTFortranScalarVariable >> famixDeclaration: anObject [

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

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FASTFortranScalarVariable >> famixParameter [
	"Relation named: #famixParameter type: #FamixTParameter opposite: #fastParameter"

	<generated>
	<derived>
	<FMProperty: #famixParameter type: #FamixTParameter opposite: #fastParameter>
	<package: #'Carrefour-Fortran-Model'>
	^ self attributeAt: #famixParameter ifAbsent: [ nil ]
]

{ #category : #'*Carrefour-Fortran-Model-accessing' }
FASTFortranScalarVariable >> famixParameter: anObject [

	<generated>
	(self attributeAt: #famixParameter ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self famixParameter.
		self attributeAt: #famixParameter put: anObject.
		otherSide fastParameter: nil ]
	ifNotNil: [ 
		self attributeAt: #famixParameter put: anObject.
		anObject fastParameter: self ]
]
