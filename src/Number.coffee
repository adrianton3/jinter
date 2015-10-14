'use strict'


{ STRING } = jinter


NUMBER = (value) ->
	@value = Number value
	return


NUMBER::type = 'number'


NUMBER::toNumber = ->
	@value


NUMBER::toBoolean = ->
	Boolean @value


NUMBER::toString = ->
	String @value


NUMBER::toPrimitive = ->
	@


NUMBER::isCallable = ->
	false


window.jinter ?= {}
window.jinter.NUMBER = NUMBER