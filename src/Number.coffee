'use strict'


{ STRING } = jinter


NUMBER = (@value) ->
	return


NUMBER::add = (that) ->
	that.addNumber @


NUMBER::addNumber = (that) ->
	new NUMBER that.toNumber() + @toNumber()


NUMBER::addString = (that) ->
	new STRING that.toString() + @toString()


NUMBER::toNumber = ->
	@value


NUMBER::toBoolean = ->
	Boolean @value


NUMBER::toString = ->
	String @value


NUMBER::isCallable = ->
	false


window.jinter ?= {}
window.jinter.NUMBER = NUMBER