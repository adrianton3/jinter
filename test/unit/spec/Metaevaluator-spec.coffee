'use strict'


{
	ev
	EMPTY
	UNDEFINED
	processLiterals
	processVars
} = jinter

{
	getEvaluator
	metaEval
} = meta


describe 'ev', ->
	jsEv = (string) ->
		result = eval string

		if result == null
			'null'
		else if result == undefined
			'undefined'
		else
			result.toString()


	beforeAll (done) ->
		getEvaluator().then (evaluator) ->
			metaEval = metaEval evaluator
			done()
		return


	for title, its of window.snippets
		do (title, its) ->
			describe title, ->
				for text, spec of its
					do (text, spec) ->
						it text, ->
							(expect metaEval spec).toEqual (jsEv spec)
							return
				return
	return