'use strict'


{
	OBJECT
	NULL
	NATIVE_FUNCTION
} = jinter


STRING_FUNCTION = new NATIVE_FUNCTION (candidate) ->
	return: true
	value: new jinter.STRING candidate.asString()


STRING_PROTOTYPE = new OBJECT NULL

STRING_FUNCTION.put 'prototype', STRING_PROTOTYPE


window.jinter ?= {}
window.jinter.STRING_PROTOTYPE = STRING_PROTOTYPE
window.jinter.STRING_FUNCTION = STRING_FUNCTION