'use strict'


UNDEFINED = {}


UNDEFINED.type = 'undefined'
UNDEFINED.typeOf = 'undefined'


UNDEFINED.get = (key) ->
	throw new Error "Cannot read property #{key} of undefined"


UNDEFINED.put = (key, value) ->
	throw new Error "Cannot set property #{key} of undefined"


UNDEFINED.asNumber = ->
	NaN


UNDEFINED.asBoolean = ->
	false


UNDEFINED.asString = ->
	'undefined'


UNDEFINED.asPrimitive = ->
	UNDEFINED


window.jinter ?= {}
window.jinter.UNDEFINED = UNDEFINED