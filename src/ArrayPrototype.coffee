'use strict'


{
	EMPTY
	OBJECT
	NULL
	UNDEFINED
	NUMBER
	STRING
	ARRAY
	NATIVE_FUNCTION
} = jinter


ARRAY_PROTOTYPE = new OBJECT NULL

addMethod = ({ name, returnType }) ->
	ARRAY_PROTOTYPE.put name, new NATIVE_FUNCTION ->
		resultRaw = Array::[name].apply @data, arguments

		return: true
		value:
			if returnType?
				new returnType resultRaw
			else
				resultRaw

methods = [
	{ name: 'toString', returnType: STRING }
	{ name: 'slice', returnType: ARRAY }
	{ name: 'push', returnType: NUMBER }
	{ name: 'pop' }
]

methods.forEach addMethod


ARRAY_PROTOTYPE.put 'length', {
	descriptor: true
	get: new NATIVE_FUNCTION ->
		return: true
		value: new NUMBER @data.length
}


forEach = new NATIVE_FUNCTION (fun, optionalThis) ->
	@data.forEach (element, index) ->
		args = [element, (new NUMBER index), @]
		jinter.callRaw fun, optionalThis, args, EMPTY
		return
	, @

	return: true
	value: UNDEFINED


ARRAY_PROTOTYPE.put 'forEach', forEach


window.jinter ?= {}
window.jinter.ARRAY_PROTOTYPE = ARRAY_PROTOTYPE