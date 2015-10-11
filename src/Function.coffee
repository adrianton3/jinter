'use strict'

{ OBJECT, NULL, EMPTY } = jinter


FUNCTION_PROTOTYPE = new OBJECT NULL

do ->
	apply = new jinter.NATIVE_FUNCTION (thisArgument, args) ->
		jinter.callRaw @, thisArgument, args.data, EMPTY

	FUNCTION_PROTOTYPE.put 'apply', apply

	call = new jinter.NATIVE_FUNCTION (thisArgument, args...) ->
		jinter.callRaw @, thisArgument, args, EMPTY

	FUNCTION_PROTOTYPE.put 'call', call


FUNCTION = (@body, @env, @formalArguments, @ownName) ->
	OBJECT.call @, FUNCTION_PROTOTYPE
	@put 'prototype', FUNCTION_PROTOTYPE
	return


FUNCTION:: = Object.create OBJECT::
FUNCTION::constructor = FUNCTION


FUNCTION::isCallable = ->
	true


window.jinter ?= {}
window.jinter.FUNCTION = FUNCTION