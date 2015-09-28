'use strict'


Node = (@key, @value, @parent) ->
	return


Node::get = (key) ->
	if @key == key
		@value
	else
		@parent.get key


Node::set = (key, value) ->
	if @key == key
		@value = value
	else
		@parent.get key

	return


Node::con = (key, value) ->
	new Node key, value, @


EMPTY =
	get: (key) ->
		throw new Error "Could not find #{key}"

	con: (key, value) ->
		new Node key, value, EMPTY


window.jinter ?= {}
window.jinter.EMPTY = EMPTY