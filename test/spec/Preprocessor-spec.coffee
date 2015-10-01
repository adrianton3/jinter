'use strict'

{ processVars } = jinter


describe 'preprocessor', ->
	describe 'processVars', ->
		process = (string) ->
			tree = esprima.parse string
			processVars tree
			tree

		it 'gathers all vars from the global scope', ->
			processed = process '''
				var a, b, c;
				console.log('asd');
				var d;
			'''

			expect processed.vars
			.toEqual new Set ['a', 'b', 'c', 'd']

		it 'gathers all vars from local scopes', ->
			processed = process '''
				var a, b, c;
				function f() {
					var d;
				}
			'''

			expect processed.vars
			.toEqual new Set ['a', 'b', 'c']

			expect processed.body[1].body.vars
			.toEqual new Set ['d']