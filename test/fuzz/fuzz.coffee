'use strict'


wrapTryCatch = (fun) ->
	->
		try
			result = fun.apply @, arguments
			return { result }
		catch reason
			return { reason }


jinterEv = (string) ->
	tree = esprima.parse string
	jinter.processLiterals tree
	jinter.processVars tree

	result = jinter.ev tree, jinter.EMPTY

	if result?
		result.asString()
	else
		'undefined'


wrappedJinterEv = wrapTryCatch jinterEv


jsEv = (string) ->
	result = eval string

	if result == null
		'null'
	else if result == undefined
		'undefined'
	else
		result.toString()


wrappedJsEv = wrapTryCatch jsEv


run = (times) ->
	seed = Math.floor Math.random() * 100000
	console.log 'seed', seed
	rand = window.fuzz.makeRNG seed

	for i in [1..times]
		program = fuzz.randomProgram(rand)

		{ result: jinterResult, reason: jinterReason } = wrappedJinterEv program
		{ result: jsResult, reason: jsReason } = wrappedJsEv program

		if jinterResult?
			if jsResult? and jinterResult != jsResult
				console.error 'expected', program, 'to evaluate to', jsResult, 'but it evaluated to', jinterResult
			else if jsReason?
				console.error 'expected', program, 'to throw but it evaluated to', jinterResult
		else
			if jsResult?
				console.error 'expected', program, 'to evaluate to', jsResult, 'but it threw'
			else
				console.warn 'both evaluators threw for', program, 'but cannot compare exceptions (yet)'

	console.log 'done'
	return

run(1000)