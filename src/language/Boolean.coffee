'use strict'


BOOLEAN = (value) ->
	@value = Boolean value
	return


BOOLEAN::type = 'boolean'
BOOLEAN::typeOf = 'boolean'


BOOLEAN::get = (key) ->
	jinter.BOOLEAN_PROTOTYPE.get key


BOOLEAN::set = ->
	null


BOOLEAN::asNumber = ->
	Number @value


BOOLEAN::asBoolean = ->
	@value


BOOLEAN::asString = ->
	String @value


BOOLEAN::asPrimitive = ->
	@


window.jinter ?= {}
window.jinter.BOOLEAN = BOOLEAN