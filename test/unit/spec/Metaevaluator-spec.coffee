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
} = meta


describe 'ev (meta)', ->
	jsEv = (string) ->
		result = eval string

		if result == null
			'null'
		else if result == undefined
			'undefined'
		else
			result.toString()


	metaEv = null

	beforeAll (done) ->
		getEvaluator().then (evaluator) ->
			metaEv = evaluator
			done()
		return


	snippets = window.snippets

	(Object.keys snippets).forEach (title) ->
		its = snippets[title]
		describe title, ->
			(Object.keys its).forEach (text) ->
				spec = its[text]
				it text, ->
					(expect metaEv spec).toEqual (jsEv spec)