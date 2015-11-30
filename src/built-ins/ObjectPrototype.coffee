'use strict'


{
	OBJECT
	NULL
	NATIVE_FUNCTION
	STRING
} = jinter


OBJECT_FUNCTION = new NATIVE_FUNCTION ->
	throw new Error 'Object function not implemented'


create = new NATIVE_FUNCTION (proto) ->
	return: true
	value: new OBJECT proto

OBJECT_FUNCTION.put 'create', create


keys = new NATIVE_FUNCTION (obj) ->
	objKeys = []
	obj.map.forEach (value, key) ->
		objKeys.push new STRING key

	return: true
	value: new jinter.ARRAY objKeys

OBJECT_FUNCTION.put 'keys', keys


OBJECT_PROTOTYPE = new OBJECT NULL

OBJECT_FUNCTION.put 'prototype', OBJECT_PROTOTYPE

toString = new NATIVE_FUNCTION ->
	return: true
	value:
		new STRING if @class?
			"[object #{@class}]"
		else
			"[object Object]"

OBJECT_PROTOTYPE.put 'toString', toString


window.jinter ?= {}
window.jinter.OBJECT_FUNCTION = OBJECT_FUNCTION
window.jinter.OBJECT_PROTOTYPE = OBJECT_PROTOTYPE