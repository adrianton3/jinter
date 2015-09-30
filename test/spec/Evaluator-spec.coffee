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
		'true ? 123 : 321'
		'123 ? 456 : 789'
		'"" ? 456 : 789'
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
		'var a = { __proto__: { b: 123 } }; a.__proto__.b'
		'var a; if (true) { a = 123; } else { a = 321; } a'
		'(function () { if (true) { return 123; } else { return 321; } })()'
	].forEach (string) ->
		it string, ->
			(expect jinterEv string).toEqual (jsEv string)