'use strict'


{ EMPTY } = jinter


OBJECT = (@proto) ->
	@map = new Map
	@extensible = true
	return


OBJECT::type = 'object'


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
		return jinter.call valueOf, @, [], EMPTY

	toString = @get 'toString'

	if toString?.isCallable()
		return jinter.call toString, @, [], EMPTY

	throw new Error 'Cannot convert object to primitive value'


OBJECT::toBoolean = ->
	true


OBJECT::toString = ->
	toString = @get 'toString'

	if toString?.isCallable()
		return jinter.call toString, @, [], EMPTY

	valueOf = @get 'valueOf'

	if valueOf?.isCallable()
		return jinter.call valueOf, @, [], EMPTY

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