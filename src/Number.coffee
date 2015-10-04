'use strict'


{ STRING } = jinter


NUMBER = (@value) ->
	@type = 'number'
	return


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