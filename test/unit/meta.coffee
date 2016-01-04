'use strict'


{
	ev
	EMPTY
	UNDEFINED
	processLiterals
	processVars
} = jinter


files = [
	'../../src/language/Env.js'
	'../../src/language/Null.js'
	'../../src/language/Undefined.js'
	'../../src/language/String.js'
	'../../src/language/Number.js'
	'../../src/language/Boolean.js'
	'../../src/language/Object.js'
	'../../src/language/NativeFunction.js'
	'../../src/built-ins/FunctionPrototype.js'
	'../../src/language/Function.js'
	'../../src/built-ins/ObjectPrototype.js'
	'../../src/built-ins/ArrayPrototype.js'
	'../../src/built-ins/Array.js'
	'../../src/built-ins/MapPrototype.js'
	'../../src/built-ins/Map.js'
	'../../src/built-ins/Window.js'
	'../../src/language/Evaluator.js'
]


fetchFiles = (files) ->
	promises = files.map (file) ->
		fetch file
		.then (response) -> response.text()

	Promise.all promises


jinterEv = (string) ->
	tree = esprima.parse string
	processLiterals tree
	processVars tree

	result = ev tree, EMPTY

	if result?
		result.asString()
	else
		'undefined'


getDecoratedTree = (string) ->
	tree = esprima.parse string
	processLiterals tree
	processVars tree

	tree


makeEv = (evaluatorSource) ->
	(expression) ->
		tree = getDecoratedTree expression
		stringifiedTree = JSON.stringify tree

		bundle = """
			#{evaluatorSource}
			var tree = #{stringifiedTree};

			var result = jinter.ev(tree, jinter.EMPTY);
			result ? result.asString() : 'undefined'
		"""

		jinterEv bundle


getEvaluator = ->
	fetchFiles files
	.then (sources) ->
		completeSource = sources.reduce (prev, cur) -> prev + cur
		makeEv completeSource


window.meta ?= {}
window.meta.getEvaluator = getEvaluator