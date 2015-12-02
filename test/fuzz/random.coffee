'use strict'


makeRNG = (
	a = 1140671485,
	c = 12820163,
	m = Math.pow(2, 24)
	initialX = 103
) ->
	x = initialX

	randRaw = ->
		x = (x * a + c) % m

	rand = ->
		randRaw() / m

	randInt = (max) ->
		randRaw() % max

	sample = (array) ->
		array[randInt array.length]

	{
		randRaw
		rand
		randInt
		sample
	}


window.fuzz ?= {}
window.fuzz.makeRNG ?= makeRNG