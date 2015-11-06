'use strict'


{ STRING } = jinter


NUMBER = (value) ->
	@value = Number value
	return


NUMBER::type = 'number'
NUMBER::typeOf = 'number'


NUMBER::toNumber = ->
	@value


NUMBER::toBoolean = ->
	Boolean @value


NUMBER::toString = ->
	String @value


NUMBER::toPrimitive = ->
	@


window.jinter ?= {}
window.jinter.NUMBER = NUMBER