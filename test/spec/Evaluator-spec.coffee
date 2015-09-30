'use strict'


{ ev, EMPTY, processLiterals, processVars } = jinter


describe 'ev', ->
	jinterEv = (string) ->
		tree = esprima.parse string
		processLiterals tree
		processVars tree

		result = ev tree, EMPTY

		if result?
			result.toString()
		else
			'undefined'


	jsEv = (string) ->
		(eval string).toString()


	[
		'1'
		'2 + 3'
		'"asd" + "dsa"'
		'123 + "asd"'
		'"asd" + 123'
		'(function () { return 123; })()'
		'(function (a) { return a; })(123)'
		'(function (a, b) { return a + b; })(123, 456)'
		'({ a: 123 }).a'
		'({ a: 123, b: function () { return this.a } }).b()'
		'var a; a = 123; a'
		'var a, b; a = 123; b = 456; a + b'
		'var a, b; a = b = 123; a + b'
		'var a; a = {}; a.b = 123; a.b'
		'var a = 123, b = 456; a + b'
		'var a = 123, b = a; a + b'
		'var a = {}; a.__proto__ = { b: 123 }; a.b'
		'var a = { b: 456 }; a.__proto__ = { b: 123 }; a.b'
		'var a = { __proto__: { __proto__: { b: 123 } } }; a.b'
	].forEach (string) ->
		it string, ->
			(expect jinterEv string).toEqual (jsEv string)