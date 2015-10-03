'use strict'


{ ev, EMPTY, processLiterals, processVars } = jinter


describe 'ev', ->
	jinterEv = (string) ->
		tree = esprima.parse string
		processLiterals tree
		processVars tree

		result = ev tree, EMPTY

		if result?
			result.toString()
		else
			'undefined'


	jsEv = (string) ->
		result = eval string

		if result?
			result.toString()
		else
			'undefined'


	for title, its of window.snippets
		describe title, ->
			for text, spec of its
				it text, ->
					(expect jinterEv spec).toEqual (jsEv spec)