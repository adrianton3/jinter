'use strict'


BOOLEAN = (value) ->
	@value = Boolean value
	return


BOOLEAN::type = 'boolean'
BOOLEAN::typeOf = 'boolean'


BOOLEAN::asNumber = ->
	Number @value


BOOLEAN::asBoolean = ->
	@value


BOOLEAN::asString = ->
	String @value


window.jinter ?= {}
window.jinter.BOOLEAN = BOOLEAN