'use strict'

{ OBJECT } = jinter


FUNCTION = (@body, @env, @formalArguments) ->
	OBJECT.apply @
	return


FUNCTION:: = Object.create OBJECT::
FUNCTION::constructor = FUNCTION


FUNCTION::isCallable = ->
	true


window.jinter ?= {}
window.jinter.FUNCTION = FUNCTION