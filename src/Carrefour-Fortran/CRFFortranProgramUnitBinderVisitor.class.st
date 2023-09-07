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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
CRFFortranProgramUnitBinderVisitor >> locate: aFamixClass named: aName [
	^(famixEntity allToScope: aFamixClass)
	select: [ :each |each name = aName ]
]

{ #category : #'visiting - programUnits' }
CRFFortranProgramUnitBinderVisitor >> visitParameter: aFASTFortranScalarVariable [
	(self locate: FamixFortran77Parameter named: aFASTFortranScalarVariable name)
		ifNotEmpty: [ :famixParameters |
			self assert: (famixParameters size = 1).
			famixParameters anyOne fast: aFASTFortranScalarVariable ]
]
