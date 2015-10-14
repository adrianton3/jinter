'use strict'


BOOLEAN = (value) ->
	@value = Boolean value
	return


BOOLEAN::type = 'boolean'


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