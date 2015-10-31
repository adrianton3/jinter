'use strict'

{
	NUMBER
	BOOLEAN
	STRING
	NULL
	UNDEFINED
	FUNCTION
	OBJECT
	ARRAY
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
		'+': (operand) ->
			new NUMBER operand.toNumber()

		'-': (operand) ->
			new NUMBER -operand.toNumber()

		'!': (operand) ->
			new BOOLEAN !operand.toBoolean()

		'typeof': (operand) ->
			new STRING operand.typeOf


	Nodes['UnaryExpression'] = (exp, env) ->
		operand = ev exp.argument, env

		OPERATORS[exp.operator] operand


do ->
	eqeqeq = (left, right) ->
		if left.type != right.type
			false
		else if left.type in ['number', 'boolean', 'string']
			left.value == right.value
		else if left.type == 'object'
			left == right
		else
			true

	eqeq = (left, right) ->
		if left in [NULL, UNDEFINED] and right in [NULL, UNDEFINED]
			true
		else
			# !!!
			eqeqeq left, right


	OPERATORS =
		'+': (left, right) ->
			leftPrimitive = left.toPrimitive()
			rightPrimitive = right.toPrimitive()

			if leftPrimitive.type == 'string' or rightPrimitive.type == 'string'
				new STRING leftPrimitive.toString() + rightPrimitive.toString()
			else
				new NUMBER leftPrimitive.toNumber() + rightPrimitive.toNumber()

		'-': (left, right) ->
			new NUMBER left.toNumber() - right.toNumber()

		'*': (left, right) ->
			new NUMBER left.toNumber() * right.toNumber()

		'===': (left, right) ->
			new BOOLEAN eqeqeq left, right

		'!==': (left, right) ->
			new BOOLEAN not eqeqeq left, right

		'==': (left, right) ->
			new BOOLEAN eqeq left, right

		'!=': (left, right) ->
			new BOOLEAN not eqeq left, right


	Nodes['BinaryExpression'] = (exp, env) ->
		left = ev exp.left, env
		right = ev exp.right, env

		OPERATORS[exp.operator] left, right


Nodes['LogicalExpression'] = (exp, env) ->
	left = ev exp.left, env
	leftBoolean = left.toBoolean()

	switch exp.operator
		when '&&'
			return left unless leftBoolean
		when '||'
			return left if leftBoolean

	ev exp.right, env


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
	else if exp.alternate?
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


computeMemberKey = (exp, env) ->
	if exp.computed
		(ev exp.property, env).toString()
	else
		exp.property.name


Nodes['AssignmentExpression'] = (exp, env) ->
	if exp.left.type == 'MemberExpression'
		object = ev exp.left.object, env
		key = computeMemberKey exp.left, env
		value = ev exp.right, env

		entry = object.get key
		if entry?.descriptor?
			if entry.set?
				call entry.set, object, [value]
		else
			object.put key, value
	else
		name = exp.left.name
		value = ev exp.right, env
		env.set name, value

	value


Nodes['SequenceExpression'] = (exp, env) ->
	exp.expressions.reduce (prev, expression) ->
		ev expression, env
	, null


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


Nodes['ArrayExpression'] = (exp, env) ->
	array = new ARRAY

	exp.elements.forEach (element, index) ->
		value = ev element, env
		array.put index, value

	array


Nodes['ObjectExpression'] = (exp, env) ->
	object = new OBJECT jinter.OBJECT_PROTOTYPE

	exp.properties.forEach (property) ->
		name = property.key.name
		value = ev property.value, env

		switch property.kind
			when 'get'
				object.defineGet name, value
			when 'set'
				object.defineSet name, value
			else
				object.put name, value

	object


Nodes['MemberExpression'] = (exp, env) ->
	object = ev exp.object, env
	key = computeMemberKey exp, env

	entry = object.get key
	if not entry?
		UNDEFINED
	else if entry.descriptor?
		if entry.get?
			call entry.get, object, []
		else
			UNDEFINED
	else
		entry


callRaw = (closure, thisArgument, args) ->
	# handle native functions early
	if closure.native
		return closure.fun.apply thisArgument, args

	# every function gets its scope
	newEnv = closure.env.addEntry()

	# own name
	if closure.ownName?
		newEnv.addBinding closure.ownName.name, closure

	# this
	newEnv.addBinding 'this', thisArgument

	# arguments
	args.forEach (value, index) ->
		# all parameters must be evaluated but only named
		# ones must be bound in the new environment
		if index < closure.formalArguments.length
			name = closure.formalArguments[index]
			newEnv.addBinding name, value
		return

	# vars
	closure.body.vars.forEach (name) ->
		if not newEnv.entryHas name
			newEnv.addBinding name, UNDEFINED
		return

	# function declarations
	closure.body.functionDeclarations.forEach (node) ->
		name = node.id.name
		closure = ev node, newEnv
		newEnv.addBinding name, closure
		return

	ev closure.body, newEnv


call = (closure, thisArgument, args) ->
	returnCandidate = callRaw closure, thisArgument, args

	if returnCandidate?.return
		returnCandidate.value
	else
		UNDEFINED


callNew = (closure, thisArgument, args, env) ->
	returnCandidate = callRaw closure, thisArgument, args

	if returnCandidate?.return and returnCandidate.value.type == 'object'
		returnCandidate.value
	else
		thisArgument


Nodes['CallExpression'] = (exp, env) ->
	# determine if it's a method or a function call
	if exp.callee.type == 'MemberExpression'
		thisArgument = ev exp.callee.object, env
		key = computeMemberKey exp.callee, env
		closure = thisArgument.get key
	else
		thisArgument = NULL
		closure = ev exp.callee, env

	args = exp.arguments.map (argument) ->
		ev argument, env

	call closure, thisArgument, args


Nodes['NewExpression'] = (exp, env) ->
	closure = ev exp.callee, env

	thisArgument = if closure.native
		null
	else
		new OBJECT closure.get 'prototype'

	args = exp.arguments.map (argument) ->
		ev argument, env

	callNew closure, thisArgument, args


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
	newEnv.addBinding 'this', UNDEFINED

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
window.jinter.callRaw = callRaw
window.jinter.call = call