// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  var NATIVE_FUNCTION, NULL, OBJECT, UNDEFINED, WINDOW;

  OBJECT = jinter.OBJECT, UNDEFINED = jinter.UNDEFINED, NULL = jinter.NULL, NATIVE_FUNCTION = jinter.NATIVE_FUNCTION;

  WINDOW = new OBJECT(NULL);

  WINDOW.put('window', WINDOW);

  WINDOW.put('undefined', UNDEFINED);

  WINDOW.put('Object', jinter.OBJECT_FUNCTION);

  WINDOW.put('Map', jinter.MAP_FUNCTION);

  if (window.jinter == null) {
    window.jinter = {};
  }

  window.jinter.WINDOW = WINDOW;

}).call(this);
