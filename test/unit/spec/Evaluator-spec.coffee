'use strict'


{
	ev
	EMPTY
	UNDEFINED
	processLiterals
	processVars
} = jinter


describe 'ev', ->
	jinterEv = (string) ->
		tree = esprima.parse string
		processLiterals tree
		processVars tree

		result = ev tree, EMPTY

		if result?
			result.asString()
		else
			'undefined'


	jsEv = (string) ->
		result = eval string

		if result == null
			'null'
		else if result == undefined
			'undefined'
		else
			result.toString()


	snippets = window.snippets

	(Object.keys snippets).forEach (title) ->
		its = snippets[title]
		describe title, ->
			(Object.keys its).forEach (text) ->
				spec = its[text]
				it text, ->
					(expect jinterEv spec).toEqual (jsEv spec)
					return
				return
			return
		return