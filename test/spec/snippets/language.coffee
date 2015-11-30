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
		'object with toString': '+{ toString: function () { return 321 }}'
		'object with valueOf': '+{ valueOf: function () { return "123" }}'

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

	'void operator':
		'void 0': 'void 0'
		'side effects': '''
			var a;
			void (a = 123);
			a
		'''

	'binary -':
		'numbers': '2 - 3'
		'strings': '"2" - "3"'
		'number and string': '123 + "234"'
		'string and number': '"234" + 123'

	'* operator':
		'numbers': '2 * 3'
		'strings': '"2" * "3"'

	'&& operator':
		'numbers': '2 && 3'
		'strings': '"asd" && ""'
		'booleans': 'false && true'
		'null': 'true && null'
		'undefined': 'true && undefined'

	'|| operator':
		'numbers': '2 || 3'
		'strings': '"asd" || ""'
		'booleans': 'false || true'
		'null': 'true || null'
		'undefined': 'true || undefined'

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

	'!== operator':
		'numbers': '2 + 4 !== 2 + 3'
		'strings': '"as" !== "as" + "d"'
		'boolean': 'true !== true'
		'different objects': '({}) !== ({})'
		'same object': '''
			var a = {};
			a !== a
		'''
		'null': 'null !== null'
		'undefined': 'undefined !== undefined'
		'null and undefined': 'null !== undefined'

	'== operator':
		'null': 'null == null'
		'undefined': 'undefined == undefined'
		'null and undefined': 'null == undefined'
		'null and object': 'null == {}'
		'undefined and object': 'undefined == {}'

	'!= operator':
		'null': 'null != null'
		'undefined': 'undefined != undefined'
		'null and undefined': 'null != undefined'
		'null and object': 'null != {}'
		'undefined and object': 'undefined != {}'

	'< operator':
		'numbers': '1 < 2'
		'strings': '"3" < "2"'
		'number and string': '1 < "asd"'
		'booleans': 'false < true'
		'undefined': 'undefined < undefined'
		'null and undefined': 'null < undefined'

	'<= operator':
		'numbers': '1 < 2'
		'strings': '"3" < "2"'
		'number and string': '1 < "asd"'
		'booleans': 'false < true'
		'undefined': 'undefined < undefined'
		'null and undefined': 'null < undefined'

	'typeof':
		'number': 'typeof 123'
		'string': 'typeof "asd"'
		'boolean': 'typeof true'
		'null': 'typeof null'
		'undefined': 'typeof undefined'
		'object': 'typeof ({})'
		'function': 'typeof (function () {})'

	'if expressions':
		'booleans cast to boolean': 'true ? 123 : 321'
		'numbers cast to boolean': '123 ? 456 : 789'
		'strings cast to boolean': '"" ? 456 : 789'

	'function calls':
		'one parameter': '(function () { return 123; })()'
		'two parameters': '(function (a) { return a; })(123)'
		'three parameters': '(function (a, b) { return a + b; })(123, 456)'

	'objects':
		'can lookup a member': '''
			({ a: 123 }).a
		'''
		'can lookup a member with a string key': '''
			({ "a": 123 }).a
		'''
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
		'can define a getter': '''
			({
				get a() { return 123 }
			}).a
		'''
		'can define a setter': '''
			var s;
			var a = {
				get a() { return s },
				set a(value) { s = value * 2 }
			};
			a.a = 123;
			a.a
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
		'object keys are converted to string': '''
			var a = {};
			var key = { toString: function () { return 'asd'; } };
			a[key] = 321;
			a.asd
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
		'unresolved properties evaluate to undefined': '''
			var a = {};
			a.b
		'''
		'functions have a prototype': '''
			function A() {}
			!A.prototype
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
		'if statement without alternate': '''
			var a;
			if (false) {
				a = 123;
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

	'sequence expressions':
		'evaluate to the last term': '123, 321'
		'evaluates all terms': '''
			var a, b;
			(function () { a = 123; })(),(function () { b = 321; })();
			a + b
		'''
		'evaluates all terms, in order': '''
			var a = 0;
			(function () { a = a * 10 + 5; })(),
			(function () { a = a * 10 + 7; })();
			a
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
			(function (a, b) { return b })(11, 22, 33, 44)
		'''
		'less parameters than formal arguments': '''
			(function (a, b) { return b })(321)
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

	'the arguments object':
		'is available in a function': '''
			(function () {
				return arguments[0];
			})(123);
		'''
		'works outside of the function': '''
			(function () {
				return arguments;
			})(123, 765)[1];
		'''
		'can be forwarded to apply': '''
			function f(a, b) {
				return a + b;
			}
			function g() {
				return f.apply(null, arguments);
			}
			g(123, 321);
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
		'window is located on window': 'window === window.window'
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
		'the global context has a this': 'this'


window.snippets ?= {}
Object.assign window.snippets, snippets