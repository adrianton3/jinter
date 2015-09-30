'use strict'

{ OBJECT, NULL } = jinter


FUNCTION = (@body, @env, @formalArguments) ->
	OBJECT.call @, NULL
	@put 'prototype', new OBJECT NULL
	return


FUNCTION:: = Object.create OBJECT::
FUNCTION::constructor = FUNCTION


FUNCTION::isCallable = ->
	true


window.jinter ?= {}
window.jinter.FUNCTION = FUNCTION