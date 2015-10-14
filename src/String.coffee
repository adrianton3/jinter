'use strict'


STRING = (value) ->
	@value = String value
	return


STRING::type = 'string'


STRING::toNumber = ->
	Number @value


STRING::toBoolean = ->
	Boolean @value


STRING::toString = ->
	@value


STRING::toPrimitive = ->
	@


STRING::isCallable = ->
	false


window.jinter ?= {}
window.jinter.STRING = STRING