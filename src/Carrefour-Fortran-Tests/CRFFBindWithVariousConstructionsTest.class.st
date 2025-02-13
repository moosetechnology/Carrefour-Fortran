Class {
	#name : 'CRFFBindWithVariousConstructionsTest',
	#superclass : 'CRFFAbstractBindTest',
	#category : 'Carrefour-Fortran-Tests',
	#package : 'Carrefour-Fortran-Tests'
}

{ #category : 'as yet unclassified' }
CRFFBindWithVariousConstructionsTest >> testAssignmentWithVariableAndExpressionBothFieldAccess [

	| entities fmx |

	self skip: #TODO.

	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"/Users/sow/Documents/Pharo/images/EsopeToF2k250213/srcCodeOrigin.f"},"program_units":[{"anno":[],"arguments":null,"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:28)","statement":{"anno":[],"expression":{"anno":[],"expression":{"anno":[],"span":"(2:19)-(2:22)","tag":"value","value":{"contents":"expr","tag":"variable"}},"field":{"anno":[],"span":"(2:24)-(2:28)","tag":"value","value":{"contents":"field","tag":"variable"}},"span":"(2:19)-(2:28)","tag":"deref"},"span":"(2:7)-(2:28)","tag":"assign_expression","target":{"anno":[],"expression":{"anno":[],"span":"(2:7)-(2:9)","tag":"value","value":{"contents":"var","tag":"variable"}},"field":{"anno":[],"span":"(2:11)-(2:15)","tag":"value","value":{"contents":"field","tag":"variable"}},"span":"(2:7)-(2:15)","tag":"deref"}},"tag":"statement"}],"name":"blah","options":[null,null],"span":"(1:7)-(3:9)","subprograms":null,"tag":"subroutine"}]}'
		forCode:
'      subroutine blah
      var.field = expr.field
      end
'.

	(famixModel entityNamed: 'blah') bindFastModel: fastModel.

	entities := famixModel allWithType: FamixF77PUSubroutine.

	self assert: entities size equals: 1.
	fmx := entities anyOne.

	self assert: fmx fast isNotNil.
]

{ #category : 'as yet unclassified' }
CRFFBindWithVariousConstructionsTest >> testAssignmentWithVariableAndExpressionFieldAccess [

	| entities fmx |

	self skip: #TODO.

	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"/Users/sow/Documents/Pharo/images/EsopeToF2k250213/srcCodeOrigin.f"},"program_units":[{"anno":[],"arguments":null,"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:22)","statement":{"anno":[],"expression":{"anno":[],"expression":{"anno":[],"span":"(2:13)-(2:16)","tag":"value","value":{"contents":"expr","tag":"variable"}},"field":{"anno":[],"span":"(2:18)-(2:22)","tag":"value","value":{"contents":"field","tag":"variable"}},"span":"(2:13)-(2:22)","tag":"deref"},"span":"(2:7)-(2:22)","tag":"assign_expression","target":{"anno":[],"span":"(2:7)-(2:9)","tag":"value","value":{"contents":"var","tag":"variable"}}},"tag":"statement"}],"name":"blah","options":[null,null],"span":"(1:7)-(3:9)","subprograms":null,"tag":"subroutine"}]}'
		forCode:
'      subroutine blah
      var = expr.field
      end
'.

	(famixModel entityNamed: 'blah') bindFastModel: fastModel.

	entities := famixModel allWithType: FamixF77PUSubroutine.

	self assert: entities size equals: 1.
	fmx := entities anyOne.

	self assert: fmx fast isNotNil.
]

{ #category : 'as yet unclassified' }
CRFFBindWithVariousConstructionsTest >> testAssignmentWithVariableFieldAccessAndExpression [

	| entities fmx |

	self skip: #TODO.

	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"/Users/sow/Documents/Pharo/images/EsopeToF2k250213/srcCodeOrigin.f"},"program_units":[{"anno":[],"arguments":null,"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:22)","statement":{"anno":[],"expression":{"anno":[],"span":"(2:19)-(2:22)","tag":"value","value":{"contents":"expr","tag":"variable"}},"span":"(2:7)-(2:22)","tag":"assign_expression","target":{"anno":[],"expression":{"anno":[],"span":"(2:7)-(2:9)","tag":"value","value":{"contents":"var","tag":"variable"}},"field":{"anno":[],"span":"(2:11)-(2:15)","tag":"value","value":{"contents":"field","tag":"variable"}},"span":"(2:7)-(2:15)","tag":"deref"}},"tag":"statement"}],"name":"blah","options":[null,null],"span":"(1:7)-(3:9)","subprograms":null,"tag":"subroutine"}]}'
		forCode:
'      subroutine blah
      var.field = expr
      end
'.

	(famixModel entityNamed: 'blah') bindFastModel: fastModel.

	entities := famixModel allWithType: FamixF77PUSubroutine.

	self assert: entities size equals: 1.
	fmx := entities anyOne.

	self assert: fmx fast isNotNil.
]

{ #category : 'as yet unclassified' }
CRFFBindWithVariousConstructionsTest >> testExternalStatement [

	| entities fmx |
	self
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"/home/anquetil/Pharo/images/crf-fortran/srcCode.f"},"program_units":[{"anno":[],"arguments":null,"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:18)","statement":{"anno":[],"span":"(2:7)-(2:18)","tag":"external","vars":{"anno":[],"list":[{"anno":[],"span":"(2:16)-(2:18)","tag":"value","value":{"contents":"fct","tag":"variable"}}],"span":"(2:16)-(2:18)"}},"tag":"statement"}],"name":"blah","options":[null,null],"span":"(1:7)-(3:9)","subprograms":null,"tag":"subroutine"}]}'
		forCode:
'      subroutine blah
      EXTERNAL fct
      end
'.

	(famixModel entityNamed: 'blah') bindFastModel: fastModel.

	entities := famixModel allWithType: FamixF77PUSubroutine.

	self assert: entities size equals: 1.
	fmx := entities anyOne.

	self assert: fmx fast isNotNil.
]
