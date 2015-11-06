'use strict'


{
	OBJECT,
	UNDEFINED,
	NULL,
	BOOLEAN,
	NUMBER,
	STRING,
	NATIVE_FUNCTION
} = jinter


WINDOW = new OBJECT NULL


WINDOW.put 'window', WINDOW

WINDOW.put 'undefined', UNDEFINED

WINDOW.put 'Object', jinter.OBJECT_FUNCTION

WINDOW.put 'Map', jinter.MAP_FUNCTION


WINDOW.put 'NaN', new NUMBER NaN

WINDOW.put 'isNaN', new NATIVE_FUNCTION (candidate) ->
	return: true
	value: new BOOLEAN isNaN candidate.toNumber()

WINDOW.put 'parseFloat', new NATIVE_FUNCTION (candidate) ->
	return: true
	value: new NUMBER parseFloat candidate.toString()

WINDOW.put 'parseInt', new NATIVE_FUNCTION (candidate, optionalBase) ->
	candidateValue = candidate.toString()

	value = if optionalBase? and optionalBase != UNDEFINED
		parseInt candidateValue, optionalBase.toNumber()
	else
		parseInt candidateValue

	return: true
	value: value


WINDOW.put 'Number', new NATIVE_FUNCTION (candidate) ->
	return: true
	value: new NUMBER candidate.toNumber()

WINDOW.put 'Boolean', new NATIVE_FUNCTION (candidate) ->
	return: true
	value: new BOOLEAN candidate.toBoolean()

WINDOW.put 'String', new NATIVE_FUNCTION (candidate) ->
	return: true
	value: new STRING candidate.toString()


window.jinter ?= {}
window.jinter.WINDOW = WINDOW