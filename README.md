Jinter is a JavaScript interpreter written in CoffeeScript.

The project's purpose is purely educational.
The evaluator does not cover the whole JavaScript specification but
it covers enough of the language to evaluate itself.

Language constructs supported:

 + literals (numbers, strings, booleans and null)
 + the binary `+`, `-`, `*` operators for strings, numbers and objects with `valueOf`/`toString`
 + `===`, `!==`, `==`, `!=`, `<`, `<=`
 + short circuited `&&`, `||`
 + the unary operators `+`, `-`, `!`, `typeof`
 + if expressions and statements
 + `while`/`for` statements
 + vars, the `=` operator
 + the postfix `++` operator
 + objects, getters and setters
 + function expressions/declarations
 + the `new` operator and `this`
 + prototypes, prototype chains, the non-standard `__proto__`
 + methods on primitives
 + Arrays (`pop`, `push`, `slice`, `join`, `toString`, `forEach`, `map`, `filter`, `reduce`)
 + Maps (`get`, `has`, `set`, `forEach`)
 + `Function::apply`, `Function::call`
 + `Object.create`, `Object.keys`
 + the global `isNaN`, `parseInt`, `parseFloat`, `Number`, `Boolean`, `String`

Check out the full list of test cases [here](http://adrianton3.github.io/jinter/demo/src/demo.html).
In addition, all test cases pass when Jinter evaluates them while being evaluated by Jinter.