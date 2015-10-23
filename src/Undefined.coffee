'use strict'


UNDEFINED = {}


UNDEFINED.type = 'undefined'
UNDEFINED.typeOf = 'undefined'


UNDEFINED.get = (key) ->
	throw new Error "Cannot read property #{key} of undefined"


UNDEFINED.put = (key, value) ->
	throw new Error "Cannot set property #{key} of undefined"


UNDEFINED.toNumber = ->
	NaN


UNDEFINED.toBoolean = ->
	false


UNDEFINED.toString = ->
	'undefined'


UNDEFINED.isCallable = ->
	false


window.jinter ?= {}
window.jinter.UNDEFINED = UNDEFINED