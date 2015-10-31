'use strict'


{
	EMPTY
	OBJECT
	BOOLEAN
	NULL
	UNDEFINED
	NATIVE_FUNCTION
} = jinter


getKeyValue = (key) ->
	if key.value?
		key.value
	else
		key


MAP_FUNCTION = new NATIVE_FUNCTION (pairsRaw) ->
	map = if pairsRaw?
		pairs = pairsRaw.data.map ({ data: [key, value] }) ->
			[(getKeyValue key), value]

		new jinter.MAP new Map pairs
	else
		new jinter.MAP new Map

	return: true
	value: map


MAP_PROTOTYPE = new OBJECT NULL

MAP_FUNCTION.put 'prototype', MAP_FUNCTION


get = new NATIVE_FUNCTION (key) ->
	keyValue = getKeyValue key
	returnValue = if @store.has keyValue
		@store.get keyValue
	else
		UNDEFINED

	return: true
	value: returnValue

MAP_PROTOTYPE.put 'get', get


has = new NATIVE_FUNCTION (key) ->
	return: true
	value: new BOOLEAN @store.has getKeyValue key

MAP_PROTOTYPE.put 'has', has


set = new NATIVE_FUNCTION (key, value) ->
	store.set (getKeyValue key), value

	return: true
	value: @

MAP_PROTOTYPE.put 'set', set


forEach = new NATIVE_FUNCTION (fun, optionalThis) ->
	@store.forEach (value, key) ->
		args = [value, key, @]
		jinter.callRaw fun, optionalThis, args, EMPTY
		return
	, @

	return: true
	value: UNDEFINED

MAP_PROTOTYPE.put 'forEach', forEach


window.jinter ?= {}
window.jinter.MAP_PROTOTYPE = MAP_PROTOTYPE
window.jinter.MAP_FUNCTION = MAP_FUNCTION