'use strict'

{ NUMBER, STRING, NULL, UNDEFINED, FUNCTION } = jinter


ev = (exp, env) ->
	throw (new Error 'null env') unless env?
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


Nodes['BlockStatement'] = (exp, env) ->
	for statement in exp.body
		returnCandidate = ev statement, env
		if returnCandidate?.return
			return returnCandidate


Nodes['ReturnStatement'] = (exp, env) ->
	return: true
	value: ev exp.argument, env


Nodes['CallExpression'] = (exp, env) ->
	closure = ev exp.callee, env

	# this
	newEnv = closure.env.con 'this', NULL

	# arguments
	newEnv = exp.arguments.reduce (resultingEnv, argument, index) ->
		name = closure.formalArguments[index]
		value = ev argument, env

		resultingEnv.con name, value
	, newEnv

	# vars
	newEnv = closure.body.vars.reduce (resultingEnv, name) ->
		resultingEnv.con name, UNDEFINED
	, newEnv

	returnCandidate = ev closure.body, newEnv

	if returnCandidate?.return
		returnCandidate.value
	else
		UNDEFINED


Nodes['FunctionDeclaration'] = (exp, env) ->
	formalArguments = exp.params.map (formalArgument) ->
		formalArgument.name

	new FUNCTION exp.body, env, formalArguments


Nodes['FunctionExpression'] = (exp, env) ->
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