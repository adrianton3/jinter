'use strict'


{ EMPTY } = jinter


OBJECT = (@proto) ->
	@map = new Map
	@extensible = true
	return


OBJECT::type = 'object'
OBJECT::typeOf = 'object'


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


OBJECT::defineGet = (key, get) ->
	entry = @map.get key
	if entry?.descriptor
		entry.get = get
	else @map.set key,
		descriptor: true
		get: get


OBJECT::defineSet = (key, set) ->
	entry = @map.get key
	if entry?.descriptor
		entry.set = set
	else @map.set key,
		descriptor: true
		set: set


OBJECT::seal = ->
	@extensible = false


OBJECT::asNumberRaw = ->
	valueOf = @get 'valueOf'

	if valueOf?.typeOf == 'function'
		return jinter.call valueOf, @, [], EMPTY

	toString = @get 'toString'

	if toString?.typeOf == 'function'
		return jinter.call toString, @, [], EMPTY

	throw new Error 'Cannot convert object to primitive value'


OBJECT::asNumber = ->
	@asNumberRaw().asNumber()


OBJECT::asBoolean = ->
	true


OBJECT::asStringRaw = ->
	toString = @get 'toString'

	if toString?.typeOf == 'function'
		return jinter.call toString, @, [], EMPTY

	valueOf = @get 'valueOf'

	if valueOf?.typeOf == 'function'
		return jinter.call valueOf, @, [], EMPTY

	throw new Error 'Cannot convert object to primitive value'


OBJECT::asString = ->
	@asStringRaw().asString()


OBJECT::asPrimitive = (prefferedType) ->
	@defaultValue prefferedType


OBJECT::defaultValue = (hint) ->
	if not hint? or hint == 'number'
		@asNumberRaw()
	else
		@asStringRaw()


window.jinter ?= {}
window.jinter.OBJECT = OBJECT