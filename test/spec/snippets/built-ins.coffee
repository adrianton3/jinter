snippets =
	'Object function':
		'is a function defined on window': '''
			typeof Object
		'''
		'can alter object prototypes': '''
			Object.prototype.f = function () { return 123 };
			({}).f()
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

	'Array function':
		'is a function defined on window': '''
			typeof Array
		'''
		'can alter array prototypes': '''
			Array.prototype.f = function () { return 123 };
			[].f()
		'''

	'Array::length':
		'empty arrays': '[].length'
		'non-empty arrays': '[11, 22, 33].length'
		'sparse arrays': '''
				var a = [];
				a[3] = 123;
				a.length
			'''

	'Array::toString':
		'empty array': '[].toString()'
		'array with one element': '''
				[11].toString()
			'''
		'array with more elements': '''
				[11, 22].toString()
			'''
		'calls toString recursively': '''
				[{ toString: function () { return "asd" } }]
			'''
		'null becomes empty string': '''
				[123, null, 321].toString()
			'''
		'undefined becomes empty string': '''
				[123, undefined, 321].toString()
			'''

	'Array::slice':
		'called with no parameters': '''
				[11, 22, 33, 44, 55].slice()
			'''
		'called with one parameter': '''
				[11, 22, 33, 44, 55].slice(2)
			'''
		'called with two parameters': '''
				[11, 22, 33, 44, 55].slice(2, 3)
			'''
		'converts its parameters to numbers': '''
				var begin = { valueOf: function () { return 2 } };
				[11, 22, 33, 44, 55].slice(begin)
			'''

	'Array::push':
		'returns the new array length': '''
				[11, 22, 33, 44, 55].push(66)
			'''
		'called with multiple parameters': '''
				[11, 22, 33, 44, 55].push(66, 77, 88)
			'''
		'original array is modified': '''
				var a = [11, 22, 33, 44, 55];
				a.push(66);
				a
			'''

	'Array::pop':
		'returns the last element': '''
				[11, 22, 33, 44, 55].pop()
			'''
		'original array is modified': '''
				var a = [11, 22, 33, 44, 55];
				a.pop();
				a
			'''

	'Array::forEach':
		'iterates over an array': '''
				var s = 0;
				[11, 22].forEach(function (element) {
					s = s + element;
				});
				s
			'''
		'index argument': '''
				var s = 0;
				[11, 22].forEach(function (element, index) {
					s = s + index;
				});
				s
			'''
		'array argument': '''
				var s = 0;
				[11, 22].forEach(function (element, index, array) {
					s = s + array[index];
				});
				s
			'''
		'optional this': '''
				var s = 0;
				[11, 22].forEach(function (element, index, array) {
					s = s + this;
				}, 123);
				s
			'''

	'Array::map':
		'iterates over an array': '''
				[11, 22].map(function (element) {
					return element * element;
				});
			'''

	'Array::filter':
		'eliminates some elements': '''
				[11, 22, 33, 44].filter(function (element) {
					return element === 22;
				});
			'''
		'eliminates all elements when no return is present': '''
				[11, 22, 33, 44].filter(function (element) {
				});
			'''
		'preserves all elements': '''
				[11, 22, 33, 44].filter(function (element) {
					return true;
				});
			'''

	'Array::reduce':
		'sums up numbers': '''
				[11, 22, 33, 44].reduce(function (base, element) {
					return base + element;
				});
			'''
		'takes an initial value': '''
				[11, 22, 33, 44].reduce(function (base, element) {
					return base + element;
				}, 123);
			'''
		'is called for all elements when the initial value is present': '''
				var calls = 0;
				[11, 22, 33, 44].reduce(function (base, element) {
					calls = calls + 1;
				}, 123);
				calls
			'''
		'skips the first element when the initial value is missing': '''
				var calls = 0;
				[11, 22, 33, 44].reduce(function (base, element) {
					calls = calls + 1;
				});
				calls
			'''

	'Map':
		'is a function defined on window': '''
			typeof Map
		'''
		'constructor without arguments': '''
				var map = new Map;
				map.get(123)
			'''
		'constructor with arguments': '''
				var map = new Map([[123, 'asd'], [321, 'dsa']]);
				map.get(123) + map.get(321)
			'''
		'can alter map prototypes': '''
			Map.prototype.f = function () { return 123 };
			new Map().f()
		'''

	'Map::get':
		'returns undefined if the entry is missing': '''
				var map = new Map;
				map.get(123) === undefined
			'''

	'Map::has':
		'returns true': '''
				var map = new Map;
				map.has(123)
			'''
		'returns false': '''
				var map = new Map([[123, 321]]);
				map.has(123)
			'''

	'Map::set':
		'sets things': '''
				var map = new Map;
				map.set(123, "dsa")
				map.get(123)
			'''
		're-sets things': '''
				var map = new Map([[123, 321]]);
				map.set(123, "asd")
				map.get(123)
			'''

	'Map::forEach':
		'iterates over entries': '''
				var s = 0;
				var map = new Map([["a", 123], ["b", 321]]);
				map.forEach(function (value) {
					s = s + value;
				});
				s
			'''
		'keys': '''
				var s = "";
				var map = new Map([["a", 123], ["b", 321]]);
				map.forEach(function (value, key) {
					s = s + key;
				});
				s
			'''

	'Function function':
		'is a function defined on window': '''
			typeof Function
		'''
		'can alter function prototypes': '''
			Function.prototype.f = function () { return 123 };
			(function () {}).f()
		'''

	'Function::apply':
		'arguments array': '''
				var f = function (a, b) { return a + b };
				f.apply(null, [11, 22])
			'''
		'this': '''
				var f = function (a) { return this + a };
				f.apply(11, [22])
			'''

	'Function::call':
		'arguments': '''
				var f = function (a, b) { return a + b };
				f.call(null, 11, 22)
			'''
		'this': '''
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
		'object with valueOf': 'Number({ valueOf: function () { return 123 } })'
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
		'object with toString': 'String({ toString: function () { return "asd" } })'
		'null': 'String(null)'
		'undefined': 'String(undefined)'


window.snippets ?= {}
Object.assign window.snippets, snippets