'use strict'

{ OBJECT, NULL, EMPTY, FUNCTION_PROTOTYPE } = jinter


FUNCTION = (@body, @env, @formalArguments, @ownName) ->
	OBJECT.call @, FUNCTION_PROTOTYPE
	@put 'prototype', new OBJECT NULL
	return


FUNCTION:: = Object.create OBJECT::
FUNCTION::constructor = FUNCTION


FUNCTION::typeOf = 'function'


FUNCTION::isCallable = ->
	true


window.jinter ?= {}
window.jinter.FUNCTION = FUNCTION