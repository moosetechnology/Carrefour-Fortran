Class {
	#name : 'BaselineOfCarrefourFortran',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfCarrefourFortran',
	#package : 'BaselineOfCarrefourFortran'
}

{ #category : 'baselines' }
BaselineOfCarrefourFortran >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec description: 'Binding FAST and Famix for Fortran'.
			self defineDependencies: spec.
			self definePackages: spec.
			self defineGroups: spec ]
]

{ #category : 'baselines' }
BaselineOfCarrefourFortran >> defineDependencies: spec [
	spec
		baseline: 'FASTFortran'
		with: [ spec
			repository: 'github://moosetechnology/FAST-Fortran' ] ;

		baseline: 'FamixFortran'
		with: [ spec
			loads: #('all');
			repository: 'github://moosetechnology/Famix-Fortran' ]
]

{ #category : 'baselines' }
BaselineOfCarrefourFortran >> defineGroups: spec [
	
	spec
		group: 'core' with: #( 'Carrefour-Fortran-Model' 'Carrefour-Fortran' );
		group: 'all' with:  #( 'core' 'Carrefour-Fortran-Tests' 'Carrefour-Fortran-Model-Generator' );
		group: 'default' with: #('core')
]

{ #category : 'baselines' }
BaselineOfCarrefourFortran >> definePackages: spec [
	spec
		package: 'Carrefour-Fortran-Model'
			with: [ spec requires: #('FamixFortran' 'FASTFortran') ];
		package: 'Carrefour-Fortran-Model-Generator'
			with: [ spec requires: #('FASTFortran' 'FamixFortran') ] ;
		package: 'Carrefour-Fortran'
			with: [ spec requires: #('Carrefour-Fortran-Model') ] ;
		package: 'Carrefour-Fortran-Tests'
			with: [ spec requires: #('Carrefour-Fortran') ]


]
