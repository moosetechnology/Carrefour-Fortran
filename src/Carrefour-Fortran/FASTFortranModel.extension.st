Extension { #name : 'FASTFortranModel' }

{ #category : '*Carrefour-Fortran' }
FASTFortranModel >> carrefourBinderVisitor [

	^ CRFFortranProgramUnitBinderVisitor new
]
