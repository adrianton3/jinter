'use strict'


rand = window.fuzz.makeRNG()


generate = {}


generate['Literal'] = do ->
	literals = [
		'2', '3', '5', '7',
		'true', 'false',
		'"a"', '"s"', '"d"',
		'null'
	]

	->
		rand.sample literals


generate['BinaryExpression'] = do ->
	OPERATORS = [
		'+', '-', '*',
		'===', '!==',
	]

	->
		left = generate['Expression']()
		right = generate['Expression']()

		operator = rand.sample(OPERATORS)

		"#{left} #{operator} #{right}"


generate['Expression'] = ->
	if Math.random() < 0.6
		generate['Literal']()
	else
		generate['BinaryExpression']()


generate['ExpressionStatement'] = ->
	generate['Expression']()


generate['Statement'] = ->
	generate['ExpressionStatement']()


generate['Program'] = ->
	generate['Statement']()


window.fuzz ?= {}
window.fuzz.generate = generate