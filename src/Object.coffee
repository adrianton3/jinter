'use strict'


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


call = (closure, thisArgument) ->
	# handle native functions early
	returnCandidate = if closure.native
		closure.fun.call thisArgument
	else
		newEnv = closure.env.addEntry()

		# this
		newEnv.addBinding 'this', thisArgument

		# vars
		closure.body.vars.forEach (name) ->
			newEnv.addBinding name, UNDEFINED
			return

		# function declarations
		closure.body.functionDeclarations.forEach (node) ->
			name = node.id.name
			closure = jinter.ev node, newEnv
			newEnv.addBinding name, closure
			return

		jinter.ev closure.body, newEnv

	if returnCandidate?.return
		returnCandidate.value
	else
		jinter.UNDEFINED


OBJECT::toNumber = ->
	valueOf = @get 'valueOf'

	if valueOf?.isCallable()
		return call valueOf, @

	toString = @get 'toString'

	if toString?.isCallable()
		return call toString, @

	throw new Error 'Cannot convert object to primitive value'


OBJECT::toBoolean = ->
	true


OBJECT::toString = ->
	toString = @get 'toString'

	if toString?.isCallable()
		return call toString, @

	valueOf = @get 'valueOf'

	if valueOf?.isCallable()
		return call valueOf, @

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