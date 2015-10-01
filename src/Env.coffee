'use strict'


{ UNDEFINED } = jinter


Node = (@parent) ->
	@bindings = new Map
	return


Node::get = (key) ->
	if @bindings.has key
		@bindings.get key
	else
		@parent.get key


Node::set = (key, value) ->
	if @bindings.has key
		@bindings.set key, value
	else
		@parent.set key, value

	return


Node::addEntry = ->
	new Node @


Node::addBinding = (key, value) ->
	@bindings.set key, value


EMPTY =
	get: (key) ->
		throw new Error "Could not find #{key}"

	addEntry: ->
		new Node EMPTY

	addBinding: ->
		new Node EMPTY


window.jinter ?= {}
window.jinter.EMPTY = EMPTY