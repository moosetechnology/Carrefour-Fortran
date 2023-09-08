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

	(fastModel allWithSubTypesOf: FASTFortranProgramUnit)
		select: [ :entity | entity parentNode isNil ]
		thenDo: [ :rootEntity | self accept: rootEntity ].

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
CRFFortranProgramUnitBinderVisitor >> visitFASTFortranDeclarationStatement: aFASTFortranDeclarationStatement [
	"A declarationStatement can be for a local variable or a Parameter"

	aFASTFortranDeclarationStatement declarators
		do: [ :decl || famix |
			(self locate: FamixFortran77Variable named: decl name)
				ifNotEmpty: [ :vars | famix := vars ]
				ifEmpty: [ famix := self locate: FamixFortran77Parameter named: decl name ].
			self assert: (famix size = 1).
			famix anyOne fastDeclaration: decl
		].
		
]

{ #category : #'visiting - programUnits' }
CRFFortranProgramUnitBinderVisitor >> visitParameter: aFASTFortranScalarVariable [
	(self locate: FamixFortran77Parameter named: aFASTFortranScalarVariable name)
		ifNotEmpty: [ :famixParameters |
			self assert: (famixParameters size = 1).
			famixParameters anyOne fastParameter: aFASTFortranScalarVariable ]
]
