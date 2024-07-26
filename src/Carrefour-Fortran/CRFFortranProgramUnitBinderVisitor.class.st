Class {
	#name : 'CRFFortranProgramUnitBinderVisitor',
	#superclass : 'FASTFortranVisitor',
	#instVars : [
		'famixEntity'
	],
	#category : 'Carrefour-Fortran',
	#package : 'Carrefour-Fortran'
}

{ #category : 'api' }
CRFFortranProgramUnitBinderVisitor >> bindFastModel: fastModel toFamixEntity: aFamixEntity [
	
	self famixEntity: aFamixEntity.
	fastModel metamodel: CRFFModel metamodel.

	(OrderedCollection withAll: (fastModel allWithSubTypesOf: FASTFortranProgramUnit))
		select: [ :entity | entity parents isEmpty ]
		thenDo: [ :rootEntity | rootEntity accept: self ].

]

{ #category : 'search famix' }
CRFFortranProgramUnitBinderVisitor >> childrenEntities: aFamixClass named: aName [

	^(famixEntity allToScope: aFamixClass)
		select: [ :each | each name = aName ]
]

{ #category : 'search famix' }
CRFFortranProgramUnitBinderVisitor >> childrenStructuralEntitiesNamed: aName [
	^(self childrenEntities: FamixF77Variable named: aName)
		ifEmpty: [ self childrenEntities: FamixF77Parameter named: aName ]
]

{ #category : 'private' }
CRFFortranProgramUnitBinderVisitor >> ensureFASTMetaModel: aFASTEntity [
	^(aFASTEntity class = FASTFortranModel)
		ifFalse: [ aFASTEntity mooseModel: FASTFortranModel new ].
]

{ #category : 'accessing' }
CRFFortranProgramUnitBinderVisitor >> famixEntity [

	^ famixEntity
]

{ #category : 'accessing' }
CRFFortranProgramUnitBinderVisitor >> famixEntity: anObject [

	famixEntity := anObject
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranAssignmentStatement: aFASTFortranAssignmentStatement [

	| famix |

	famix := self childrenStructuralEntitiesNamed: aFASTFortranAssignmentStatement variable name.
	self assert: (famix size = 1).
	aFASTFortranAssignmentStatement famixVariable: famix anyOne
		
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranDeclarationStatement [
	"A declarationStatement can be for a local variable or a Parameter"

	aFASTFortranDeclarationStatement declarators
		do: [ :decl || famix |
			famix := self childrenStructuralEntitiesNamed: decl name.
			self assert: (famix size = 1).
			famix anyOne fastDeclaration: decl
		].
		
]

{ #category : 'visiting - programUnits' }
CRFFortranProgramUnitBinderVisitor >> visitParameter: aFASTFortranScalarVariable [
	(self childrenEntities: FamixF77Parameter named: aFASTFortranScalarVariable name)
		ifNotEmpty: [ :famixParameters |
			self assert: (famixParameters size = 1).
			famixParameters anyOne fastParameter: aFASTFortranScalarVariable ]
]
