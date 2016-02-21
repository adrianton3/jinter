'use strict'


{
	OBJECT
	NULL
	NATIVE_FUNCTION
} = jinter


NUMBER_FUNCTION = new NATIVE_FUNCTION (candidate) ->
	return: true
	value: new jinter.NUMBER candidate.asNumber()


NUMBER_PROTOTYPE = new OBJECT NULL

NUMBER_FUNCTION.put 'prototype', NUMBER_PROTOTYPE


window.jinter ?= {}
window.jinter.NUMBER_PROTOTYPE = NUMBER_PROTOTYPE
window.jinter.NUMBER_FUNCTION = NUMBER_FUNCTION