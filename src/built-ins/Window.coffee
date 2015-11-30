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


WINDOW.put 'Array', jinter.ARRAY_FUNCTION


WINDOW.put 'Function', jinter.FUNCTION_FUNCTION


WINDOW.put 'NaN', new NUMBER NaN


WINDOW.put 'isNaN', new NATIVE_FUNCTION (candidate) ->
	return: true
	value: new BOOLEAN isNaN candidate.asNumber()


WINDOW.put 'parseFloat', new NATIVE_FUNCTION (candidate) ->
	return: true
	value: new NUMBER parseFloat candidate.asString()


WINDOW.put 'parseInt', new NATIVE_FUNCTION (candidate, optionalBase) ->
	candidateValue = candidate.asString()

	resultRaw = if optionalBase? and optionalBase != UNDEFINED
		parseInt candidateValue, optionalBase.asNumber()
	else
		parseInt candidateValue

	return: true
	value: new NUMBER resultRaw


WINDOW.put 'Number', new NATIVE_FUNCTION (candidate) ->
	return: true
	value: new NUMBER candidate.asNumber()


WINDOW.put 'Boolean', new NATIVE_FUNCTION (candidate) ->
	return: true
	value: new BOOLEAN candidate.asBoolean()


WINDOW.put 'String', new NATIVE_FUNCTION (candidate) ->
	return: true
	value: new STRING candidate.asString()


window.jinter ?= {}
window.jinter.WINDOW = WINDOW