'use strict'


{ OBJECT, UNDEFINED, NULL, NATIVE_FUNCTION } = jinter


WINDOW = new OBJECT NULL


WINDOW.put 'undefined', UNDEFINED


do ->
	OBJ = new OBJECT NULL

	WINDOW.put 'Object', OBJ

	create = new NATIVE_FUNCTION (proto) ->
		return: true,
		value: new OBJECT proto

	OBJ.put 'create', create


window.jinter ?= {}
window.jinter.WINDOW = WINDOW