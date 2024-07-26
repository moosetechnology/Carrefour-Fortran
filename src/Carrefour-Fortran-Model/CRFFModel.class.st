Class {
	#name : 'CRFFModel',
	#superclass : 'MooseModel',
	#traits : 'FASTFortranTEntityCreator + FASTTEntityCreator + FamixF77TEntityCreator',
	#classTraits : 'FASTFortranTEntityCreator classTrait + FASTTEntityCreator classTrait + FamixF77TEntityCreator classTrait',
	#category : 'Carrefour-Fortran-Model-Model',
	#package : 'Carrefour-Fortran-Model',
	#tag : 'Model'
}

{ #category : 'accessing' }
CRFFModel class >> allSubmetamodelsPackagesNames [
	<generated>
	^ #(#'Moose-Query' #'Famix-Traits' #'Famix-Fortran77-Entities' #'FAST-Fortran-Entities' #'FAST-Core-Model')
]

{ #category : 'meta' }
CRFFModel class >> annotation [
	<FMClass: #CRFFModel super: #MooseModel>
	<package: #'Carrefour-Fortran-Model'>
	<generated>
]
