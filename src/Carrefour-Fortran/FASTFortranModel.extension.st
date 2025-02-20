Extension { #name : 'FASTFortranModel' }

{ #category : '*Carrefour-Fortran' }
FASTFortranModel >> carrefourBinderCleaner [

	^ CRFFBindingCleaner new
]

{ #category : '*Carrefour-Fortran' }
FASTFortranModel >> carrefourBinderVisitor [

	^ CRFFortranProgramUnitBinderVisitor new
]

{ #category : '*Carrefour-Fortran' }
FASTFortranModel >> setMetamodelToCarrefour [

	self metamodel: CRFFModel metamodel
]
