'use strict'


BOOLEAN = (@value) ->
	return


BOOLEAN::toNumber = ->
	Number @value


BOOLEAN::toBoolean = ->
	@value


BOOLEAN::toString = ->
	String @value


BOOLEAN::isCallable = ->
	false


window.jinter ?= {}
window.jinter.BOOLEAN = BOOLEAN