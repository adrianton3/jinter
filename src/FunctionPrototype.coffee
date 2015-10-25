'use strict'

{ NULL, OBJECT, EMPTY } = jinter


FUNCTION_PROTOTYPE = new OBJECT NULL


apply = new jinter.NATIVE_FUNCTION (thisArgument, args) ->
	jinter.callRaw @, thisArgument, args.data, EMPTY

FUNCTION_PROTOTYPE.put 'apply', apply


call = new jinter.NATIVE_FUNCTION (thisArgument, args...) ->
	jinter.callRaw @, thisArgument, args, EMPTY

FUNCTION_PROTOTYPE.put 'call', call


window.jinter ?= {}
window.jinter.FUNCTION_PROTOTYPE = FUNCTION_PROTOTYPE