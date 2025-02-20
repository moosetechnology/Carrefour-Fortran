Class {
	#name : 'CRFFBindCallStatementTest',
	#superclass : 'CRFFAbstractBindTest',
	#category : 'Carrefour-Fortran-Tests',
	#package : 'Carrefour-Fortran-Tests'
}

{ #category : 'tests' }
CRFFBindCallStatementTest >> testCallUnknownSubroutine [

	| entities fmx fast |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"./srcCodeOrigin.f"},"program_units":[{"anno":[],"blocks":[{"anno":[],"label":null,"span":"(3:7)-(3:17)","statement":{"anno":[],"arguments":{"anno":[],"list":[],"span":"(3:16)-(3:17)"},"function":{"anno":[],"span":"(3:12)-(3:15)","tag":"value","value":{"contents":"blah","tag":"variable"}},"span":"(3:7)-(3:17)","tag":"call"},"tag":"statement"}],"name":"main","span":"(2:7)-(4:9)","subprograms":null,"tag":"main"}]}'
		forCode:
'      program main
      call blah()
      end
'.

	(famixModel entityNamed: 'main') bindFastModel: fastModel.


	entities := famixModel allWithType: FamixF77Invocation.

	self assert: entities size equals: 1.
	fmx := entities anyOne.
	fast := fmx fast.

	self assert: fast isNotNil.
	self assert: fast class equals: FASTFortranCallStatement.
	self assert: fast name equals: fmx signature

]

{ #category : 'tests' }
CRFFBindCallStatementTest >> testFunctionInvocation [

	| entities fmx fast |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"/home/anquetil/Pharo/images/esope-250220/srcCodeOrigin.f"},"program_units":[{"anno":[],"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:17)","statement":{"anno":[],"expression":{"anno":[],"arguments":{"anno":[],"list":[],"span":"(2:16)-(2:17)"},"function":{"anno":[],"span":"(2:11)-(2:15)","tag":"value","value":{"contents":"fct","tag":"variable"}},"span":"(2:11)-(2:17)","tag":"function_call"},"span":"(2:7)-(2:17)","tag":"assign_expression","target":{"anno":[],"span":"(2:7)-(2:7)","tag":"value","value":{"contents":"v","tag":"variable"}}},"tag":"statement"}],"name":"main","span":"(1:7)-(3:9)","subprograms":null,"tag":"main"}]}'
		forCode:
'      program main
      v = fct()
      end
'.

	(famixModel entityNamed: 'main') bindFastModel: fastModel.


	entities := famixModel allWithType: FamixF77Invocation.

	self assert: entities size equals: 1.
	fmx := entities anyOne.
	fast := fmx fast.

	self assert: fast isNotNil.
	self assert: fast famix equals: fmx.
	self assert: fast class equals: FASTFortranFunctionCall.
	self assert: fast name equals: fmx signature

]

{ #category : 'tests' }
CRFFBindCallStatementTest >> testFunctionInvocationTwice [

	| entities |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"/home/anquetil/Pharo/images/esope-250220/srcCodeOrigin.f"},"program_units":[{"anno":[],"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:15)","statement":{"anno":[],"expression":{"anno":[],"arguments":{"anno":[],"list":[],"span":"(2:14)-(2:15)"},"function":{"anno":[],"span":"(2:11)-(2:13)","tag":"value","value":{"contents":"fct","tag":"variable"}},"span":"(2:11)-(2:15)","tag":"function_call"},"span":"(2:7)-(2:15)","tag":"assign_expression","target":{"anno":[],"span":"(2:7)-(2:7)","tag":"value","value":{"contents":"v","tag":"variable"}}},"tag":"statement"},{"anno":[],"label":null,"span":"(3:7)-(3:15)","statement":{"anno":[],"expression":{"anno":[],"arguments":{"anno":[],"list":[],"span":"(3:14)-(3:15)"},"function":{"anno":[],"span":"(3:11)-(3:13)","tag":"value","value":{"contents":"fct","tag":"variable"}},"span":"(3:11)-(3:15)","tag":"function_call"},"span":"(3:7)-(3:15)","tag":"assign_expression","target":{"anno":[],"span":"(3:7)-(3:7)","tag":"value","value":{"contents":"x","tag":"variable"}}},"tag":"statement"}],"name":"main","span":"(1:7)-(4:9)","subprograms":null,"tag":"main"}]}'
		forCode:
'      program main
      v = fct()
      x = fct()
      end
'.

	(famixModel entityNamed: 'main') bindFastModel: fastModel.

	entities := famixModel allWithType: FamixF77Invocation.

	self assert: entities size equals: 2.

	entities do: [ :invocation |
		self assert: invocation fast isNotNil.
		self assert: invocation fast famix equals: invocation
	].

	entities := fastModel allWithType: FASTFortranFunctionCall.

	self assert: entities size equals: 2.

	entities do: [ :fctCall |
		self assert: fctCall famix isNotNil.
		self assert: fctCall famix fast equals: fctCall
	]

]

