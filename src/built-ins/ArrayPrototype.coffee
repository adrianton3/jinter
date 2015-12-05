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


ARRAY_FUNCTION = new NATIVE_FUNCTION ->
	throw new Error 'Array function not implemented'


ARRAY_PROTOTYPE = new OBJECT NULL

ARRAY_FUNCTION.put 'prototype', ARRAY_PROTOTYPE


slice = new NATIVE_FUNCTION (begin, end) ->
	resultRaw = if arguments.length == 0
		@data.slice()
	else if arguments.length == 1
		@data.slice begin.asNumber()
	else
		@data.slice begin.asNumber(), end.asNumber()

	return: true
	value: new jinter.ARRAY resultRaw

ARRAY_PROTOTYPE.put 'slice', slice


push = new NATIVE_FUNCTION ->
	resultRaw = Array::push.apply @data, arguments

	return: true
	value: new NUMBER resultRaw

ARRAY_PROTOTYPE.put 'push', push


pop = new NATIVE_FUNCTION ->
	result = @data.pop()

	return: true
	value: result

ARRAY_PROTOTYPE.put 'pop', pop


join = new NATIVE_FUNCTION (separator) ->
	value = @data.map (element) ->
		if element == UNDEFINED || element == NULL
			''
		else
			element.asString()
	.join separator.asString()

	return: true
	value: new STRING value

ARRAY_PROTOTYPE.put 'join', join


toString = new NATIVE_FUNCTION ->
	value = @data.map (element) ->
		if element == UNDEFINED || element == NULL
			''
		else
			element.asString()
	.join ',' # spec mentions using join

	return: true
	value: new STRING value

ARRAY_PROTOTYPE.put 'toString', toString


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
		result.asBoolean()
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
window.jinter.ARRAY_FUNCTION = ARRAY_FUNCTION