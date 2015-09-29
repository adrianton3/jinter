'use strict'


OBJECT = (@proto) ->
	@map = new Map
	@extensible = true
	return


OBJECT::get = (key) ->
	if @map.has key
		@map.get key
	else
		@proto.get key


OBJECT::put = (key, value) ->
	if not @extensible and not @map.has key
		throw new Error "Object is not extensible"
	else
		@map.set key, value


OBJECT::seal = ->
	@extensible = false


OBJECT::toNumber = ->
	valueOf = @get 'valueOf'

	if valueOf?.isCallable()
		return valueOf.call @

	toString = @get 'toString'

	if toString?.isCallable()
		return toString.call @

	throw new Error 'Cannot convert object to primitive value'


OBJECT::toString = ->
	toString = @get 'toString'

	if toString?.isCallable()
		return toString.call @

	valueOf = @get 'valueOf'

	if valueOf?.isCallable()
		return valueOf.call @

	throw new Error 'Cannot convert object to primitive value'


OBJECT::isCallable = ->
	false


window.jinter ?= {}
window.jinter.OBJECT = OBJECT