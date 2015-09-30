'use strict'

{
	NUMBER,
	BOOLEAN,
	STRING,
	NULL,
	UNDEFINED,
	FUNCTION,
	OBJECT
} = jinter


ev = (exp, env) ->
	throw (new Error 'null env') unless env?
	Nodes[exp.type] exp, env


Nodes = {}


Nodes['Literal'] = (exp, env) ->
	value = exp.value
	switch exp.dataType
		when 'number'
			new NUMBER value
		when 'boolean'
			new BOOLEAN value
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


Nodes['ConditionalExpression'] = (exp, env) ->
	testResult = ev exp.test, env
	if testResult.toBoolean()
		ev exp.consequent, env
	else
		ev exp.alternate, env


Nodes['VariableDeclaration'] = (exp, env) ->
	exp.declarations.forEach (declaration) ->
		return unless declaration.init?

		name = declaration.id.name
		value = ev declaration.init, env
		env.set name, value

		return
	return


Nodes['AssignmentExpression'] = (exp, env) ->
	if exp.left.type == 'MemberExpression'
		object = ev exp.left.object, env
		name = exp.left.property.name
		value = ev exp.right, env
		object.put name, value
	else
		name = exp.left.name
		value = ev exp.right, env
		env.set name, value

	value


Nodes['BlockStatement'] = (exp, env) ->
	for statement in exp.body
		returnCandidate = ev statement, env
		if returnCandidate?.return
			return returnCandidate


Nodes['ReturnStatement'] = (exp, env) ->
	return: true
	value: ev exp.argument, env


Nodes['ThisExpression'] = (exp, env) ->
	env.get 'this'


Nodes['ObjectExpression'] = (exp, env) ->
	object = new OBJECT NULL

	exp.properties.forEach (property) ->
		name = property.key.name
		value = ev property.value, env
		object.put name, value

	object


Nodes['MemberExpression'] = (exp, env) ->
	object = ev exp.object, env
	object.get exp.property.name


Nodes['CallExpression'] = (exp, env) ->
	# determine if it's a method or a function call
	if exp.callee.type == 'MemberExpression'
		thisArgument = ev exp.callee.object, env
		closure = thisArgument.get exp.callee.property.name
	else
		thisArgument = NULL
		closure = ev exp.callee, env

	# this
	newEnv = closure.env.con 'this', thisArgument

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
	newEnv = exp.vars.reduce (resultingEnv, name) ->
		resultingEnv.con name, UNDEFINED
	, env

	exp.body.reduce (prev, statement) ->
		ev statement, newEnv
	, null


Nodes['ExpressionStatement'] = (exp, env) ->
	ev exp.expression, env


window.jinter ?= {}
window.jinter.ev = ev