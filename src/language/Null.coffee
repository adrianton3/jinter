'use strict'


NULL = {}


NULL.type = 'null'
NULL.typeOf = 'object'


NULL.get = (key) ->
	null


NULL.put = (key, value) ->
	throw new Error "Cannot set property #{key} of null"


NULL.toNumber = ->
	0


NULL.toBoolean = ->
	false


NULL.toString = ->
	'null'


window.jinter ?= {}
window.jinter.NULL = NULL