{ #category : 'tests' }
CRFFBindCallStatementTest >> testFunctionInvocationTwiceInLoop [

	| entities |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"/home/anquetil/Pharo/images/esope-250220/srcCodeOrigin.f"},"program_units":[{"anno":[],"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:15)","statement":{"anno":[],"expression":{"anno":[],"arguments":{"anno":[],"list":[],"span":"(2:14)-(2:15)"},"function":{"anno":[],"span":"(2:11)-(2:13)","tag":"value","value":{"contents":"fct","tag":"variable"}},"span":"(2:11)-(2:15)","tag":"function_call"},"span":"(2:7)-(2:15)","tag":"assign_expression","target":{"anno":[],"span":"(2:7)-(2:7)","tag":"value","value":{"contents":"x","tag":"variable"}}},"tag":"statement"},{"anno":[],"body":[{"anno":[],"label":null,"span":"(4:8)-(4:16)","statement":{"anno":[],"expression":{"anno":[],"arguments":{"anno":[],"list":[],"span":"(4:15)-(4:16)"},"function":{"anno":[],"span":"(4:12)-(4:14)","tag":"value","value":{"contents":"fct","tag":"variable"}},"span":"(4:12)-(4:16)","tag":"function_call"},"span":"(4:8)-(4:16)","tag":"assign_expression","target":{"anno":[],"span":"(4:8)-(4:8)","tag":"value","value":{"contents":"v","tag":"variable"}}},"tag":"statement"}],"do_spec":{"anno":[],"increment":null,"initial":{"anno":[],"expression":{"anno":[],"span":"(3:12)-(3:12)","tag":"value","value":{"contents":["1",null],"tag":"integer"}},"span":"(3:10)-(3:12)","tag":"assign_expression","target":{"anno":[],"span":"(3:10)-(3:10)","tag":"value","value":{"contents":"i","tag":"variable"}}},"limit":{"anno":[],"span":"(3:14)-(3:15)","tag":"value","value":{"contents":["10",null],"tag":"integer"}},"span":"(3:10)-(3:15)"},"end_label":null,"label":null,"name":null,"span":"(3:7)-(5:12)","tag":"do","target":null}],"name":"main","span":"(1:7)-(6:9)","subprograms":null,"tag":"main"}]}'
		forCode:
'      program main
      x = fct()
      do i=1,10
       v = fct()
      end do
      end
'.

	(famixModel entityNamed: 'main') bindFastModel: fastModel.

	entities := fastModel allWithType: FASTFortranFunctionCall.

	self assert: entities size equals: 2.

	entities do: [ :fctCall |
		self assert: fctCall famix isNotNil.
		self assert: fctCall famix fast equals: fctCall
	]

]

{ #category : 'tests' }
CRFFBindCallStatementTest >> testFunctionInvocationWithArguments [

	| entities fmx fast |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"/home/anquetil/Pharo/images/esope-250220/srcCodeOrigin.f"},"program_units":[{"anno":[],"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:18)","statement":{"anno":[],"expression":{"anno":[],"arguments":{"anno":[],"list":[{"anno":[],"expr":{"contents":{"anno":[],"span":"(2:15)-(2:15)","tag":"value","value":{"contents":["2",null],"tag":"integer"}},"tag":"expr"},"name":null,"span":"(2:15)-(2:15)"},{"anno":[],"expr":{"contents":{"anno":[],"span":"(2:17)-(2:17)","tag":"value","value":{"contents":["3",null],"tag":"integer"}},"tag":"expr"},"name":null,"span":"(2:17)-(2:17)"}],"span":"(2:15)-(2:17)"},"function":{"anno":[],"span":"(2:11)-(2:13)","tag":"value","value":{"contents":"fct","tag":"variable"}},"span":"(2:11)-(2:18)","tag":"function_call"},"span":"(2:7)-(2:18)","tag":"assign_expression","target":{"anno":[],"span":"(2:7)-(2:7)","tag":"value","value":{"contents":"v","tag":"variable"}}},"tag":"statement"}],"name":"main","span":"(1:7)-(3:9)","subprograms":null,"tag":"main"}]}'
		forCode:
'      program main
      v = fct(2,3)
      end
'.

	(famixModel entityNamed: 'main') bindFastModel: fastModel.


	entities := famixModel allWithType: FamixF77Invocation.

	self assert: entities size equals: 1.
	fmx := entities anyOne.
	fast := fmx fast.

	self assert: fast isNotNil.
	self assert: fast famix equals: fmx.
	self assert: fast class equals: FASTFortranFunctionCall.
	self assert: fast name equals: fmx signature

]
