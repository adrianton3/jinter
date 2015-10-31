'use strict'


{
	EMPTY
	OBJECT
	NUMBER
	BOOLEAN
	STRING
	NULL
	UNDEFINED
	NATIVE_FUNCTION
} = jinter


primitiveToValue = (key) ->
	key.value ? key


valueToPrimitive = (value) ->
	constructor = switch typeof value
		when 'number' then NUMBER
		when 'boolean' then BOOLEAN
		when 'string' then STRING

	new constructor value


MAP_FUNCTION = new NATIVE_FUNCTION (pairsRaw) ->
	map = if pairsRaw?
		pairs = pairsRaw.data.map ({ data: [key, value] }) ->
			[(primitiveToValue key), value]

		new jinter.MAP new Map pairs
	else
		new jinter.MAP new Map

	return: true
	value: map


MAP_PROTOTYPE = new OBJECT NULL

MAP_FUNCTION.put 'prototype', MAP_FUNCTION


get = new NATIVE_FUNCTION (key) ->
	keyValue = primitiveToValue key
	returnValue = if @store.has keyValue
		@store.get keyValue
	else
		UNDEFINED

	return: true
	value: returnValue

MAP_PROTOTYPE.put 'get', get


has = new NATIVE_FUNCTION (key) ->
	return: true
	value: new BOOLEAN @store.has primitiveToValue key

MAP_PROTOTYPE.put 'has', has


set = new NATIVE_FUNCTION (key, value) ->
	@store.set (primitiveToValue key), value

	return: true
	value: @

MAP_PROTOTYPE.put 'set', set


forEach = new NATIVE_FUNCTION (fun, optionalThis) ->
	@store.forEach (value, key) ->
		args = [value, (valueToPrimitive key), @]
		jinter.callRaw fun, optionalThis, args, EMPTY
		return
	, @

	return: true
	value: UNDEFINED

MAP_PROTOTYPE.put 'forEach', forEach


window.jinter ?= {}
window.jinter.MAP_PROTOTYPE = MAP_PROTOTYPE
window.jinter.MAP_FUNCTION = MAP_FUNCTION