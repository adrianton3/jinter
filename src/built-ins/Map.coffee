'use strict'

{ OBJECT } = jinter


MAP = (@store = new Map) ->
	OBJECT.call @, jinter.MAP_PROTOTYPE
	return


MAP:: = Object.create OBJECT::
MAP::constructor = MAP


window.jinter ?= {}
window.jinter.MAP = MAP