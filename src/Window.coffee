'use strict'


{ OBJECT, UNDEFINED, NULL } = jinter


WINDOW = new OBJECT NULL


WINDOW.put 'undefined', UNDEFINED


window.jinter ?= {}
window.jinter.WINDOW = WINDOW