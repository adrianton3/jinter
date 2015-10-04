'use strict'


OBJECT = (@proto) ->
	@map = new Map
	@extensible = true
	@type = 'object'
	return


OBJECT::get = (key) ->
	if key == '__proto__'
		@proto
	else if @map.has key
		@map.get key
	else
		@proto.get key


OBJECT::put = (key, value) ->
	if key == '__proto__'
		@proto = value
		return

	if not @extensible and not @map.has key
		throw new Error "Object is not extensible"

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


OBJECT::toBoolean = ->
	true


OBJECT::toString = ->
	toString = @get 'toString'

	if toString?.isCallable()
		return toString.call @

	valueOf = @get 'valueOf'

	if valueOf?.isCallable()
		return valueOf.call @

	throw new Error 'Cannot convert object to primitive value'


OBJECT::toPrimitive = (prefferedType) ->
	@defaultValue prefferedType


OBJECT::defaultValue = (hint) ->
	if not hint? or hint == 'number'
		@toNumber()
	else
		@toString()


OBJECT::isCallable = ->
	false


window.jinter ?= {}
window.jinter.OBJECT = OBJECT