'use strict'


getVars = (ast) ->
	vars = new Set
	functionDeclarations = new Map
	functions = []

	estraverse.traverse ast, {
		enter: (node, parent) ->
			if node.type in ['FunctionExpression', 'FunctionDeclaration']
				functions.push node.body
				@skip()

		leave: (node, parent) ->
			if node.type == 'VariableDeclarator'
				vars.add node.id.name
			if node.type == 'FunctionDeclaration'
				functionDeclarations.set node.id.name, node
	}

	{
		vars: Array.from vars
		functionDeclarations: Array.from functionDeclarations.values()
		functions
	}


processVars = (ast) ->
	{ vars, functions, functionDeclarations } = getVars ast
	ast.vars = vars
	ast.functionDeclarations = functionDeclarations
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