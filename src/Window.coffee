'use strict'


{ OBJECT, UNDEFINED, NULL, NATIVE_FUNCTION } = jinter


WINDOW = new OBJECT NULL

WINDOW.put 'window', WINDOW

WINDOW.put 'undefined', UNDEFINED

WINDOW.put 'Object', jinter.OBJECT_FUNCTION

WINDOW.put 'Map', jinter.MAP_FUNCTION

window.jinter ?= {}
window.jinter.WINDOW = WINDOW