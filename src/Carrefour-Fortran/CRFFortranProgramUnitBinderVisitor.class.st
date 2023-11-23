Class {
	#name : #CRFFortranProgramUnitBinderVisitor,
	#superclass : #FASTFortranVisitor,
	#instVars : [
		'famixEntity'
	],
	#category : #'Carrefour-Fortran'
}

{ #category : #api }
CRFFortranProgramUnitBinderVisitor >> bindFastModel: fastModel toFamixEntity: aFamixEntity [
	
	self famixEntity: aFamixEntity.
	fastModel metamodel: CRFFModel metamodel.

	(OrderedCollection withAll: (fastModel allWithSubTypesOf: FASTFortranProgramUnit))
		select: [ :entity | entity parents isEmpty ]
		thenDo: [ :rootEntity | rootEntity accept: self ].

]

{ #category : #private }
CRFFortranProgramUnitBinderVisitor >> ensureFASTMetaModel: aFASTEntity [
	^(aFASTEntity class = FASTFortranModel)
		ifFalse: [ aFASTEntity mooseModel: FASTFortranModel new ].
]

{ #category : #accessing }
CRFFortranProgramUnitBinderVisitor >> famixEntity [

	^ famixEntity
]

{ #category : #accessing }
CRFFortranProgramUnitBinderVisitor >> famixEntity: anObject [

	famixEntity := anObject
]

{ #category : #private }
CRFFortranProgramUnitBinderVisitor >> locate: aFamixClass named: aName [
	^(famixEntity allToScope: aFamixClass)
	select: [ :each |each name = aName ]
]

{ #category : #'visiting - statements' }
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranDeclarationStatement [
	"A declarationStatement can be for a local variable or a Parameter"

	aFASTFortranDeclarationStatement declarators
		do: [ :decl || famix |
			(self locate: FamixF77Variable named: decl variable)
				ifNotEmpty: [ :vars | famix := vars ]
				ifEmpty: [ famix := self locate: FamixF77Parameter named: decl name ].
			self assert: (famix size = 1).
			famix anyOne fastDeclaration: decl
		].
		
]

{ #category : #'visiting - programUnits' }
CRFFortranProgramUnitBinderVisitor >> visitParameter: aFASTFortranScalarVariable [
	(self locate: FamixF77Parameter named: aFASTFortranScalarVariable name)
		ifNotEmpty: [ :famixParameters |
			self assert: (famixParameters size = 1).
			famixParameters anyOne fastParameter: aFASTFortranScalarVariable ]
]
