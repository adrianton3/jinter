'use strict'


getVars = (ast) ->
	vars = []
	functions = []

	estraverse.traverse ast, {
		enter: (node, parent) ->
			if node.type in ['FunctionExpression', 'FunctionDeclaration']
				functions.push node
				@skip()

		leave: (node, parent) ->
			if node.type == 'FunctionExpression'
				vars.push node.id.name
	}

	{ vars, functions }


processVars = (ast) ->
	{ vars, functions } = getVars ast
	ast.vars = vars
	functions.forEach processVars
	return


processLiterals = (ast) ->
	estraverse.traverse ast, {
		enter: (node, parent) ->
			if node.type == 'Literal'
				node.dataType = typeof node.value
	}


window.jinter ?= {}
window.jinter.processVars = processVars
window.jinter.processLiterals = processLiterals