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


	for title, its of window.snippets
		do (title, its) ->
			describe title, ->
				for text, spec of its
					do (text, spec) ->
						it text, ->
							(expect jinterEv spec).toEqual (jsEv spec)
							return
				return
	return