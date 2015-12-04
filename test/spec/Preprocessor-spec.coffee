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

		it 'gathers all vars from local scopes', ->
			processed = process '''
				var a, b, c;
				function f() {
					var d;
				}
			'''

			expect processed.vars
			.toEqual ['a', 'b', 'c']

			expect processed.body[1].body.vars
			.toEqual ['d']

		it 'deals with variables declared multiple times', ->
			processed = process '''
				var a, b, c;
				console.log('asd');
				var b, c, d;
			'''

			expect processed.vars
			.toEqual ['a', 'b', 'c', 'd']

		it 'gathers all function declarations from local scopes', ->
			processed = process '''
				function f() {
					function g() {}
				}

				if (false) {
					function h() {}
				}
			'''

			expect processed.functionDeclarations.length
			.toEqual 2

			expect processed.body[0].body.functionDeclarations.length
			.toEqual 1

		it 'deals with duplicate function declarations', ->
			processed = process '''
				function f() {}

				function g() {}

				function f() {}
			'''

			expect processed.functionDeclarations.length
			.toEqual 2