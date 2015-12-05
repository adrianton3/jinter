'use strict'

{ OBJECT } = jinter


ARRAY = (@data = []) ->
	OBJECT.call @, jinter.ARRAY_PROTOTYPE
	return


ARRAY:: = Object.create OBJECT::
ARRAY::constructor = ARRAY


ARRAY::class = 'Array'


isNatural = (value) ->
	(not isNaN value) &&
	(parseFloat value) == (parseInt value, 10) &&
	(0 <= value)


ARRAY::get = (key) ->
	if isNatural key
		@data[key]
	else
		OBJECT::get.call @, key


ARRAY::put = (key, value) ->
	if isNatural key
		@data[key] = value
	else
		OBJECT::put.call @, key, value

	return


window.jinter ?= {}
window.jinter.ARRAY = ARRAY