'use strict'


{ OBJECT, UNDEFINED, NULL, NATIVE_FUNCTION } = jinter


WINDOW = new OBJECT NULL

WINDOW.put 'window', WINDOW

WINDOW.put 'undefined', UNDEFINED

WINDOW.put 'Object', jinter.OBJECT_FUNCTION

window.jinter ?= {}
window.jinter.WINDOW = WINDOW