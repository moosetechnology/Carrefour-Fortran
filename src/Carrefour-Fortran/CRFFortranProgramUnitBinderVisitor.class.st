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

	(self rootEntitiesIn: fastModel)
		do: [ :rootEntity | rootEntity accept: self ].

]

{ #category : 'search famix' }
CRFFortranProgramUnitBinderVisitor >> childrenEntities: aFamixClass named: aName [
	"note that famixEntity's 'children' include the famixEntity itself"

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

{ #category : 'accessing' }
CRFFortranProgramUnitBinderVisitor >> fastMetamodel [

	^CRFFModel metamodel
]

{ #category : 'search famix' }
CRFFortranProgramUnitBinderVisitor >> rootEntitiesIn: fastModel [

	^(fastModel allWithSubTypesOf: FASTFortranProgramUnit)
		select: [ :entity | entity parents isEmpty ]
]

{ #category : 'visiting' }
CRFFortranProgramUnitBinderVisitor >> visitCharacterLiteralNode: aFASTFortranCharacterLiteral [

	^ aFASTFortranCharacterLiteral primitiveValue
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranAssignmentStatement: aFASTFortranAssignmentStatement [

	| famix |

	famix := self childrenStructuralEntitiesNamed: aFASTFortranAssignmentStatement variable name.
	self assert: (famix size = 1).
	aFASTFortranAssignmentStatement famixVariable: famix anyOne.

	super visitFASTFortranAssignmentStatement: aFASTFortranAssignmentStatement
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranCallStatement: aFASTFortranCallStatement [

	self famixEntity outgoingInvocations
		detect: [ :invok |
			(invok signature = aFASTFortranCallStatement name)
			and: [ invok fast isNil ] ]
		ifOne: [ :found | found fast: aFASTFortranCallStatement ]
		ifNone: [ ].

	super visitFASTFortranCallStatement: aFASTFortranCallStatement 
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranExternalFunctionDeclarationStatement: aFASTExternalFunctionDeclarationStatement [

	(self childrenEntities: FamixF77ExternalDeclaration named: aFASTExternalFunctionDeclarationStatement name)
		ifNotEmpty: [ :famixEntities |
			self assert: (famixEntities size = 1).
			famixEntities anyOne fast: aFASTExternalFunctionDeclarationStatement ]

	

]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranExternalStatement: aFASTExternalStatement [

	(self childrenEntities: FamixF77ExternalDeclaration named: aFASTExternalStatement name)
		ifNotEmpty: [ :famixEntities |
			self assert: (famixEntities size = 1).
			famixEntities anyOne fast: aFASTExternalStatement ]

	

]

{ #category : 'visiting - programUnits' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranFunction: aFASTFortranFunction [

	| famix |

	famix := self childrenEntities: FamixF77PUFunction named: aFASTFortranFunction name.

	self assert: (famix size = 1).
	famix anyOne fast: aFASTFortranFunction.

	super visitFASTFortranFunction: aFASTFortranFunction

]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranFunctionStatement: aFASTFortranFunctionStatement [

	| famix |

	famix := self childrenEntities: FamixF77StatementFunction named:  aFASTFortranFunctionStatement name.
	self assert: (famix size = 1).
	famix anyOne fast: aFASTFortranFunctionStatement.
		
	super visitFASTFortranFunctionStatement: aFASTFortranFunctionStatement
]

{ #category : 'visiting - programUnits' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranProgramMain: aFASTFortranProgramMain [

	famixEntity fast: aFASTFortranProgramMain.

	super visitFASTFortranProgramMain: aFASTFortranProgramMain

]

{ #category : 'visiting - programUnits' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [

	| famix |

	famix := self childrenEntities: FamixF77PUSubroutine named: aFASTFortranSubroutine name.

	self assert: (famix size = 1).
	famix anyOne fast: aFASTFortranSubroutine.

	super visitFASTFortranSubroutine: aFASTFortranSubroutine

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

	super visitFASTFortranVariableDeclarationStatement: aFASTFortranDeclarationStatement
]

{ #category : 'visiting - programUnits' }
CRFFortranProgramUnitBinderVisitor >> visitParameter: aFASTFortranScalarVariable [
	(self childrenEntities: FamixF77Parameter named: aFASTFortranScalarVariable name)
		ifNotEmpty: [ :famixParameters |
			self assert: (famixParameters size = 1).
			famixParameters anyOne fastParameter: aFASTFortranScalarVariable ]
]
