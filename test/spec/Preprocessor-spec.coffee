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
			.toEqual ['a', 'b', 'c', 'd']