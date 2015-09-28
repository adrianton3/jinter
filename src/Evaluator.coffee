'use strict'

{ NUMBER, STRING, NULL } = jinter


ev = (exp, env) ->
	Nodes[exp.type] exp, env


Nodes = {}


Nodes['Literal'] = (exp, env) ->
	value = exp.value
	switch exp.dataType
		when 'number'
			new NUMBER value
		when 'string'
			new STRING value
		when 'object'
			NULL


Nodes['Identifier'] = (exp, env) ->
	env.get exp.name


do ->
	OPERATORS =
		'+': (e1, e2) -> e1.add e2
		'-': (e1, e2) -> e1.sub e2
		'*': (e1, e2) -> e1.mul e2


	Nodes['BinaryExpression'] = (exp, env) ->
		left = ev exp.left, env
		right = ev exp.right, env

		OPERATORS[exp.operator] left, right


Nodes['VariableDeclaration'] = (exp, env) ->
	exp.declarations.forEach (declaration) ->
		return unless declaration.init?

		name = declaration.id.name
		value = ev declaration.init
		env.set name, value

		return
	return


Nodes['CallExpression'] = (exp, env) ->
	closure = ev exp.callee

	env = exp.arguments.reduce (argument, env, index) =>
		env.con 'this', NULL

		name = closure.formalArguments[index]
		value = ev argument, @env

		env.con name, value
	, @env

	ev closure.body, closure.env


Nodes['FunctionDeclaration'] = (exp, env) ->
	formalArguments = exp.params.map (formalArgument) ->
		formalArgument.name

	new FUNCTION exp.body, env, formalArguments


Nodes['Program'] = (exp, env) ->
	exp.body.reduce (prev, statement) ->
		ev statement, env
	, null


Nodes['ExpressionStatement'] = (exp, env) ->
	ev exp.expression, env


window.jinter ?= {}
window.jinter.ev = ev