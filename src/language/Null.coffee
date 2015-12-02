'use strict'


NULL = {}


NULL.type = 'null'
NULL.typeOf = 'object'


NULL.get = (key) ->
	null


NULL.put = (key, value) ->
	throw new Error "Cannot set property #{key} of null"


NULL.asNumber = ->
	0


NULL.asBoolean = ->
	false


NULL.asString = ->
	'null'


NULL.asPrimitive = ->
	NULL


window.jinter ?= {}
window.jinter.NULL = NULL