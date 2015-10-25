'use strict'


BOOLEAN = (value) ->
	@value = Boolean value
	return


BOOLEAN::type = 'boolean'
BOOLEAN::typeOf = 'boolean'


BOOLEAN::toNumber = ->
	Number @value


BOOLEAN::toBoolean = ->
	@value


BOOLEAN::toString = ->
	String @value


window.jinter ?= {}
window.jinter.BOOLEAN = BOOLEAN