Class {
	#name : 'CRFFBindingCleanerTest',
	#superclass : 'TestCase',
	#instVars : [
		'famixModel',
		'fastModel',
		'entitiesToTest',
		'nbEntitiesToTest',
		'cleanerVisitor'
	],
	#category : 'Carrefour-Fortran-Tests',
	#package : 'Carrefour-Fortran-Tests'
}

{ #category : 'asserting' }
CRFFBindingCleanerTest >> assertEntitiesFreed [

	Smalltalk garbageCollect.	

	1 to: nbEntitiesToTest do: [ :i |
		self assert: (entitiesToTest at: i) equals: nil
	]
]

{ #category : 'asserting' }
CRFFBindingCleanerTest >> assertEntitiesNotFreed [

	self assert: nbEntitiesToTest > 0.

	1 to: nbEntitiesToTest do: [ :i |
		self assert: (entitiesToTest at: i) isNotNil
	]
]

{ #category : 'running' }
CRFFBindingCleanerTest >> entityToTest: anEntity [

	(nbEntitiesToTest = entitiesToTest size) ifTrue: [ SubscriptOutOfBounds signal: 'too many entities to test'  ].

	nbEntitiesToTest := nbEntitiesToTest + 1.
	entitiesToTest at: nbEntitiesToTest put: anEntity 
]

{ #category : 'famix-entity-creation' }
CRFFBindingCleanerTest >> famixInvocation: famixCalled from: famixCaller [

	^FamixF77Invocation new 
		sender: famixCaller ;
		addCandidate: famixCalled ;
		yourself
	
]

{ #category : 'famix-entity-creation' }
CRFFBindingCleanerTest >> famixMainProgram: aName [
	"
     PROGRAM demo
     END"

	^famixModel newPUMain 
		name: aName ;
		yourself.

]

{ #category : 'famix-entity-creation' }
CRFFBindingCleanerTest >> famixScalarVariable: aName [
	^famixModel newScalarVariable
		name: aName ;
		yourself
]

{ #category : 'famix-entity-creation' }
CRFFBindingCleanerTest >> famixSubroutine: aName [

	^famixModel newPUSubroutine
		name: aName ;
		yourself.

]

{ #category : 'fast-entity-creation' }
CRFFBindingCleanerTest >> fastCallStatement: aName arguments: aCollection [	
	"end position is approximate, test should adjust if a real value is needed"

	^fastModel newCallStatement
		name: aName ;
		arguments: (aCollection collect: [ :expr | self fastSimpleExpression: expr]) ;
		yourself
]

{ #category : 'fast-entity-creation' }
CRFFBindingCleanerTest >> fastCharacterLiteral: value [
	^fastModel newCharacterLiteral
		primitiveValue: value ;
		yourself
]

{ #category : 'running' }
CRFFBindingCleanerTest >> fastEntityNamed: aName [

	^fastModel
		detect: [ :e | (e class usesFamixTrait: FASTTNamedEntity) and: [ e name = aName ] ]
		ifNone: [ self fail: 'FAST entity named: ' , aName , ' not found' ]
]

{ #category : 'fast-entity-creation' }
CRFFBindingCleanerTest >> fastIntegerLiteral: value [
	^fastModel newIntegerLiteral
		primitiveValue: value ;
		yourself
]

{ #category : 'fast-entity-creation' }
CRFFBindingCleanerTest >> fastRealLiteral: value [
	^fastModel newRealLiteral
		primitiveValue: value ;
		yourself
]

{ #category : 'fast-entity-creation' }
CRFFBindingCleanerTest >> fastSimpleExpression: description [

	description ifNil: [ ^nil ].
	description isInteger ifTrue: [ ^self fastIntegerLiteral: description asString ].
	description isFloat ifTrue: [ ^self fastRealLiteral: description asString ].
	description isSymbol ifTrue: [ ^self scalarVariable: description asString ].
	description isString ifTrue: [ ^self fastCharacterLiteral: description asString ].
	description isMooseEntity ifTrue: [ ^description ].

	ShouldBeImplemented signal: 'ExpressionDescription: ' , description class name
	
]

{ #category : 'fast-entity-creation' }
CRFFBindingCleanerTest >> fastStatementBlock: aCollection [

	^fastModel newStatementBlock
		statements: aCollection ;
		yourself
]

{ #category : 'entity-creation' }
CRFFBindingCleanerTest >> mainProgram: aName [
	"
     PROGRAM demo
     END"

	^fastModel newProgramMain 
		name: aName ; 
		statementBlock: (self fastStatementBlock: #()) ; 
		famix: (self famixMainProgram: aName) ;
		yourself.

]

{ #category : 'entity-creation' }
CRFFBindingCleanerTest >> programFileWithEmptyMain [
	"
     PROGRAM demo
     END"

	| main |
	main := fastModel newProgramMain
		name: 'demo' ; 
		statementBlock: fastModel newStatementBlock ; 
		parentProgramFile: fastModel newProgramFile ;
		famix: (famixModel newPUMain
			name: 'demo' ;
			programFile: famixModel newProgramFile) ;
		yourself.

	^main parentProgramFile 
]

{ #category : 'entity-creation' }
CRFFBindingCleanerTest >> programFileWithMainAndProcedureInvoked [
	"
	subroutine sub
	end

	program demo
	call sub()
	end"


	| fastCallStatement fastSubroutine fastProgramFile |
	fastSubroutine := self subroutine: 'sub'.
	
	fastProgramFile := self programFileWithEmptyMain.
	fastProgramFile addProgramUnit: fastSubroutine.

	fastCallStatement := self fastCallStatement: 'sub' arguments: #().
	fastCallStatement  famix:
		(self 
			famixInvocation: (famixModel entityNamed: 'sub')
			from: (famixModel entityNamed: 'demo')).
	(fastModel allWithType:FASTFortranProgramMain) anyOne statementBlock addStatement: fastCallStatement.

	^fastProgramFile
]

{ #category : 'entity-creation' }
CRFFBindingCleanerTest >> scalarVariable: aName [
	^fastModel newScalarVariable
		name: aName ;
		famix: (self famixScalarVariable: aName)
		yourself
]

{ #category : 'running' }
CRFFBindingCleanerTest >> setUp [

	super setUp.

	cleanerVisitor := CRFFBindingCleaner new.

	fastModel := FASTFortranModel new.
	famixModel := FamixF77Model new.

	nbEntitiesToTest := 0.
	entitiesToTest := WeakArray new: 5
]

{ #category : 'entity-creation' }
CRFFBindingCleanerTest >> subroutine: aName [

	^fastModel newSubroutine
		name: aName ;
		statementBlock: (self fastStatementBlock: #()) ;
		famix: (self famixSubroutine: aName) ;
		yourself.

]

{ #category : 'tests' }
CRFFBindingCleanerTest >> testClearMainProgramBinding [

	self entityToTest: (self mainProgram: 'blah').

	self assertEntitiesNotFreed.
	cleanerVisitor cleanModel: fastModel.
	
	self assertEntitiesFreed
]

{ #category : 'tests' }
CRFFBindingCleanerTest >> testClearProgramFileWithMain [

	self entityToTest: (self programFileWithEmptyMain).
	self entityToTest: (self fastEntityNamed: 'demo').

	self assertEntitiesNotFreed.
	cleanerVisitor cleanModel: fastModel.
	
	self assertEntitiesFreed
]

{ #category : 'tests' }
CRFFBindingCleanerTest >> testClearProgramFileWithMainAndSubroutine [

	self entityToTest: (self programFileWithMainAndProcedureInvoked).
	self entityToTest: (self fastEntityNamed: 'demo').
	self entityToTest: (self fastEntityNamed: 'sub').

	self assertEntitiesNotFreed.
	cleanerVisitor cleanModel: fastModel.
	
	self assertEntitiesFreed
]
