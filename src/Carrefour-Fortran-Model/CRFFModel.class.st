Class {
	#name : 'CRFFModel',
	#superclass : 'MooseModel',
	#traits : 'FASTFortranTEntityCreator + FASTTEntityCreator + FamixEsopeTEntityCreator + FamixF77TEntityCreator + FamixFortranTEntityCreator',
	#classTraits : 'FASTFortranTEntityCreator classTrait + FASTTEntityCreator classTrait + FamixEsopeTEntityCreator classTrait + FamixF77TEntityCreator classTrait + FamixFortranTEntityCreator classTrait',
	#category : 'Carrefour-Fortran-Model-Model',
	#package : 'Carrefour-Fortran-Model',
	#tag : 'Model'
}

{ #category : 'accessing' }
CRFFModel class >> allSubmetamodelsPackagesNames [
	<generated>
	^ #(#'Moose-Query' #'Famix-Traits' #'Famix-FortranUDT-Entities' #'Famix-Fortran77-Entities' #'Famix-Esope-Entities' #'FAST-Fortran-Entities' #'FAST-Core-Model')
]

{ #category : 'meta' }
CRFFModel class >> annotation [
	<FMClass: #CRFFModel super: #MooseModel>
	<package: #'Carrefour-Fortran-Model'>
	<generated>
]
