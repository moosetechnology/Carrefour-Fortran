Class {
	#name : #BaselineOfCarrefourFortran,
	#superclass : #BaselineOf,
	#category : #BaselineOfCarrefourFortran
}

{ #category : #baselines }
BaselineOfCarrefourFortran >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec description: 'Binding FAST and Famix for Fortran'.
			self defineDependencies: spec.
			self definePackages: spec.
			self defineGroups: spec ]
]

{ #category : #baselines }
BaselineOfCarrefourFortran >> defineDependencies: spec [
	spec
		baseline: 'FASTFortran'
		with: [ spec
				loads: #('default');
				repository: 'github://moosetechnology/FAST-Fortran/src' ] ;

		baseline: 'FamixFortran'
		with: [ spec
				loads: #('default');
				repository: 'github://moosetechnology/Famix-Fortran' ]
]

{ #category : #baselines }
BaselineOfCarrefourFortran >> defineGroups: spec [
	spec
		group: 'core' with: #('Carrefour-Fortran-Model' 'Carrefour-Fortran');
		group: 'default' with: #('core')
]

{ #category : #baselines }
BaselineOfCarrefourFortran >> definePackages: spec [
	spec
		repository: 'https://github.com/NicolasAnquetil/Carrefour-Fortran';
		package: 'Carrefour-Fortran-Model'
			with: [ spec requires: #('FamixFortran' 'FASTFortran') ];
		package: 'Carrefour-Fortran-Model-Generator'
			with: [ spec requires: #('FASTFortran' 'FamixFortran') ] ;
		package: 'Carrefour-Fortran'
			with: [ spec requires: #('Carrefour-Fortran-Model') ]

]
