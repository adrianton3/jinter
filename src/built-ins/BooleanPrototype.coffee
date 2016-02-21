'use strict'


{
	OBJECT
	NULL
	NATIVE_FUNCTION
} = jinter


BOOLEAN_FUNCTION = new NATIVE_FUNCTION (candidate) ->
	return: true
	value: new jinter.BOOLEAN candidate.asBoolean()


BOOLEAN_PROTOTYPE = new OBJECT NULL

BOOLEAN_FUNCTION.put 'prototype', BOOLEAN_PROTOTYPE


window.jinter ?= {}
window.jinter.BOOLEAN_PROTOTYPE = BOOLEAN_PROTOTYPE
window.jinter.BOOLEAN_FUNCTION = BOOLEAN_FUNCTION