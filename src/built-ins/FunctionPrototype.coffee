'use strict'


{
	NULL
	OBJECT
	EMPTY
	NATIVE_FUNCTION
} = jinter


FUNCTION_FUNCTION = new NATIVE_FUNCTION ->
	throw new Error 'Function function not implemented'


FUNCTION_PROTOTYPE = new OBJECT NULL

FUNCTION_FUNCTION.put 'prototype', FUNCTION_PROTOTYPE


apply = new jinter.NATIVE_FUNCTION (thisArgument, args) ->
	jinter.callRaw @, thisArgument, args.data, EMPTY

FUNCTION_PROTOTYPE.put 'apply', apply


call = new jinter.NATIVE_FUNCTION (thisArgument, args...) ->
	jinter.callRaw @, thisArgument, args, EMPTY

FUNCTION_PROTOTYPE.put 'call', call


window.jinter ?= {}
window.jinter.FUNCTION_PROTOTYPE = FUNCTION_PROTOTYPE
window.jinter.FUNCTION_FUNCTION = FUNCTION_FUNCTION