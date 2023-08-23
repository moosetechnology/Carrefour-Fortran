Class {
	#name : #CRFFortranModel,
	#superclass : #MooseModel,
	#traits : 'FASTFortranTEntityCreator + FASTTEntityCreator + FamixFortran77TEntityCreator',
	#classTraits : 'FASTFortranTEntityCreator classTrait + FASTTEntityCreator classTrait + FamixFortran77TEntityCreator classTrait',
	#category : #'Carrefour-Fortran-Model-Model'
}

{ #category : #accessing }
CRFFortranModel class >> allSubmetamodelsPackagesNames [
	<generated>
	^ #(#'Moose-Query' #'Famix-Traits' #'Famix-Fortran77-Entities' #'FAST-Fortran-Entities' #'FAST-Core-Model')
]

{ #category : #meta }
CRFFortranModel class >> annotation [
	<FMClass: #CRFFortranModel super: #MooseModel>
	<package: #'Carrefour-Fortran-Model'>
	<generated>
]
