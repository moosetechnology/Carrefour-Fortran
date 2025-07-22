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
	fastModel setMetamodelToCarrefour.

	(self rootEntitiesIn: fastModel)
		do: [ :rootEntity | rootEntity accept: self ].

]

{ #category : 'search famix' }
CRFFortranProgramUnitBinderVisitor >> childrenEntities: aFamixClass named: aName [
	"note that famixEntity's 'children' include the famixEntity itself"

	^(famixEntity allToScope: aFamixClass)
		select: [ :each | each name sameAs: aName ]
]

{ #category : 'search famix' }
CRFFortranProgramUnitBinderVisitor >> childrenStructuralEntitiesNamed: aName [
	(self childrenEntities: FamixF77Variable named: aName)
		ifNotEmpty: [ :entities | ^entities ].

	(self childrenEntities: FamixF77Parameter named: aName)
		ifNotEmpty: [ :entities | ^entities ].

	(self childrenEntities: FamixF77ExternalDeclaration named: aName)
		ifNotEmpty: [ :entities | ^entities ].

	"Once we are here, that means we have to look in segment
	- it can be a segment attribute (in the current programUnit or in includedFile)
	- or it can be a localVariable from includedFile
	"
	((famixEntity allLocalVariables)
		select: [ :localVariable | localVariable name sameAs: aName ]
	) ifNotEmpty: [ :entities | ^entities ].
		
	((famixEntity allTypes)
		select: [ :type | type name sameAs: aName ]
	) ifNotEmpty: [ :entities | ^entities ].
	
	^ #()
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

	self famixEntity accesses
		detect: [ :access |
			(access variable name = aFASTFortranAssignmentStatement variable name)
			and: [ access isWrite
			and: [ access fast isNil ] ] 
		]
		ifOne: [ :found |
			found fast: aFASTFortranAssignmentStatement.
			aFASTFortranAssignmentStatement variable famixVariable: found variable
		]
	ifNone: [ "trying to bind the variable by some other mean"
		aFASTFortranAssignmentStatement variable accept: self
	].

	aFASTFortranAssignmentStatement expression accept: self
]

{ #category : 'visiting - expressions' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranBinaryExpression: aFASTFortranBinaryExpression [

	"avoiding viditing twice:
	self visitFASTFortranTExpression: aFASTFortranBinaryExpression.
	self visitFASTFortranTFortranBinaryExpression: aFASTFortranBinaryExpression."
	aFASTFortranBinaryExpression leftOperand accept: self.
	aFASTFortranBinaryExpression rightOperand accept: self
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
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranDimensionStatement: aFASTFortranDimensionStatement [

	aFASTFortranDimensionStatement declarators do: [ :declarator |
		declarator accept: self ].
	"avoiding visiting twice:
	self visitFASTFortranTStatement: aFASTFortranDimensionStatement"
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranDoStatement: aFASTFortranDoStatement [

	"visitFASTFortranTStatement: would do the same as the other 2 lines:
	self visitFASTFortranTStatement: aFASTFortranDoStatement."
	aFASTFortranDoStatement loopControl accept: self.
	aFASTFortranDoStatement body accept: self
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranEquivalenceStatement: aFASTFortranEquivalenceStatement [

	"Avaoiding visiting twice:
	self visitFASTFortranTStatement: aFASTFortranEquivalenceStatement."
	aFASTFortranEquivalenceStatement variableGroups do: [ :group |
		group accept: self ]
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

{ #category : 'visiting' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranFieldAccess: aFASTFortranFieldAccess [

	| segment |
	aFASTFortranFieldAccess pointer accept: self.

	segment := aFASTFortranFieldAccess pointer famixVariable declaredType.
	self assert: (segment isNotNil).

	segment attributes 
		detect: [ :famixAttribute |
			famixAttribute name asLowercase = aFASTFortranFieldAccess field name asLowercase
		]
		ifOne: [ :famixAttribute |
			aFASTFortranFieldAccess field isArrayVariable
				ifTrue: [ 
					aFASTFortranFieldAccess field 
						indices do: [ :indice | indice accept: self ]
				] 
				ifFalse: [ 
					aFASTFortranFieldAccess field famixVariable: famixAttribute 
				]
		]
]

{ #category : 'visiting - programUnits' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranFunction: aFASTFortranFunction [

	| famix |

	famix := self childrenEntities: FamixF77PUFunction named: aFASTFortranFunction name.

	self assert: (famix size = 1).
	famix anyOne fast: aFASTFortranFunction.

	super visitFASTFortranFunction: aFASTFortranFunction

]

{ #category : 'visiting - expressions' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranFunctionCall: aFASTFortranFunctionCall [

	self famixEntity outgoingInvocations
		detect: [ :invok |
			(invok signature = aFASTFortranFunctionCall name)
				and: [ invok fast isNil ] 
		]
		ifOne: [ :found | found fast: aFASTFortranFunctionCall ].

	"super call would visit twice the arguments, so we don't do it:
	super visitFASTFortranFunctionCall: aFASTFortranFunctionCall "
	self visitFASTFortranTWithArguments: aFASTFortranFunctionCall
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranFunctionStatement: aFASTFortranFunctionStatement [

	| famix |

	famix := self childrenEntities: FamixF77StatementFunction named: aFASTFortranFunctionStatement name.

	self assert: (famix size = 1).
	famix anyOne fast: aFASTFortranFunctionStatement.

	self visitFASTFortranTStatement: aFASTFortranFunctionStatement.
	"Avoiding visiting twice:
	self visitFASTFortranTWithParameters: aFASTFortranFunctionStatement"
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranFunctionTypeDeclarationStatement: aFASTFortranFunctionTypeDeclarationStatement [

	"Avoiding visiting twice:
	self visitFASTFortranTStatement: aFASTFortranFunctionTypeDeclarationStatement."
	aFASTFortranFunctionTypeDeclarationStatement declaredType accept: self.
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranIfBlockStatement: aFASTFortranIfBlockStatement [

	"Avoiding visiting twice:
	self visitFASTFortranTStatement: aFASTFortranIfBlockStatement."
	aFASTFortranIfBlockStatement condition accept: self.
	aFASTFortranIfBlockStatement thenStatementBlock accept: self.
	aFASTFortranIfBlockStatement elseStatementBlock ifNotNil: [
		:elseBlock | elseBlock accept: self ]
]

{ #category : 'visiting - programUnits' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranIncludedFile: aFASTFortranIncludedFile [

	| famix |
	famix := self childrenEntities: FamixF77IncludedFile named: aFASTFortranIncludedFile name.

	self assert: famix size = 1.
	famix anyOne fast: aFASTFortranIncludedFile.

	super visitFASTFortranIncludedFile: aFASTFortranIncludedFile
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranInquireStatement: aFASTFortranInquireStatement [

	aFASTFortranInquireStatement ioParameters do: [ :ioParam |
		ioParam accept: self ].
	"Avoiding visiting twice:
	self visitFASTFortranTStatement: aFASTFortranInquireStatement"
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranIntrinsicStatement: aFASTFortranIntrinsicStatement [

	aFASTFortranIntrinsicStatement variables do: [ :var |
		var accept: self ].
	"Avoiding visiting twice:
	self visitFASTFortranTStatement: aFASTFortranIntrinsicStatement"
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranOpenStatement: aFASTFortranOpenStatement [

	aFASTFortranOpenStatement ioParameters do: [ :ioParam |
		ioParam accept: self ].
	"Avoiding visiting twice:
	self visitFASTFortranTStatement: aFASTFortranOpenStatement"
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranPrintStatement: aFASTFortranPrintStatement [
	<generated>

	"Avoiding visiting twice:
	self visitFASTFortranTWithArguments: aFASTFortranPrintStatement."
	self visitFASTFortranTStatement: aFASTFortranPrintStatement
]

{ #category : 'visiting - programUnits' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranProgramMain: aFASTFortranProgramMain [

	famixEntity fast: aFASTFortranProgramMain.

	super visitFASTFortranProgramMain: aFASTFortranProgramMain

]

{ #category : 'visiting - programUnits' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranProgramUnit: aFASTFortranProgramUnit [

	self visitFASTFortranTWithDeclarations: aFASTFortranProgramUnit.
	super visitFASTFortranProgramUnit: aFASTFortranProgramUnit
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranRewindStatement: aFASTFortranRewindStatement [

	aFASTFortranRewindStatement ioParameters do: [ :ioParam |
		ioParam accept: self ].
	"Avoiding visiting twice:
	self visitFASTFortranTStatement: aFASTFortranRewindStatement"
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranScalarVariable: aFASTFortranScalarVariable [
	| famix |
	famix := self 
				childrenStructuralEntitiesNamed: aFASTFortranScalarVariable name.

	(famix size = 1) ifTrue: [ 
		aFASTFortranScalarVariable famixVariable: famix anyOne 
	].
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

	aFASTFortranDeclarationStatement declarators
		do: [ :decl | decl accept: self ].

	aFASTFortranDeclarationStatement declaredType accept: self.
]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranVariableDeclarator: aFASTFortranDeclarator [

	| famix |
	famix := self childrenStructuralEntitiesNamed: aFASTFortranDeclarator name.
	self assert: (famix size = 1).
	famix anyOne fastDeclaration: aFASTFortranDeclarator

]

{ #category : 'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranWriteStatement: aFASTFortranWriteStatement [
	<generated>

	self visitFASTFortranTStatement: aFASTFortranWriteStatement.
	"Avoiding visiting twice:
	self visitFASTFortranTWithArguments: aFASTFortranWriteStatement"
]

{ #category : 'visiting - programUnits' }
CRFFortranProgramUnitBinderVisitor >> visitParameter: aFASTFortranScalarVariable [
	(self childrenEntities: FamixF77Parameter named: aFASTFortranScalarVariable name)
		ifNotEmpty: [ :famixParameters |
			self assert: (famixParameters size = 1).
			famixParameters anyOne fastParameter: aFASTFortranScalarVariable ]
]
