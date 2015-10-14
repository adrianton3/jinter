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
		'with toString': '''
			var a = { toString: function () { return "asd" } };
			a + 123
		'''
		'with valueOf': '''
			var a = { valueOf: function () { return 234 } };
			a + 123
		'''
		'valueOf has precedence over toString': '''
			var a = {
				toString: function () { return "asd" },
				valueOf: function () { return 234 }
			};
			a + 123
		'''
		'toString can return a number': '''
			var a = { toString: function () { return 234 } };
			a + 123
		'''
		'valueOf can return a string': '''
			var a = { valueOf: function () { return "asd" } };
			a + 123
		'''

	'unary +':
		'number': '+123'
		'numberic string': '+"123"'
		'non-numberic string': '+"asd"'
		'boolean': '+true'
		'null': '+null'
		'undefined': '+undefined'
		'object': '+({})'

	'unary -':
		'number': '-123'
		'numberic string': '-"123"'
		'non-numberic string': '-"asd"'
		'boolean': '-true'
		'null': '-null'
		'undefined': '-undefined'
		'object': '-({})'

	'! operator':
		'number': '!123'
		'string': '!"asd"'
		'boolean': '!true'
		'null': '!null'
		'undefined': '!undefined'
		'object': '!({})'

	'binary -':
		'numbers': '2 - 3'
		'strings': '"2" - "3"'
		'number and string': '123 + "234"'
		'string and number': '"234" + 123'

	'* operator':
		'numbers': '2 * 3'
		'strings': '"2" * "3"'

	'=== operator':
		'numbers': '1 + 4 === 2 + 3'
		'strings': '"a" + "sd" === "as" + "d"'
		'boolean': 'false === true'
		'different objects': '({}) === ({})'
		'same object': '''
			var a = {};
			a === a
		'''
		'null': 'null === null'
		'undefined': 'undefined === undefined'

	'if expressions':
		'booleans cast to boolean': 'true ? 123 : 321'
		'numbers cast to boolean': '123 ? 456 : 789'
		'strings cast to boolean': '"" ? 456 : 789'

	'function calls':
		'one parameter': '(function () { return 123; })()'
		'two parameters': '(function (a) { return a; })(123)'
		'three parameters': '(function (a, b) { return a + b; })(123, 456)'

	'objects':
		'can lookup a member': '({ a: 123 }).a'
		'can call a member': '''
			({
				a: 123,
				b: function () { return this.a }
			}).b()
		'''
		'computed member expression': '({ asd: 123 })["a" + "sd"]'
		'can call a computed member': '''
			({
				asd: function () { return 123 }
			})["a" + "sd"]()
		'''

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
		'assignment to computed object member': '''
			var a;
			a = {};
			a["a" + "sd"] = 123;
			a.asd
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

	'scopes':
		'undefined is located on window': 'undefined'
		'local variables shadow top level variables': '''
			var a = 123;
			(function () {
				var a = 321;
				return a;
			})()
 		'''
		'local variables shadow parent scopes': '''
			(function () {
				var a = 123;
				return (function () {
					var a = 321;
					return a;
				})()
			})()
 		'''
		'local variables does not shadow function parameter': '''
			(function (a) {
				var a;
				return a;
			})(123)
 		'''

	'Object.create':
		'can create an object with a prototype': '''
			var a = Object.create({ b: 123 });
			a.b
		'''
		'can access prototype via __proto__': '''
			var a = Object.create({ b: 123 });
			a.__proto__.b
		'''

	'Array':
		'can construct': '''
			var a = [11, 22, 33];
			a[1]
		'''
		'can set/get numeric property': '''
			var a = [];
			a[3] = 123;
			a[3]
		'''

	'Array length':
		'for empty arrays': '[].length'
		'for non-empty arrays': '[11, 22, 33].length'
		'for sparse arrays': '''
			var a = [];
			a[3] = 123;
			a.length
		'''

	'Array methods':
		'toString': '''
			[11, 22, 33, 44, 55].toString()
		'''
		'slice': '''
			[11, 22, 33, 44, 55].slice(2, 3)
		'''
		'push return': '''
			[11, 22, 33, 44, 55].push(66)
		'''
		'push original array': '''
			var a = [11, 22, 33, 44, 55];
			a.push(66);
			a
		'''
		'pop return': '''
			[11, 22, 33, 44, 55].pop()
		'''
		'pop original array': '''
			var a = [11, 22, 33, 44, 55];
			a.pop();
			a
		'''

	'Function methods':
		'apply': '''
			var f = function (a, b) { return a + b };
			f.apply(null, [11, 22])
		'''
		'apply with this': '''
			var f = function (a) { return this + a };
			f.apply(11, [22])
		'''
		'call': '''
			var f = function (a, b) { return a + b };
			f.call(null, 11, 22)
		'''
		'call with this': '''
			var f = function (a) { return this + a };
			f.call(11, 22)
		'''


window.snippets ?= {}
Object.assign window.snippets, snippets