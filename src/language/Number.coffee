'use strict'


{ STRING } = jinter


NUMBER = (value) ->
	@value = Number value
	return


NUMBER::type = 'number'
NUMBER::typeOf = 'number'


NUMBER::asNumber = ->
	@value


NUMBER::asBoolean = ->
	Boolean @value


NUMBER::asString = ->
	String @value


NUMBER::asPrimitive = ->
	@


window.jinter ?= {}
window.jinter.NUMBER = NUMBER