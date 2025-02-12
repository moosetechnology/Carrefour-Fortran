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
	
	fastModel := nil.
	Smalltalk garbageCollect.	

	1 to: nbEntitiesToTest do: [ :i |
		self assert: (entitiesToTest at: i) equals: nil
	]
]

{ #category : 'running' }
CRFFBindingCleanerTest >> entityToTest: anEntity [

	(nbEntitiesToTest = entitiesToTest size) ifTrue: [ SubscriptOutOfBounds signal: 'too many entities to test'  ].

	nbEntitiesToTest := nbEntitiesToTest + 1.
	entitiesToTest at: nbEntitiesToTest put: anEntity 
]

{ #category : 'running' }
CRFFBindingCleanerTest >> famixMainProgram: aName [
	"
     PROGRAM demo
     END"

	^famixModel newPUMain 
		name: aName ;
		yourself.

]

{ #category : 'running' }
CRFFBindingCleanerTest >> famixScalarVariable: aName [
	^famixModel newScalarVariable
		name: aName ;
		yourself
]

{ #category : 'running' }
CRFFBindingCleanerTest >> famixSubroutine: aName [

	^famixModel newPUSubroutine
		name: aName ;
		yourself.

]

{ #category : 'running' }
CRFFBindingCleanerTest >> fastCallStatement: aName arguments: aCollection [	
	"end position is approximate, test should adjust if a real value is needed"

	^fastModel newCallStatement
		name: aName ;
		arguments: (aCollection collect: [ :expr | self fastSimpleExpression: expr]) ;
		yourself
]

{ #category : 'running' }
CRFFBindingCleanerTest >> fastCharacterLiteral: value [
	^fastModel newCharacterLiteral
		primitiveValue: value ;
		yourself
]

{ #category : 'running' }
CRFFBindingCleanerTest >> fastIntegerLiteral: value [
	^fastModel newIntegerLiteral
		primitiveValue: value ;
		yourself
]

{ #category : 'running' }
CRFFBindingCleanerTest >> fastMainProgram: aName [
	"
     PROGRAM demo
     END"

	^fastModel newProgramMain 
		name: aName ; 
		statementBlock: (self fastStatementBlock: #()) ; 
		famix: (self famixMainProgram: aName) ;
		yourself.

]

{ #category : 'running' }
CRFFBindingCleanerTest >> fastRealLiteral: value [
	^fastModel newRealLiteral
		primitiveValue: value ;
		yourself
]

{ #category : 'running' }
CRFFBindingCleanerTest >> fastScalarVariable: aName [
	^fastModel newScalarVariable
		name: aName ;
		famix: (self famixScalarVariable: aName)
		yourself
]

{ #category : 'running' }
CRFFBindingCleanerTest >> fastSimpleExpression: description [

	description ifNil: [ ^nil ].
	description isInteger ifTrue: [ ^self fastIntegerLiteral: description asString ].
	description isFloat ifTrue: [ ^self fastRealLiteral: description asString ].
	description isSymbol ifTrue: [ ^self fastScalarVariable: description asString ].
	description isString ifTrue: [ ^self fastCharacterLiteral: description asString ].
	description isMooseEntity ifTrue: [ ^description ].

	ShouldBeImplemented signal: 'ExpressionDescription: ' , description class name
	
]

{ #category : 'running' }
CRFFBindingCleanerTest >> fastStatementBlock: aCollection [

	^fastModel newStatementBlock
		statements: aCollection ;
		yourself
]

{ #category : 'running' }
CRFFBindingCleanerTest >> fastSubroutine: aName [

	^fastModel newSubroutine
		name: aName ;
		statementBlock: (self fastStatementBlock: #()) ;
		famix: (self famixSubroutine: aName) ;
		yourself.

]

{ #category : 'setup' }
CRFFBindingCleanerTest >> programFileWithEmptyMain [
	"
     PROGRAM demo
     END"

	^FASTFortranProgramMain new 
		name: 'demo' ; 
		statementBlock: FASTFortranStatementBlock new ; 
		parentProgramFile: FASTFortranProgramFile new ;
		famix: (FamixF77PUMain new
			name: 'demo' ;
			programFile: FamixF77ProgramFile new) ;
		yourself.

]

{ #category : 'setup' }
CRFFBindingCleanerTest >> programWithProcedureInvoked [
	"
	subroutine sub
	end

	program demo
	call sub()
	end"


	| subCallStatement fastProcedures fastMainProgram fastProgramFile |
	fastProcedures := (self fastSubroutine: 'sub')
			famix: (FamixF77PUSubroutine new name: 'sub');
			yourself.

	subCallStatement := self fastCallStatement: 'sub' arguments: #().
	
	fastMainProgram := self programFileWithEmptyMain.
	fastMainProgram statementBlock addStatement: subCallStatement.

	subCallStatement  famix: (FamixF77Invocation new 
		sender: fastMainProgram famix;
		addCandidate: fastProcedures famix;
		yourself
	).

	fastProgramFile programUnit: { fastProcedures . fastMainProgram }.

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

{ #category : 'tests' }
CRFFBindingCleanerTest >> testClearMainProgramBinding [

	self entityToTest: (self fastMainProgram: 'blah').

	cleanerVisitor cleanModel: fastModel.
	
	self assertEntitiesFreed
]

{ #category : 'tests' }
CRFFBindingCleanerTest >> testClearProgramFileWithMain [

	self entityToTest: (self programFileWithEmptyMain).
	self entityToTest: (entitiesToTest first parentProgramFile).

	cleanerVisitor cleanModel: fastModel.
	
	self assertEntitiesFreed
]
