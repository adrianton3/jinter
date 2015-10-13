'use strict'

{ OBJECT, NULL, NATIVE_FUNCTION, STRING, NUMBER } = jinter


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
	{ name: 'slice', returnType: ARRAY }
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


window.jinter ?= {}
window.jinter.ARRAY = ARRAY