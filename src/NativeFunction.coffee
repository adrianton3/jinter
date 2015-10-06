'use strict'

{ OBJECT, NULL } = jinter


NATIVE_FUNCTION = (@fun) ->
	OBJECT.call @, NULL
	@put 'prototype', new OBJECT NULL

	return


NATIVE_FUNCTION:: = Object.create OBJECT::
NATIVE_FUNCTION::constructor = NATIVE_FUNCTION


NATIVE_FUNCTION::native = true


NATIVE_FUNCTION::isCallable = ->
	true


window.jinter ?= {}
window.jinter.NATIVE_FUNCTION = NATIVE_FUNCTION