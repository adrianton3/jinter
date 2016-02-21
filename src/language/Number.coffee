'use strict'


NUMBER = (value) ->
	@value = Number value
	return


NUMBER::type = 'number'
NUMBER::typeOf = 'number'


NUMBER::get = (key) ->
	jinter.NUMBER_PROTOTYPE.get key


NUMBER::set = ->
	null


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