snippets =
	'literal':
		'numbers': '1'
		'booleans': 'true'
		'strings': '"asd"'

	'binary +':
		'numbers': '2 + 3'
		'strings': '"asd" + "dsa"'
		'number and string': '123 + "asd"'
		'string and number': '"asd" + 123'

	'binary -':
		'numbers': '2 - 3'

	'if expressions':
		'booleans cast to boolean': 'true ? 123 : 321'
		'numbers cast to boolean': '123 ? 456 : 789'
		'strings cast to boolean': '"" ? 456 : 789'

	'function calls':
		'one parameter': '(function () { return 123; })()'
		'two parameters': '(function (a) { return a; })(123)'
		'three parameters': '(function (a, b) { return a + b; })(123, 456)'

	'objects':
		'can lookup a property': '({ a: 123 }).a'
		'can call a property': '({ a: 123, b: function () { return this.a } }).b()'

	'assignment expressions':
		'one assignment': '''
			var a;
			a = 123;
			a
		'''
		'two assignments': '''
			var a, b;
			a = 123;
			b = 456;
			a + b
		'''
		'assignment is an expression': '''
			var a, b;
			a = b = 123;
			a + b
		'''
		'assignment to object member': '''
			var a;
			a = {};
			a.b = 123;
			a.b
		'''
		'assignment from declaration': '''
			var a = 123, b = 456;
			a + b
		'''
		'assignment from var': '''
			var a = 123, b = a;
			a + b
		'''

	'__proto__ and the prototype chain':
		'lookup reached proto': '''
			var a = {};
			a.__proto__ = { b: 123 };
			a.b
		'''
		'lookup does not reach proto': '''
			var a = { b: 456 };
			a.__proto__ = { b: 123 };
			a.b
		'''
		'prototype chain': '''
			var a = {
				__proto__: {
					__proto__: {
						b: 123
					}
				}
			};
			a.b
		'''
		'lookup on __proto__ directly': '''
			var a = {
				__proto__: {
					b: 123
				}
			};
			a.__proto__.b
		'''

	'if statements':
		'simple if statement': '''
			var a;
			if (true) {
				a = 123;
			} else {
				a = 321;
			}
			a
		'''
		'return from if statement': '''
			(function () {
				if (true) {
					return 123;
				} else {
					return 321;
				}
			})()
		'''

	'new':
		'instantiation and assignment to this': '''
			var A = function () { this.b = 123; };
			var a = new A;
			a.b
		'''
		'set prototype': '''
			var A = function () { this.b = 123; };
			A.prototype = { c: 456 };
			var a = new A;
			a.b + a.c
		'''
		'inheritance': '''
			var A = function () {};
			A.prototype = { c: 456 };
			var B = function () {};
			B.prototype = new A;
			var b = new B;
			b.c
		'''

	'function declarations':
		'functions are bound to their name': '''
			function f() { return 123 }
			f()
		'''
		'all functions are bound to their name before execution': '''
			function f() { return g() }
			function g() { return 123 }
			f()
		'''

	'function calls':
		'more parameters than formal arguments': '''
			(function (a, b) { return 123 })(1, 2, 3, 4)
		'''
		'functions return undefined by default': '''
			(function () {})()
		'''
		'currying': '''
			(function (a) {
				return function (b) {
					return a + b
				}
			})(123)(456)
		'''

	'while':
		'simple loop': '''
			var i = 10, sum = 0;
			while (i) {
				sum = sum + i;
				i = i - 1;
			}
			sum
		'''
		'return from while': '''
			function f() {
				while (true) {
					return 123
				}
			}
			f()
		'''
		'return from nested while': '''
			function f() {
				while (true) {
					while (true) {
						return 123
					}
				}
			}
			f()
		'''

	'for':
		'simple for': '''
			var sum = 0;
			for (var i = 10; i; i = i - 1) {
				sum = sum + i;
			}
			sum
		'''
		'return from for': '''
			function f() {
				var sum = 0;
				for (var i = 10; i; i = i - 1) {
					return 123
				}
			}
			f()
		'''

	'recursion':
		'function declaration can refer to itself': '''
			function sum(n) {
				if (n) {
					return n + sum(n - 1)
				} else {
					return 0
				}
			}
			sum(10)
		'''
		'named function expression can refer to itself': '''
			(function sum(n) {
				if (n) {
					return n + sum(n - 1)
				} else {
					return 0
				}
			})(10)
		'''

window.snippets ?= {}
Object.assign window.snippets, snippets