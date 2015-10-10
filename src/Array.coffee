'use strict'

{ OBJECT, NULL, NATIVE_FUNCTION, STRING } = jinter


ARRAY_PROTOTYPE = new OBJECT NULL

ARRAY_PROTOTYPE.put 'toString', new NATIVE_FUNCTION ->
	resultRaw = Array::toString.apply @data, arguments

	return: true
	value: new STRING resultRaw

ARRAY_PROTOTYPE.put 'slice', new NATIVE_FUNCTION ->
	resultRaw = Array::slice.apply @data, arguments

	return: true
	value: new ARRAY resultRaw


ARRAY = (@data = []) ->
	OBJECT.call @, ARRAY_PROTOTYPE
	@put 'prototype', ARRAY_PROTOTYPE
	return


ARRAY:: = Object.create OBJECT::
ARRAY::constructor = ARRAY


isIntegery = (value) ->
	return if isNaN value

	(parseFloat value) == (parseInt value, 10)


ARRAY::get = (key) ->
	if isIntegery key
		@data[key]
	else
		OBJECT::get.call @, key


ARRAY::put = (key, value) ->
	if isIntegery key
		@data[key] = value
	else
		OBJECT::get.call @, key


ARRAY::toString = ->
	@data.toString()


window.jinter ?= {}
window.jinter.ARRAY = ARRAY