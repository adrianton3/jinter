'use strict'

{ OBJECT, NULL } = jinter


ARRAY = ->
	OBJECT.call @, NULL
	@data = []
	@put 'prototype', new OBJECT NULL
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


window.jinter ?= {}
window.jinter.ARRAY = ARRAY