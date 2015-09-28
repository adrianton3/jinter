'use strict'


STRING = (@value) ->
	return


STRING::add = (that) ->
	that.addString @


STRING::addNumber = (that) ->
	new STRING that.toString() + @toString()


STRING::addString = (that) ->
	new STRING that.toString() + @toString()


STRING::toNumber = ->
	parseFloat @value


STRING::toString = ->
	@value


STRING::isCallable = ->
	false


window.jinter ?= {}
window.jinter.STRING = STRING