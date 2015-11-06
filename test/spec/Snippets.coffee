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

	'Object.create':
		'can create an object with a prototype': '''
			var a = Object.create({ b: 123 });
			a.b
		'''
		'can access prototype via __proto__': '''
			var a = Object.create({ b: 123 });
			a.__proto__.b
		'''

	'Object.keys':
		'returns an empty array for an empty object': '''
			Object.keys({})
		'''
		'returns the keys of an object': '''
			Object.keys({ a: 123, b: 321 })
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
		'forEach iterates over an array': '''
			var s = 0;
			[11, 22].forEach(function (element) {
				s = s + element;
			});
			s
		'''
		'forEach indices': '''
			var s = 0;
			[11, 22].forEach(function (element, index) {
				s = s + index;
			});
			s
		'''
		'forEach array argument': '''
			var s = 0;
			[11, 22].forEach(function (element, index, array) {
				s = s + array[index];
			});
			s
		'''
		'forEach optional this': '''
			var s = 0;
			[11, 22].forEach(function (element, index, array) {
				s = s + this;
			}, 123);
			s
		'''
		'map iterates over an array': '''
			[11, 22].map(function (element) {
				return element * element;
			});
		'''
		'filter eliminates some elements': '''
			[11, 22, 33, 44].filter(function (element) {
				return element === 22;
			});
		'''
		'filter eliminates all elements when no return is present': '''
			[11, 22, 33, 44].filter(function (element) {
			});
		'''
		'filter preserves all elements': '''
			[11, 22, 33, 44].filter(function (element) {
				return true;
			});
		'''
		'reduce can sum up numbers': '''
			[11, 22, 33, 44].reduce(function (base, element) {
				return base + element;
			});
		'''
		'reduce can take an initial value': '''
			[11, 22, 33, 44].reduce(function (base, element) {
				return base + element;
			}, 123);
		'''
		'reduce is called for all elements when the initial value is present': '''
			var calls = 0;
			[11, 22, 33, 44].reduce(function (base, element) {
				calls = calls + 1;
			}, 123);
			calls
		'''
		'reduce skips the first element when the initial value is missing': '''
			var calls = 0;
			[11, 22, 33, 44].reduce(function (base, element) {
				calls = calls + 1;
			});
			calls
		'''

	'Map':
		'constructor without arguments': '''
			var map = new Map;
			map.get(123)
		'''
		'constructor with arguments': '''
			var map = new Map([[123, 'asd'], [321, 'dsa']]);
			map.get(123) + map.get(321)
		'''

	'Map methods':
		'get returns undefined if the entry is missing': '''
			var map = new Map;
			map.get(123) === undefined
		'''
		'has returns true': '''
			var map = new Map;
			map.has(123)
		'''
		'has returns false': '''
			var map = new Map([[123, 321]]);
			map.has(123)
		'''
		'set can set things': '''
			var map = new Map;
			map.set(123, "dsa")
			map.get(123)
		'''
		'set can re-set things': '''
			var map = new Map([[123, 321]]);
			map.set(123, "asd")
			map.get(123)
		'''
		'forEach iterates over entries': '''
			var s = 0;
			var map = new Map([["a", 123], ["b", 321]]);
			map.forEach(function (value) {
				s = s + value;
			});
			s
		'''
		'forEach keys': '''
			var s = "";
			var map = new Map([["a", 123], ["b", 321]]);
			map.forEach(function (value, key) {
				s = s + key;
			});
			s
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

	'isNaN':
		'number': 'isNaN(123)'
		'NaN': 'isNaN(NaN)'
		'boolean': 'isNaN(false)'
		'string': 'isNaN("asd")'
		'numeric string': 'isNaN("23")'
		'object': 'isNaN({})'
		'null': 'isNaN(null)'
		'undefined': 'isNaN(undefined)'

	'parseFloat':
		'integer': 'parseFloat(123)'
		'float': 'parseFloat(123.456)'
		'NaN': 'parseFloat(NaN)'
		'boolean': 'parseFloat(false)'
		'string': 'parseFloat("asd")'
		'numeric string': 'parseFloat("23")'
		'object': 'parseFloat({})'
		'null': 'parseFloat(null)'
		'undefined': 'parseFloat(undefined)'

	'parseInt':
		'integer': 'parseInt(123)'
		'float': 'parseInt(123.456)'
		'NaN': 'parseInt(NaN)'
		'boolean': 'parseInt(false)'
		'string': 'parseInt("asd")'
		'base 10 string': 'parseInt("23")'
		'base 16 string': 'parseInt("FF", 16)'
		'object': 'parseInt({})'
		'null': 'parseInt(null)'
		'undefined': 'parseInt(undefined)'

	'Number':
		'number': 'Number(123)'
		'NaN': 'Number(NaN)'
		'boolean': 'Number(false)'
		'string': 'Number("asd")'
		'numeric string': 'Number("23")'
		'object': 'Number({})'
		'null': 'Number(null)'
		'undefined': 'Number(undefined)'

	'Boolean':
		'number': 'Boolean(123)'
		'NaN': 'Boolean(NaN)'
		'boolean': 'Boolean(false)'
		'string': 'Boolean("asd")'
		'numeric string': 'Boolean("23")'
		'object': 'Boolean({})'
		'null': 'Boolean(null)'
		'undefined': 'Boolean(undefined)'

	'String':
		'number': 'String(123)'
		'NaN': 'String(NaN)'
		'boolean': 'String(false)'
		'string': 'String("asd")'
		'numeric string': 'String("23")'
		'object': 'String({})'
		'null': 'String(null)'
		'undefined': 'String(undefined)'

window.snippets ?= {}
Object.assign window.snippets, snippets