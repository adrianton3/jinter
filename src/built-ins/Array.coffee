'use strict'

{ OBJECT } = jinter


ARRAY = (@data = []) ->
	OBJECT.call @, jinter.ARRAY_PROTOTYPE
	return


ARRAY:: = Object.create OBJECT::
ARRAY::constructor = ARRAY


isIntegery = (value) ->
	return if isNaN value

	(parseFloat value) == (parseInt value, 10)


ARRAY::get = (key) ->
	if isIntegery key
		@data[key]
	else
		OBJECT::get.call @, key


ARRAY::put = (key, value) ->
	if isIntegery key
		@data[key] = value
	else
		OBJECT::get.call @, key


ARRAY::toString = ->
	@data.toString()


window.jinter ?= {}
window.jinter.ARRAY = ARRAY