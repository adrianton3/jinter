'use strict'


{
	OBJECT,
	UNDEFINED,
	NULL,
	BOOLEAN,
	NUMBER,
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


window.jinter ?= {}
window.jinter.WINDOW = WINDOW