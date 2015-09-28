'use strict'


UNDEFINED = {}


UNDEFINED.get = (key) ->
	throw new Error "Cannot read property #{key} of undefined"


UNDEFINED.put = (key, value) ->
	throw new Error "Cannot set property #{key} of undefined"


UNDEFINED.toNumber = ->
	NaN


UNDEFINED.toString = ->
	'undefined'


UNDEFINED.isCallable = ->
	false


window.jinter ?= {}
window.jinter.UNDEFINED = UNDEFINED