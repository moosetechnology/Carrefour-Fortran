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
				loads: #('all');
				repository: 'github://moosetechnology/FAST-Fortran/tree/carrefour' ] ;

		baseline: 'FamixFortran'
		with: [ spec
				loads: #('all');
				repository: 'github://moosetechnology/Famix-Fortran' ]
]

{ #category : #baselines }
BaselineOfCarrefourFortran >> defineGroups: spec [
	spec group: 'generator' with: #('Carrefour-Fortran-Model-Generator')
]

{ #category : #baselines }
BaselineOfCarrefourFortran >> definePackages: spec [
	spec
		repository: 'https://github.com/moosetechnology/Carrefour-Fortran';
		package: 'Carrefour-Fortran-Model' with: [ spec requires: #('FamixFortran' 'FASTFortran') ];
		package: 'Carrefour-Model-Generator'
			with: [ spec requires: #('FASTFortran' 'FamixFortran') ]

]
