'use strict'

{ ev, OBJECT } = jinter


FUNCTION = (@body, @env, @formalArgs) ->
	OBJECT.apply @
	return


FUNCTION:: = Object.create OBJECT::
FUNCTION::constructor = FUNCTION


FUNCTION::isCallable = ->
	true


window.jinter ?= {}
window.jinter.FUNCTION = FUNCTION