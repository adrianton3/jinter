// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  var FUNCTION, NULL, OBJECT;

  OBJECT = jinter.OBJECT, NULL = jinter.NULL;

  FUNCTION = function(body, env, formalArguments, ownName) {
    this.body = body;
    this.env = env;
    this.formalArguments = formalArguments;
    this.ownName = ownName;
    OBJECT.call(this, NULL);
    this.put('prototype', new OBJECT(NULL));
  };

  FUNCTION.prototype = Object.create(OBJECT.prototype);

  FUNCTION.prototype.constructor = FUNCTION;

  FUNCTION.prototype.isCallable = function() {
    return true;
  };

  if (window.jinter == null) {
    window.jinter = {};
  }

  window.jinter.FUNCTION = FUNCTION;

}).call(this);
