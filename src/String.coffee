'use strict'


STRING = (value) ->
	@value = String value
	return


STRING::type = 'string'
STRING::typeOf = 'string'


STRING::toNumber = ->
	Number @value


STRING::toBoolean = ->
	Boolean @value


STRING::toString = ->
	@value


STRING::toPrimitive = ->
	@


window.jinter ?= {}
window.jinter.STRING = STRING