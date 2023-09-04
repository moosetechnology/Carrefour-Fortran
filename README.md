# Carrefour-Fortran

A version of [Carrefour project](https://github.com/moosetechnology/Carrefour) for [Famix-Fortran](https://github.com/moosetechnology/Famix-Fortran)

To load execute in a Pharo Playground:
```st
Metacello new
    baseline: 'CarrefourFortran';
    repository: 'github://NicolasAnquetil/Carrefour-Fortran';
    onConflict: [ :ex | ex allow ];
    load
```
