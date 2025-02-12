Class {
	#name : 'CRFFBindingCleaner',
	#superclass : 'FASTFortranVisitor',
	#category : 'Carrefour-Fortran',
	#package : 'Carrefour-Fortran'
}

{ #category : 'visiting' }
CRFFBindingCleaner >> cleanModel: fastModel [
	"as advertized: tries its best to remove everything from the fastModel to allow
	 garbage collecting the memory used"

	fastModel flush.

	self visitFASTFortranModel: fastModel.
	fastModel removeAll
]

{ #category : 'search famix' }
CRFFBindingCleaner >> rootEntitiesIn: aFASTFortranModel [

	^aFASTFortranModel entities select: [ :entity |
		entity parents isEmpty
	]
]

{ #category : 'visiting - statements' }
CRFFBindingCleaner >> visitFASTFortranAssignmentStatement: aFASTFortranAssignmentStatement [

	aFASTFortranAssignmentStatement famixVariable: nil.

	super visitFASTFortranAssignmentStatement: aFASTFortranAssignmentStatement
]

{ #category : 'visiting - statements' }
CRFFBindingCleaner >> visitFASTFortranCallStatement: aFASTFortranCallStatement [

	aFASTFortranCallStatement famix: nil.

	super visitFASTFortranCallStatement: aFASTFortranCallStatement 
]

{ #category : 'visiting - statements' }
CRFFBindingCleaner >> visitFASTFortranExternalStatement: aFASTExternalStatement [

	aFASTExternalStatement famix: nil.

	super visitFASTFortranExternalStatement: aFASTExternalStatement
]

{ #category : 'visiting - programUnits' }
CRFFBindingCleaner >> visitFASTFortranFunction: aFASTFortranFunction [ 

	aFASTFortranFunction famix: nil.
	
	super visitFASTFortranFunction: aFASTFortranFunction 
]

{ #category : 'visiting - statements' }
CRFFBindingCleaner >> visitFASTFortranFunctionStatement: aFASTFortranFunctionStatement [

	aFASTFortranFunctionStatement famix: nil.
		
	super visitFASTFortranFunctionStatement: aFASTFortranFunctionStatement
]

{ #category : 'visiting' }
CRFFBindingCleaner >> visitFASTFortranModel: aFASTFortranModel [

	(self rootEntitiesIn: aFASTFortranModel) do: [ :rootEntity |
		rootEntity accept: self ]
]

{ #category : 'visiting - programUnits' }
CRFFBindingCleaner >> visitFASTFortranProgramMain: aFASTFortranProgramMain [

	aFASTFortranProgramMain famix: nil.

	super visitFASTFortranProgramMain: aFASTFortranProgramMain

]

{ #category : 'visiting - programUnits' }
CRFFBindingCleaner >> visitFASTFortranSubroutine: aFASTFortranSubroutine [ 

	aFASTFortranSubroutine famix: nil.
	
	super visitFASTFortranSubroutine: aFASTFortranSubroutine 
]

{ #category : 'visiting' }
CRFFBindingCleaner >> visitFASTFortranVariableDeclarator: aFASTFortranVariableDeclarator [

	aFASTFortranVariableDeclarator famix: nil.

	super visitFASTFortranVariableDeclarator: aFASTFortranVariableDeclarator
]

{ #category : 'visiting - programUnits' }
CRFFBindingCleaner >> visitParameter: aFASTFortranScalarVariable [

	aFASTFortranScalarVariable famix: nil.

	super visitParameter: aFASTFortranScalarVariable
]
