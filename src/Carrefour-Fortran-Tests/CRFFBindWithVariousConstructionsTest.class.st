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
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"./srcCodeOrigin.f"},"program_units":[{"anno":[],"arguments":null,"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:35)","statement":{"anno":[],"expression":{"anno":[],"expression":{"anno":[],"span":"(2:22)-(2:25)","tag":"value","value":{"contents":"expr","tag":"variable"}},"field":{"anno":[],"span":"(2:27)-(2:35)","tag":"value","value":{"contents":"exprfield","tag":"variable"}},"span":"(2:22)-(2:35)","tag":"deref"},"span":"(2:7)-(2:35)","tag":"assign_expression","target":{"anno":[],"expression":{"anno":[],"span":"(2:7)-(2:9)","tag":"value","value":{"contents":"var","tag":"variable"}},"field":{"anno":[],"span":"(2:11)-(2:18)","tag":"value","value":{"contents":"varfield","tag":"variable"}},"span":"(2:7)-(2:18)","tag":"deref"}},"tag":"statement"}],"name":"blah","options":[null,null],"span":"(1:7)-(3:9)","subprograms":null,"tag":"subroutine"}]}'
		forCode: 
'      subroutine blah
      var.varfield = expr.exprfield
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
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"./srcCodeOrigin.f"},"program_units":[{"anno":[],"arguments":null,"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:26)","statement":{"anno":[],"expression":{"anno":[],"expression":{"anno":[],"span":"(2:13)-(2:16)","tag":"value","value":{"contents":"expr","tag":"variable"}},"field":{"anno":[],"span":"(2:18)-(2:26)","tag":"value","value":{"contents":"exprfield","tag":"variable"}},"span":"(2:13)-(2:26)","tag":"deref"},"span":"(2:7)-(2:26)","tag":"assign_expression","target":{"anno":[],"span":"(2:7)-(2:9)","tag":"value","value":{"contents":"var","tag":"variable"}}},"tag":"statement"}],"name":"blah","options":[null,null],"span":"(1:7)-(3:9)","subprograms":null,"tag":"subroutine"}]}'
		forCode:
'      subroutine blah
      var = expr.exprfield
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
		createModels: '{"meta":{"miVersion":"fortran77","miFilename":"./srcCodeOrigin.f"},"program_units":[{"anno":[],"arguments":null,"blocks":[{"anno":[],"label":null,"span":"(2:7)-(2:25)","statement":{"anno":[],"expression":{"anno":[],"span":"(2:22)-(2:25)","tag":"value","value":{"contents":"expr","tag":"variable"}},"span":"(2:7)-(2:25)","tag":"assign_expression","target":{"anno":[],"expression":{"anno":[],"span":"(2:7)-(2:9)","tag":"value","value":{"contents":"var","tag":"variable"}},"field":{"anno":[],"span":"(2:11)-(2:18)","tag":"value","value":{"contents":"varfield","tag":"variable"}},"span":"(2:7)-(2:18)","tag":"deref"}},"tag":"statement"}],"name":"blah","options":[null,null],"span":"(1:7)-(3:9)","subprograms":null,"tag":"subroutine"}]}'
		forCode:
'      subroutine blah
      var.varfield = expr
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
