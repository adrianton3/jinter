'use strict'


generate = {}


generate['Literal'] = do ->
	literals = [
		'0', '1', '2',
		'true', 'false',
		'"a"', '"s"', '"d"',
		'null'
	]

	->
		rand.sample literals


generate['UnaryExpression'] = do ->
	OPERATORS = ['+', '-', '!', 'typeof']

	(level) ->
		operand = generate['Expression'](level + 1)

		operator = rand.sample(OPERATORS)

		"(#{operator} #{operand})"


generate['BinaryExpression'] = do ->
	OPERATORS = ['+', '-', '*', '===', '!==']

	(level) ->
		left = generate['Expression'](level + 1)
		right = generate['Expression'](level + 1)

		operator = rand.sample(OPERATORS)

		"(#{left} #{operator} #{right})"


generate['ConditionalExpression'] = (level) ->
	test = generate['Expression'](level + 1)
	consequent = generate['Expression'](level + 1)
	alternate = generate['Expression'](level + 1)

	"(#{test} ? #{consequent} : #{alternate})"


generate['ArrayExpression'] = (level) ->
	length = rand.randInt 3

	array = []
	for i in [0...length]
		array.push generate['Expression'](level + 1)

	"[#{array.join ','}]"


generate['Expression'] = do ->
	GENERATORS = [
		generate['Literal']
		generate['UnaryExpression']
		generate['BinaryExpression']
		generate['ConditionalExpression']
		generate['ArrayExpression']
	]

	(level) ->
		if level > 5
			generate['Literal']()
		else
			(rand.sample GENERATORS)(level)


generate['ExpressionStatement'] = (level) ->
	generate['Expression'](level)


generate['Statement'] = (level) ->
	generate['ExpressionStatement'](level)


generate['Program'] = ->
	generate['Statement'](0)


rand = null
randomProgram = (_rand) ->
	rand = _rand
	generate['Program']()


window.fuzz ?= {}
window.fuzz.randomProgram = randomProgram