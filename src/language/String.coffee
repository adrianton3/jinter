'use strict'


STRING = (value) ->
	@value = String value
	return


STRING::type = 'string'
STRING::typeOf = 'string'


STRING::asNumber = ->
	Number @value


STRING::asBoolean = ->
	Boolean @value


STRING::asString = ->
	@value


STRING::asPrimitive = ->
	@


window.jinter ?= {}
window.jinter.STRING = STRING