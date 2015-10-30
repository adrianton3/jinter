'use strict'


{
	EMPTY
	OBJECT
	NULL
	UNDEFINED
	NUMBER
	STRING
	NATIVE_FUNCTION
} = jinter


ARRAY_PROTOTYPE = new OBJECT NULL

addMethod = ({ name, returnType }) ->
	ARRAY_PROTOTYPE.put name, new NATIVE_FUNCTION ->
		resultRaw = Array::[name].apply @data, arguments

		return: true
		value:
			if returnType?
				new returnType resultRaw
			else
				resultRaw

methods = [
	{ name: 'toString', returnType: STRING }
	{ name: 'slice', returnType: jinter.ARRAY }
	{ name: 'push', returnType: NUMBER }
	{ name: 'pop' }
]

methods.forEach addMethod


ARRAY_PROTOTYPE.put 'length', {
	descriptor: true
	get: new NATIVE_FUNCTION ->
		return: true
		value: new NUMBER @data.length
}


forEach = new NATIVE_FUNCTION (fun, optionalThis) ->
	@data.forEach (element, index) ->
		args = [element, (new NUMBER index), @]
		jinter.callRaw fun, optionalThis, args, EMPTY
		return
	, @

	return: true
	value: UNDEFINED

ARRAY_PROTOTYPE.put 'forEach', forEach


map = new NATIVE_FUNCTION (fun, optionalThis) ->
	results = @data.map (element, index) ->
		args = [element, (new NUMBER index), @]
		jinter.call fun, optionalThis, args, EMPTY
	, @

	return: true
	value: new jinter.ARRAY results

ARRAY_PROTOTYPE.put 'map', map


filter = new NATIVE_FUNCTION (fun, optionalThis) ->
	results = @data.filter (element, index) ->
		args = [element, (new NUMBER index), @]
		result = jinter.call fun, optionalThis, args, EMPTY
		result.toBoolean()
	, @

	return: true
	value: new jinter.ARRAY results

ARRAY_PROTOTYPE.put 'filter', filter


reduce = new NATIVE_FUNCTION (fun, base) ->
	step = (base, element, index) ->
		args = [base, element, (new NUMBER index), @]
		jinter.call fun, NULL, args, EMPTY

	result = if arguments.length == 1
		@data.reduce step
	else
		@data.reduce step, base

	return: true
	value: result

ARRAY_PROTOTYPE.put 'reduce', reduce


window.jinter ?= {}
window.jinter.ARRAY_PROTOTYPE = ARRAY_PROTOTYPE