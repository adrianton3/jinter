'use strict'


NULL = {}


NULL.type = 'null'


NULL.get = (key) ->
	null


NULL.put = (key, value) ->
	throw new Error "Cannot set property #{key} of null"


NULL.toNumber = ->
	0


NULL.toBoolean = ->
	true


NULL.toString = ->
	'null'


NULL.isCallable = ->
	false


window.jinter ?= {}
window.jinter.NULL = NULL