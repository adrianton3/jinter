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


Nodes['IfStatement'] = (exp, env) ->
	testResult = ev exp.test, env

	if testResult.toBoolean()
		ev exp.consequent, env
	else
		ev exp.alternate, env


Nodes['WhileStatement'] = (exp, env) ->
	while (ev exp.test, env).toBoolean()
		returnCandidate = ev exp.body, env

		if returnCandidate?.return
			return returnCandidate

	return


Nodes['ForStatement'] = (exp, env) ->
	ev exp.init, env

	while (ev exp.test, env).toBoolean()
		returnCandidate = ev exp.body, env

		if returnCandidate?.return
			return returnCandidate

		ev exp.update, env

	return


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

	# every function gets its scope
	newEnv = closure.env.addEntry()

	# own name
	if closure.ownName?
		newEnv.addBinding closure.ownName.name, closure

	# this
	newEnv.addBinding 'this', thisArgument

	# arguments
	exp.arguments.forEach (argument, index) ->
		value = ev argument, env

		# all parameters must be evaluated but only named
		# ones must be bound in the new environment
		if index < closure.formalArguments.length
			name = closure.formalArguments[index]
			newEnv.addBinding name, value
		return

	# vars
	closure.body.vars.forEach (name) ->
		newEnv.addBinding name, UNDEFINED
		return

	# function declarations
	closure.body.functionDeclarations.forEach (node) ->
		name = node.id.name
		closure = ev node, newEnv
		newEnv.addBinding name, closure
		return

	returnCandidate = ev closure.body, newEnv

	if returnCandidate?.return
		returnCandidate.value
	else
		UNDEFINED


Nodes['NewExpression'] = (exp, env) ->
	closure = ev exp.callee, env
	thisArgument = new OBJECT closure.get 'prototype'

	# every function gets its scope
	newEnv = closure.env.addEntry()

	# own name
	if closure.ownName?
		newEnv.addBinding closure.ownName.name, closure

	# this
	newEnv.addBinding 'this', thisArgument

	# arguments
	exp.arguments.forEach (argument, index) ->
		value = ev argument, env

		# all parameters must be evaluated but only named
		# ones must be bound in the new environment
		if index < closure.formalArguments.length
			name = closure.formalArguments[index]
			newEnv.addBinding name, value
		return

	# vars
	closure.body.vars.forEach (name) ->
		newEnv.addBinding name, UNDEFINED
		return

	# function declarations
	closure.body.functionDeclarations.forEach (node) ->
		name = node.id.name
		closure = ev node, newEnv
		newEnv.addBinding name, closure
		return

	returnCandidate = ev closure.body, newEnv

	if returnCandidate?.return and returnCandidate.value instanceof OBJECT
			returnCandidate.value
	else
		thisArgument


Nodes['FunctionDeclaration'] = (exp, env) ->
	formalArguments = exp.params.map (formalArgument) ->
		formalArgument.name

	new FUNCTION exp.body, env, formalArguments


Nodes['FunctionExpression'] = (exp, env) ->
	formalArguments = exp.params.map (formalArgument) ->
		formalArgument.name

	new FUNCTION exp.body, env, formalArguments, exp.id


Nodes['Program'] = (exp, env) ->
	newEnv = env.addEntry()

	exp.vars.forEach (name) ->
		newEnv.addBinding name, UNDEFINED
		return

	# function declarations
	exp.functionDeclarations.forEach (node) ->
		name = node.id.name
		closure = ev node, newEnv
		newEnv.addBinding name, closure
		return

	exp.body.reduce (prev, statement) ->
		ev statement, newEnv
	, null


Nodes['ExpressionStatement'] = (exp, env) ->
	ev exp.expression, env


window.jinter ?= {}
window.jinter.ev = ev